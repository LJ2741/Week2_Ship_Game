class Particle{
  
  PVector pos,velocity;
  int life;
  
  
  Particle() {
    pos = new PVector(0,-100);
    velocity = new PVector(0,0);
    life = 255;
  }
  
  void setPos(float x,float y) {
    pos = new PVector(x,y);
    velocity = new PVector(random(-3,3),random(-3,3));
  }
  
  void Display() {
    ellipse(pos.x,pos.y,20,20);
    pos.add(velocity);
    stroke(255,life);
    fill(255,life);
    life -= 13;
    
  }
    
  
  
  
}
  
