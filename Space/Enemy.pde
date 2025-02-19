class Enemy {
  Bullet bullet = new Bullet();
  PImage img;
  PVector pos,velocity;
  boolean spawn;
  int savedTime = millis();
  int totalTime = 7000;
  
  Enemy(int x,int y) {
    img = loadImage("data/Enemy_ship.png");
    pos = new PVector(x,y);
    velocity = new PVector(0.85,0);
    spawn = true;
    
  }
  

  void Display() {
    if (spawn == true) {
      image(img,pos.x,pos.y);
      pos.add(velocity);
    }
  }
  
  
  void attack() {
    bullet.Display();
    if (spawn == true) {
      int passedTime = millis() - savedTime;
      if (passedTime > totalTime) {
        int ran = round(random(0,100));
        
        if (ran > 97) {
          bullet.setPos(pos.x,pos.y + 150,0,5);
        savedTime = millis();
        }
        
      }
    }
    
  }
      

}
