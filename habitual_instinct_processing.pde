import codeanticode.syphon.*;

import com.pubnub.api.*;
import processing.serial.*;
import peasy.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

AudioOutput out;
boolean audio = false;
int audioDelay = 50;

boolean load_history = true;

boolean logDataStream = false;
String debug_string = "";

// true = arraylist
// false = array
boolean arraylist_or_array = false;
int array_size = 84;
int cols, rows;

PeasyCam cam;
ParticleSystem ps;
SyphonServer server;

PFont    axisLabelFont;
PVector  axisXHud;
PVector  axisYHud;
PVector  axisZHud;
PVector  axisOrgHud;

boolean showOriginBox = true;
boolean autoCameraZoom = true;

float a = 0.0;
long lastCamUpdate = 0;
long updateCamInterval = 25;

int get_history_num = 100;
int maxSystemIndex = get_history_num;
int systemIndex = 0;
int systemIndexMultiplier = 10;
float camRotateSpeed = 0.5;
Pubnub pubnub;

long lastUpdate = 0;
long updateInterval = 60000;
//long updateInterval = 10000;

// For saving files
int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.

boolean particleFade = true;

import controlP5.*;
ControlFrame cf;

String pub;
String sub;

Table table;

void settings() {
  size(800, 600, P3D);
  //fullScreen(P3D);
  PJOGL.profile=1;
  
  // Load Keys
  String lines[] = loadStrings("keys.txt");
  pub = lines[0];
  sub = lines[1];
  pubnub = new Pubnub(pub, sub);
  
  // create sensor pos table
  createSensorLocationtable();
}

void setup()
{
  server = new SyphonServer(this, "Processing Syphon");
  // TODO, re-add controlframe
  // removing for now
  //========
  //cf = new ControlFrame(this, 400, 800, "Controls");
  //surface.setLocation(420, 10);
  //========
  
  frameRate(20);
  lights();
  sphereDetail(2);
  
  // removed audio sound for now
  // =========
  //Minim minim = new Minim( this );
  //out = minim.getLineOut();
  //out.setTempo( 80 );
  
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(1500);
  
  axisLabelFont = createFont( "Arial", 14 );
  axisXHud      = new PVector();
  axisYHud      = new PVector();
  axisZHud      = new PVector();
  axisOrgHud    = new PVector();
  
  // true = arraylist
  // false = array
  if(arraylist_or_array == true){
    ps = new ParticleSystem(new PVector(width/2, get_history_num), maxSystemIndex, systemIndexMultiplier);
  } else {
    // cols = maxSystemIndex;
    // rows = array_size;

    cols = maxSystemIndex;
    rows = array_size;

    //array_points = new int[cols][rows];
    ps = new ParticleSystem(new PVector(width/2, get_history_num), maxSystemIndex, systemIndexMultiplier);
    ps.setArrayVars(cols, rows);
  }
  
  try {
    pubnub.subscribe("habitual_instinct_app", new Callback() {
      @Override
      public void connectCallback(String channel, Object message) {}

      @Override
      public void disconnectCallback(String channel, Object message) {
        System.out.println("SUBSCRIBE : DISCONNECT on channel:" + channel
          + " : " + message.getClass() + " : "
          + message.toString());
      }

      public void reconnectCallback(String channel, Object message) {
        System.out.println("SUBSCRIBE : RECONNECT on channel:" + channel
          + " : " + message.getClass() + " : "
          + message.toString());
      }

      @Override
      public void successCallback(String channel, Object message) {
        System.out.println("SUBSCRIBE : " + channel + " : "
          + message.getClass() + " : " + message.toString());
          //printString(message.toString());
          parseString(message.toString());
      }

      @Override
      public void errorCallback(String channel, PubnubError error) {
        System.out.println("SUBSCRIBE : ERROR on channel " + channel
          + " : " + error.toString());
      }
    });
    
    // Get the last nnn scanns to pre-populate the screen on start up
    Callback callback = new Callback() {
      public void successCallback(String channel, Object response) {
        
        String r_string = response.toString();
        String[] tmp = split(r_string, "[[");
        String[] tmp_2 = split(tmp[1], "]");
        String[] split_array = split(tmp_2[0], ",");
        
        int i;
        int history_array_length = split_array.length;
        for(i = 0; i < history_array_length; i++){
          // print out the raw data straight from the pubnub
          // and see what it might be
          // println(split_array[i]);
          parseString(split_array[i].toString());
        }
        
      }
      public void errorCallback(String channel, PubnubError error) {
        System.out.println(error.toString());
      }
    };
    
    if(load_history){
      pubnub.history("habitual_instinct_app", get_history_num, false, callback);
      
    }
  
  } 
  catch (PubnubException e) {
    System.out.println(e.toString());
  }

  delay(1000);
  println("done");
}

