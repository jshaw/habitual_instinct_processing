class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  //PShape star;
  
  Particle[][] array_points;

  int cols;
  int rows;
  boolean particleFade = false;
  
  ParticleSystem(PVector location, int msi, int sim){
    origin = location.get();
    particles = new ArrayList<Particle>();
    maxSystemIndex = msi;
    systemIndexMultiplier = sim;
  }
  
  void addParticle(int idx, int angle, int distance){
    int angle_tmp = 0;
    
    // Don't need this. it was a bug and didn't display the full 180 data set
    //if(int(angle) > 90){
    //  //angle_tmp = angle - 90;
    //  angle_tmp = angle;
    //} else {
    //  angle_tmp = angle;
    //}
    angle_tmp = angle;
    
    float rad_conversion = radians(angle_tmp);
    float sin_rad_90 = sin(radians(90)); 
    
    //// http://cossincalc.com/#angle_a=52&side_a=&angle_b=&side_b=&angle_c=90&side_c=124&angle_unit=degree
    //int answr = int(obj_height/cos(rad_conversion));
    float b = 180 - angle_tmp - 90;
    float answr = (sin(rad_conversion) * distance) / sin_rad_90;
    float answr_length = (sin(radians(b)) * distance ) / sin_rad_90;
    
    //if(int(angle_tmp) > 90){
    //  answr = answr * -1;
    //}
    float zpos = (origin.z - ((maxSystemIndex * systemIndexMultiplier) / 2)) * -1;
    particles.add(new Particle(new PVector(answr_length, answr, zpos)));
  }
  
  void setArrayVars(int columns, int rws){
    cols = columns;
    rows = rws;

    array_points = new Particle[cols][rows];
    
    int y, x;
    for (y = 0; y < cols; y++){
      //float xoff = 0;
      for (x = 0; x < rows; x++){
        //array_points[x][y] = (int)random(-10, 10);
          float angle_tmp = (float)random(0, 180);
          float distance = (float)random(5, 400);
        
          float rad_conversion = radians(angle_tmp);
          float sin_rad_90 = sin(radians(90)); 
          
          //// http://cossincalc.com/#angle_a=52&side_a=&angle_b=&side_b=&angle_c=90&side_c=124&angle_unit=degree
          //int answr = int(obj_height/cos(rad_conversion));
          float b = 180 - angle_tmp - 90;
          float answr = (sin(rad_conversion) * distance) / sin_rad_90;
          float answr_length = (sin(radians(b)) * distance ) / sin_rad_90;
          
          //if(int(angle) > 90){
          //  answr = answr * -1;
          //}
          // float zpos = (origin.z - ((maxSystemIndex * systemIndexMultiplier) / 2)) * -1;
          // println("origin.z: ");
          // println(origin.z);
          
          float zpos = (((cols * systemIndexMultiplier) / 2)) * -1 + (y * systemIndexMultiplier);
          //float zpos = 0.0;
        
          // array_points[y][x] = new Particle(new PVector(answr_length, answr, zpos));
          //array_points[y][x] = new Particle(new PVector(x * systemIndexMultiplier, y * systemIndexMultiplier, zpos));
          //array_points[y][x] = new Particle(new PVector(x * systemIndexMultiplier, y * systemIndexMultiplier, zpos));
          
          array_points[y][x] = new Particle(new PVector(x * systemIndexMultiplier, y * systemIndexMultiplier, zpos));



          // array_points[x][y] = new Particle(new PVector(answr_length, answr, zpos));
        //array_points[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
        //xoff +=0.1;
      }
      //yoff +=0.1;
    }
  }
  
  void run(){
    int i = 0;
    int psize = particles.size()-1;
    // also testing pshapes vs. spheres for partlices
    // =========
    //star = createShape();
    //star.beginShape();
    //star.fill(102);
    //star.stroke(255);
    //star.strokeWeight(2);
    
      for(i = psize; i>=0; i--){
        Particle p = particles.get(i);
        p.run();
        if(p.isDead()){
          particles.remove(i);
        }
        
        //PVector location = p.getLocation();
        //println(location);
        //if(p.isDead()){
        //  particles.remove(i);
        //} else {
        //  star.vertex(location.x, location.y, location.z);
        //}
        
      }
    //star.endShape(CLOSE);
  }

  void update_particle(int col, int row, int index, int x, int y){
    //println(col);
    //println(row);
    if(col < cols && row < rows){
      int angle_tmp = x;
      int distance = y;
      float rad_conversion = radians(angle_tmp);
      float sin_rad_90 = sin(radians(90)); 
      
      float b = 180 - angle_tmp - 90;
      float answr = (sin(rad_conversion) * distance) / sin_rad_90;
      float answr_length = (sin(radians(b)) * distance ) / sin_rad_90;
      array_points[col][row].updateVector((int)answr, (int)answr_length);
      array_points[col][row].updateTransparent();
      // int y, x;
      // for (y = 0; y < rows; y++){
      //   //float xoff = 0;
      //   for (x = 0; x < cols; x++){
      //     Particle p = array_points[x][y];
      //     p.run();
      //   }
      // }
    }
  }
  
  void run_array(){ 
    int y, x;
    for (y = 0; y < cols; y++){
      //float xoff = 0;
      // origin.set(0, 0, y * systemIndexMultiplier);

      for (x = 0; x < rows; x++){
        Particle p = array_points[y][x];
        
        // for the most part, this shoudl be commented out,
        // this is cause i only want the particles to udpate when a 
        // new data stream is read
        // p.updateVector((int)random(0, 180), (int)random(5, 400));
        p.run();
        p.setParticleFade(particleFade);
      }
    }
  }
  
  // this is the todo, also 
  // if particle fade is implemented, it will need to have a way to reset the particle whenever it 
  // has a transparency that is very low
  void setParticleFade(boolean pf){
    particleFade = pf;
  }
   
  void updateParticleFade(int columnIndex){
    if(particleFade == true){
      int x;
      //println("columnIndex" + columnIndex);
      //println("array_points" + array_points.length);
      //int tmp_length = array_points[columnIndex].length;
      //println(tmp_length);
      for(x = 0; x < rows; x++){
        Particle p = array_points[columnIndex-1][x];
        //println("index:" + p);
        p.updateParticleAlpha();
      }
    }
  }
  
}