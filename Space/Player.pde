class Player {
  Bullet bullet = new Bullet();
  PImage img;
  PVector pos;
  boolean dead,shooting;

  
  Player() {
    img = loadImage("data/Images/Player_ship.png");
    shooting = false;
    dead = false;
  }
  
  void Display() { // Displays the player and makes it follow the mouse
    pos = new PVector(mouseX,displayHeight - 150);
    if (dead == false) {
      image(img,pos.x - 70,pos.y - 50);
    }
  }
  
  void shoot(){ // Fires the bullet
    if (shooting == true) {
      bullet.Display();
    }
  }
}