void printString(String data){
  println("--- " + data);
}

void setSystemIndex(){
  if(systemIndex < maxSystemIndex){
    systemIndex++;
  } else {
    systemIndex = 1;
  }
  println("systemIndex: " + systemIndex);
}

void parseString(String str)
{
  
  if(str.length() < 15){
    return;
  }
  
  if(logDataStream){
    debug_string = str;
  }
  
  
  // todo
  // set the panel id
  
  String[] list;
  int panel_id;
  if(str.indexOf("_") > 0){
    println(str);
    String[] panel_split = split(str, '_'); 
    String[] panel_split2 = split(panel_split[0], '"'); 
    
    panel_id = int(panel_split2[1]);
    list = split(panel_split[1], '/');
    
    println("panel id: " + panel_id);
    println(panel_split[1]);
    println("^^^^^^^^^^^^^^^^^^");
  } else {
    // check for weird text accidently saved via node
    str.replaceAll("\"", "");
   
    // makes sure that the first character is a number and 
    // not some weird string saved in node from serial garbage
    // ========
    if(int(str) > 0){
      // this is for legacy data, 
      panel_id = 0;
      list = split(str, '/');
    } else {
      // this means there's garbage data here
      return;
    }
  }
  
  // only increment after we know the data is good 
  setSystemIndex();
  ps.setParticleFade(particleFade);
  
  int i;
  int lst_lngth = list.length;
  
  int r_1 = 0;
  int r_2 = 0;
  
  for (i = 0; i < lst_lngth - 1; i++) {
    String[] reading = split(list[i], ':');
    int rdnglngth = reading.length;
    
    if(rdnglngth < 2 || rdnglngth > 3){
      if(audio){
        // println("r_1: ");
        // println(r_1);
        out.playNote( 0.0, 5.0, map(r_1, 0, 15000, 70, 250));
        out.playNote( 2.5, 5.0, map(r_2, 0, 15000, 70, 250));
      }
      return;
    }

    if(reading.length > 3){
      print("Weird shit happens... string to long");
    }
    
    // only bring values greater then 0
    if(int(reading[2]) > 0){
      ps.origin.set(0, 0, systemIndex * systemIndexMultiplier);

      if(arraylist_or_array == true){
        ps.addParticle(int(reading[0]), int(reading[1]), int(reading[2]));
      } else {
        ps.update_particle((int)systemIndex, (int)i, int(reading[0]), int(reading[1]), int(reading[2]));
        
        if(particleFade == true){
          ps.updateParticleFade(systemIndex);
        }
      }
      
      if(audio){
        r_1 += int(reading[1]);
        r_2 += int(reading[2]);
        
        //out.playNote( 0.0, 3.0, map(int(reading[1]), 0, 400, 80, 140));
        //out.playNote( 0.0, 3.0, map(int(reading[2]), 0, 400, 80, 140));
      }
    }
  }
}

