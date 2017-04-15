
// CONTROL WINDOW
// ==================
class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);
    
    cp5.addToggle("cursorState")
       .plugTo(parent, "cursorState")
       .setPosition(20, 20)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("saveFrame")
       .plugTo(parent, "saveFrame")
       .setPosition(90, 20)
       .setSize(50, 50)
       .setValue(false);

    cp5.addToggle("showOriginBox")
      .plugTo(parent, "showOriginBox")
      .setPosition(160, 20)
      .setSize(50, 50)
      .setValue(true);

    cp5.addToggle("run_test_data")
       .plugTo(parent, "run_test_data")
       .setPosition(230, 20)
       .setSize(50, 50)
       .setValue(false);

    cp5.addToggle("autoCameraZoom")
       .plugTo(parent, "autoCameraZoom")
       .setPosition(300, 20)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("logDataStream")
       .plugTo(parent, "logDataStream")
       .setPosition(20, 90)
       .setSize(50, 50)
       .setValue(false);

    cp5.addToggle("arraylist_or_array")
       .plugTo(parent, "arraylist_or_array")
       .setPosition(90, 90)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("particleFade")
       .plugTo(parent, "particleFade")
       .setPosition(160, 90)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("global_velocity")
       .plugTo(parent, "global_velocity")
       .setPosition(230, 90)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("applyVelocity")
       .plugTo(parent, "applyVelocity")
       .setPosition(300, 90)
       .setSize(50, 50)
       .setValue(true);
       
    cp5.addSlider("camRotateSpeed")
        .plugTo(parent, "camRotateSpeed")
        .setPosition(20, 160)
        .setRange(0, 3.0)
        .setValue(0.5)
        .setSize(30, 50);
        
    cp5.addSlider("min_cam_dist")
       .plugTo(parent, "min_cam_dist")
       .setPosition(90, 160)
       .setRange(100.0, 1000.0)
       .setValue(500.0)
       .setSize(30, 50);

    cp5.addSlider("max_cam_dist")
       .plugTo(parent, "max_cam_dist")
       .setPosition(160, 160)
       .setRange(1000.0, 3000.0)
       .setValue(2000.0)
       .setSize(30, 50);

    // ===================
    
    cp5.addSlider("bg_r")
       .plugTo(parent, "bg_r")
       .setPosition(20, 240)
       .setRange(0.0, 255.0)
       .setValue(0.0)
       .setSize(100, 20);

    cp5.addSlider("bg_g")
       .plugTo(parent, "bg_g")
       .setPosition(20, 270)
       .setRange(0.0, 255.0)
       .setValue(0.0)
       .setSize(100, 20);

    cp5.addSlider("bg_b")
       .plugTo(parent, "bg_b")
       .setPosition(20, 300)
       .setRange(0.0, 255.0)
       .setValue(0.0)
       .setSize(100, 20);

    cp5.addSlider("bg_a")
       .plugTo(parent, "bg_a")
       .setPosition(20, 330)
       .setRange(0.0, 255.0)
       .setValue(255.0)
       .setSize(100, 20);

    // ======

    cp5.addSlider("fill_r")
       .plugTo(parent, "fill_r")
       .setPosition(20, 400)
       .setRange(0.0, 255.0)
       .setValue(255.0)
       .setSize(100, 20);

    cp5.addSlider("fill_g")
       .plugTo(parent, "fill_g")
       .setPosition(20, 430)
       .setRange(0.0, 255.0)
       .setValue(255.0)
       .setSize(100, 20);

    cp5.addSlider("fill_b")
       .plugTo(parent, "fill_b")
       .setPosition(20, 460)
       .setRange(0.0, 255.0)
       .setValue(255.0)
       .setSize(100, 20);

    cp5.addSlider("fill_a")
       .plugTo(parent, "fill_a")
       .setPosition(20, 490)
       .setRange(0.0, 255.0)
       .setValue(255.0)
       .setSize(100, 20);


    // =======================

    cp5.addSlider("stroke_r")
       .plugTo(parent, "stroke_r")
       .setPosition(20, 550)
       .setRange(0.0, 255.0)
       .setValue(200.0)
       .setSize(100, 20);

    cp5.addSlider("stroke_g")
       .plugTo(parent, "stroke_g")
       .setPosition(20, 580)
       .setRange(0.0, 255.0)
       .setValue(200.0)
       .setSize(100, 20);

    cp5.addSlider("stroke_b")
       .plugTo(parent, "stroke_b")
       .setPosition(20, 610)
       .setRange(0.0, 255.0)
       .setValue(200.0)
       .setSize(100, 20);

    cp5.addSlider("stroke_a")
       .plugTo(parent, "stroke_a")
       .setPosition(20, 640)
       .setRange(0.0, 255.0)
       .setValue(200.0)
       .setSize(100, 20);
       
    cp5.addButton("save")
       .plugTo(parent, "save")
       .setPosition(20, 700)
       .setSize(50, 50);
       
    cp5.addButton("load")
       .plugTo(parent, "load")
       .setPosition(100, 700)
       .setSize(50, 50);
     

    cp5.getProperties().addSet("default");
    cp5.getProperties().print();


    // =================================
    // =================================
    // =================================
    // =================================
    // =================================

  }

  void draw() {
    background(190);
  }
  
  void save() {
    cp5.saveProperties("default", "default");
  }
  
  void load() {
    cp5.loadProperties(("default.json"));
  }
}