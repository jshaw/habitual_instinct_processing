class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  boolean transparent;
  boolean particleFade;
  
  Particle(PVector l){
    //acceleration = new PVector(0,0.05);
    //velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    lifespan = 250.0;
    transparent = true;
    particleFade = false;
  }
  
  void run(){
    update();
    display();
  }
  
  PVector getLocation(){
    return location;
  }
  
  void update(){
    //velocity.add(acceleration);
    //location.add(velocity);
    //lifespan -= 1.0;
    //lifespan -= 0.05;
    lifespan -= 0.04;
  }
  
  void display(){
    if(transparent == false){
      strokeWeight(2);
      if(particleFade == true){
        fill(255, lifespan);
        stroke(255, lifespan);
      } else {
        fill(255, 255, 255);
        stroke(255, 255, 255);
      }
      
    } else {
      noStroke();
      noFill();
    }
    // playing with pshapes instead of spheres
    //beginShape(POINTS);
      //stroke(255,255,255);
      //vertex(location.x, location.y, location.z);
    //  sphere(1);
    //endShape();
    
    pushMatrix();
    //if(transparent == false){
    //  if(particleFade == true){
    //    stroke(255, lifespan);
    //  } else {
    //    stroke(255, 255, 255);
    //  }
    //} else {
    //  noStroke();
    //}
      // println("location: ");
      // println(location);
      translate(location.x, location.y, location.z);
      sphere(1);
    popMatrix();
  }

  void updateVector(int x, int y){
    float z = location.z;
    location.set(x, y, z);
  }
  
  void updateTransparent(){
    transparent = false;
  }
  
  boolean isDead(){
    if(lifespan < 0.0){
      return true;
    } else {
      return false;
    }
  }
  
  void updateParticleAlpha(){
    lifespan = 255.0;
  }
  
  void setParticleFade(boolean pf){
    particleFade = pf;
  }
  
}