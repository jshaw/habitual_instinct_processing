
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
       .setPosition(10, 50)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("saveFrame")
       .plugTo(parent, "saveFrame")
       .setPosition(70, 50)
       .setSize(50, 50)
       .setValue(false);

    cp5.addToggle("showOriginBox")
      .plugTo(parent, "showOriginBox")
      .setPosition(130, 50)
      .setSize(50, 50)
      .setValue(true);

    cp5.addToggle("run_test_data")
       .plugTo(parent, "run_test_data")
       .setPosition(190, 50)
       .setSize(50, 50)
       .setValue(false);

    cp5.addToggle("autoCameraZoom")
       .plugTo(parent, "autoCameraZoom")
       .setPosition(250, 50)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("logDataStream")
       .plugTo(parent, "logDataStream")
       .setPosition(10, 120)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("arraylist_or_array")
       .plugTo(parent, "arraylist_or_array")
       .setPosition(70, 120)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("particleFade")
       .plugTo(parent, "particleFade")
       .setPosition(130, 120)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("global_velocity")
       .plugTo(parent, "global_velocity")
       .setPosition(190, 120)
       .setSize(50, 50)
       .setValue(true);

    cp5.addToggle("applyVelocity")
       .plugTo(parent, "applyVelocity")
       .setPosition(250, 120)
       .setSize(50, 50)
       .setValue(true);


    // =================================
    // =================================
    // =================================
    // =================================
    // =================================




    // cp5.addToggle("autoCameraZoom")
    //    .plugTo(parent, "autoCameraZoom")
    //    .setPosition(10, 70)
    //    .setSize(50, 50)
    //    .setValue(true);

    // cp5.addToggle("autoCameraZoom")
    //    .plugTo(parent, "autoCameraZoom")
    //    .setPosition(10, 70)
    //    .setSize(50, 50)
    //    .setValue(true);
       
    // cp5.addKnob("blend")
    //    .plugTo(parent, "c3")
    //    .setPosition(100, 300)
    //    .setSize(200, 200)
    //    .setRange(0, 255)
    //    .setValue(200);

    //   cp5.addSlider("camRotateSpeed")
    //    .plugTo(parent, "camRotateSpeed")
    //    .setRange(0, 2.0)
    //    .setValue(0.5)
    //    .setPosition(100, 140)
    //    .setSize(200, 30);

    // cp5.addSlider("showOriginBox")
    //    .plugTo(parent, "showOriginBox")
    //    .setRange(0, 2.0)
    //    .setValue(0.5)
    //    .setPosition(100, 140)
    //    .setSize(200, 30);

    // cp5.addSlider("autoCameraZoom")
    //    .plugTo(parent, "autoCameraZoom")
    //    .setRange(0, 2.0)
    //    .setValue(0.5)
    //    .setPosition(100, 140)
    //    .setSize(200, 30);

    // cp5.addSlider("logDataStream")
    //    .plugTo(parent, "logDataStream")
    //    .setRange(0, 2.0)
    //    .setValue(0.5)
    //    .setPosition(100, 140)
    //    .setSize(200, 30);

    // cp5.addSlider("particleFade")
    //    .plugTo(parent, "particleFade")
    //    .setRange(0, 2.0)
    //    .setValue(0.5)
    //    .setPosition(100, 140)
    //    .setSize(200, 30);
       
    // cp5.addNumberbox("camRotateSpeed")
    //    .plugTo(parent, "camRotateSpeed")
    //    .setRange(0.1, 1.0)
    //    .setValue(0.5)
    //    .setPosition(100, 10)
    //    .setSize(100, 20);
       
    // cp5.addNumberbox("color-green")
    //    .plugTo(parent, "c1")
    //    .setRange(0, 255)
    //    .setValue(128)
    //    .setPosition(100, 70)
    //    .setSize(100, 20);
       
    // cp5.addNumberbox("color-blue")
    //    .plugTo(parent, "c2")
    //    .setRange(0, 255)
    //    .setValue(0)
    //    .setPosition(100, 130)
    //    .setSize(100, 20);
       
    // cp5.addSlider("speed")
    //    .plugTo(parent, "speed")
    //    .setRange(0, 0.1)
    //    .setValue(0.01)
    //    .setPosition(100, 240)
    //    .setSize(200, 30);
  }

  void draw() {
    background(190);
  }
}