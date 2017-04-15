class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  boolean transparent;
  boolean particleFade;
  boolean applyVelocity;
  
  Particle(PVector l){
    acceleration = new PVector(0, 0.05);
    // I added this... below... not sure about it tho.
    // Not sure what I htink of adding the z velocity in here...
    //velocity = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = l.get();
    lifespan = 250.0;
    transparent = true;
    particleFade = false;
    applyVelocity = false;
  }
  
  void run(){
    update();
    display();
  }
  
  PVector getLocation(){
    return location;
  }
  
  void update(){
    
    if(particleFade == true){
      lifespan -= 0.5;
      
      // Plays with velocity to make points more interesting
      // but only if there is new data coming into the app
      if(applyVelocity == true){
        velocity.add(acceleration);
        location.add(velocity);
      }
    } else {
      // this still drifts away
      //location.add(velocity);
    }
    
  }
  
  void display(){
    
    if(transparent == false){
      strokeWeight(2);
      if(particleFade == true){
        // fill(255, lifespan);
        fill(fill_r, fill_g, fill_b, lifespan);
        stroke(stroke_r, stroke_g, stroke_b, lifespan);
      } else {
        fill(fill_r, fill_g, fill_b, fill_a);
        stroke(stroke_r, stroke_g, stroke_b, stroke_a);
      }
      
    } else {
      if(particleFade == true){
        fill(fill_r, fill_g, fill_b, lifespan);
        stroke(stroke_r, stroke_g, stroke_b, lifespan);
      } else {
        fill(fill_r, fill_g, fill_b, fill_a);
        stroke(stroke_r, stroke_g, stroke_b, stroke_a);
      }
      
    }
    
    pushMatrix();
      translate(location.x, location.y, location.z);
      sphere(4);
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
  
  void setParticleVelocity(boolean pv){
    applyVelocity = pv;
  }
  
  
}