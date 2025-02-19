Player player;

Enemy[][] enemies = new Enemy[15][3];


void setup() {
  frameRate(60);
  fullScreen();
  player = new Player();
  for (int y = 0; y < 3 ; y ++) {
  for (int i = 0; i < enemies.length ; i ++) {
    enemies[i][y] = new Enemy(i * 150,y * 150);
    
  }
  }

}


void draw() {
  background(0);
  player.Display();
  player.shoot();
  for (int y = 0; y < 3; y++) {
  for (int i = 0; i < enemies.length; i++){
    enemies[i][y].Display();
    enemies[i][y].attack();
    Collisions(player.bullet,enemies[i][y],player,enemies[i][y].bullet);

  }
  }
  

}


void mouseClicked(){
  if (player.dead == false) {
    player.bullet.setPos(mouseX,displayHeight - 210,0,-20);
    player.shooting = true;
  }
}



void Collisions(Bullet b,Enemy e,Player p,Bullet be){
  if (dist(b.pos.x,b.pos.y,e.pos.x + 20,e.pos.y) < 100 && e.spawn == true && player.shooting == true) {
    e.spawn = false;
    p.shooting = false;
  }
  
  if (dist(mouseX - 50,displayHeight - 100,be.pos.x,be.pos.y) < 70) {
    p.dead = true;
    p.shooting = false;
  }
}



    
