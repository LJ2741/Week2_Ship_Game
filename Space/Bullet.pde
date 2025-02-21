class Bullet {
  PImage img;
  PVector pos;
  PVector velocity;
  
  Bullet() {
    pos = new PVector(0,-2000);
    velocity = new PVector(0,-20);
    img = loadImage("data/Images/Bullet_img.png");
  }
  
  void setPos(float x,float y,float x2,float y2){
    pos = new PVector(x,y);
    velocity = new PVector(x2,y2);
  }
  
  void Display() {
    image(img,pos.x - 17,pos.y);
    pos.add(velocity);
  }

}
