class Particle{
  
  PVector pos,velocity;
  int life;
  
  
  Particle() {
    pos = new PVector(0,-100);
    velocity = new PVector(0,0);
    life = 255;
  }
  
  void setPos(float x,float y) { // Sets the position of the particle and gives it a random velocity
    pos = new PVector(x,y);
    velocity = new PVector(random(-3,3),random(-3,3));
  }
  
  void Display() { // Displays the particle while changing position and alpha
    fill(random(0,256),random(0,256),random(0,256),life);
    stroke(255,life);
    ellipse(pos.x,pos.y,20,20);
    pos.add(velocity);
    life -= 13;
    
  }
    
  
  
  
}
  