void draw()
{
  background(0);
  toggleCursor();
  
  cam.rotateY(radians(camRotateSpeed));
  
  if(autoCameraZoom){
    if((millis() - lastCamUpdate) > updateCamInterval){
      lastCamUpdate = millis();
      a += 0.005;
      double d2 = 100 + (sin(a + PI/2) * 1500/2) + 1500/2;
      cam.setDistance((double)d2);
      //println("cam.getDistance(): " + cam.getDistance());
    }

  }
  
  if(arraylist_or_array == true){
    // run the Realtime Particle System
    ps.run();
  } else {
    // setSystemIndex();
    ps.run_array();
  }
  
  if(showOriginBox){
    box(10,10,10);
    calculateAxis(get_history_num);
    
    cam.beginHUD();
      drawAxis( 2 );
    cam.endHUD();
  }
  
  
  if(logDataStream){
    cam.beginHUD();
      fill(255, 255, 255);
      textSize(20);
      text(debug_string, 10, 30);
    cam.endHUD();
  }
  server.sendScreen();
  
  if((millis() - lastUpdate) > updateInterval){
    lastUpdate = millis();
    int s = second();
    int m = minute();
    int h = hour();
    String tmp_time_stamp = d + "_" + m + "_" + y + "__" + h + "_" + m + "_" + s;
    String filename = "./../data/habitual_instinct_" + tmp_time_stamp + ".png";
    saveFrame(filename);
  }
  
}

boolean cursorState = true;

void toggleCursor(){
  if (mousePressed == true) {
    cursorState = !cursorState;
    //if(cursorState){
    //  cursor(HAND);
    //} else {
    //  noCursor();
    //}
    
  }
}

void keyPressed() {
  if (key == CODED) {
    
  } else if (key == 'o'){
    showOriginBox = !showOriginBox;
  } else if(key == 'd'){
    autoCameraZoom = !autoCameraZoom;
  } else if(key == 'a'){
    audio = !audio;
  } else if(key == 'l'){
    logDataStream = !logDataStream;
  } else if(key == 'f'){
    particleFade = !particleFade;
  }
  
}

// ------------------------------------------------------------------------ //
void calculateAxis( float length )
{
   // Store the screen positions for the X, Y, Z and origin
   axisXHud.set( screenX(length,0,0), screenY(length,0,0), 0 );
   axisYHud.set( screenX(0,length,0), screenY(0,length,0), 0 );     
   axisZHud.set( screenX(0,0,length), screenY(0,0,length), 0 );
   axisOrgHud.set( screenX(0,0,0), screenY(0,0,0), 0 );
}

// ------------------------------------------------------------------------ //
void drawAxis( float weight )
{
   pushStyle();   // Store the current style information

      strokeWeight( weight );      // Line width
      stroke( 255,   0,   0 );     // X axis color (Red)
      line( axisOrgHud.x, axisOrgHud.y, axisXHud.x, axisXHud.y );
       
      stroke(   0, 255,   0 );
      line( axisOrgHud.x, axisOrgHud.y, axisYHud.x, axisYHud.y );
      
      stroke(   0,   0, 255 );
      line( axisOrgHud.x, axisOrgHud.y, axisZHud.x, axisZHud.y );
          
      fill(255);                   // Text color
      textFont( axisLabelFont );   // Set the text font
      
      text( "X", axisXHud.x, axisXHud.y );
      text( "Y", axisYHud.x, axisYHud.y );
      text( "Z", axisZHud.x, axisZHud.y );

   popStyle();    // Recall the previously stored style information
}


PVector getPosForObject(){
  
  
  PVector sensorPos = new PVector(40, 20);
  
  return sensorPos;
} 

void createSensorLocationtable(){
  table = new Table();
  
  float startX = 3.0;
  float startY = 2.5;
  
  float currentX = startX;
  float currentY = startY;
  
  float xStep = 7.0;
  float yStep = 8.0;

  table.addColumn("id");
  table.addColumn("x");
  table.addColumn("y");
  table.addColumn("z");

  TableRow newRow = table.addRow();
  
  for (int i = 0; i <= 20; i++) {
    
    if(i > 0){
      newRow = table.addRow();
    }
    
    newRow.setInt("id", i);
    newRow.setFloat("x", currentX);
    newRow.setFloat("y", currentY);
    newRow.setFloat("z", 0);
    
    currentX += xStep;
    
    if (i == 4){
      currentX = 6.0;
      currentY += yStep;
    }
    
    if (i == 7){
      currentX = 3.0;
      currentY += yStep;
    }
    
    if (i == 10){
      currentX = 31.0;
      currentY = startY;
    }
    
    if (i == 13){
      currentX = 27.0;
      currentY += yStep;
    }
    
    if (i == 16){
      currentX = 24.0;
      currentY += yStep;
    }
    
  }
  
  saveTable(table, "data/xy_pos.csv");
}