class Player {
  Bullet bullet = new Bullet();
  PImage img;
  PVector pos;
  boolean dead,shooting;

  
  Player() {
    img = loadImage("data/Player_ship.png");
    shooting = false;
    dead = false;
    pos = new PVector(mouseX + 30,displayHeight - 200);
  }
  
  void Display() {
    if (dead == false) {
      image(img,mouseX - 70,displayHeight - 200);
    }
  }
  
  void shoot(){
    if (shooting == true) {
      bullet.Display();
    }
  }
}
