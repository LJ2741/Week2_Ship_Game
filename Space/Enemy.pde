class Enemy {
  Bullet bullet = new Bullet();
  PImage img;
  PVector pos,velocity;
  boolean spawn;
  int savedTime = millis();
  int totalTime = 7000;
  
  Enemy(int x,int y) { // Needed to set the position of the enemy at setup
    img = loadImage("data/Images/Enemy_ship.png");
    pos = new PVector(x,y);
    velocity = new PVector(0.85,0);
    spawn = true;
    
  }
  

  void Display() { // Changes position of the enemy
    if (spawn == true) {
      image(img,pos.x,pos.y);
      pos.add(velocity);
    }
  }
  
  
  void attack() { // Makes the enemy fire a bullet every 7 seconds
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
