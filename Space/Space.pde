Player player;

int e_amount = 35; 


Enemy[] enemies = new Enemy[e_amount];


void setup() {
  frameRate(60);
  fullScreen();
  player = new Player();
   
  for (int i = 0; i < e_amount ; i += 1) {
    enemies[i] = new Enemy(i * 150 ,0);
    
  }

}


void draw() {
  background(0);
  player.Display();
  player.shoot();
  
  for (int i = 0; i < e_amount; i++){
    enemies[i].Display();
    enemies[i].attack();
    Collisions(player.bullet,enemies[i],player,enemies[i].bullet);

    
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
  
  if (dist(mouseX - 50,displayHeight - 100,be.pos.x,be.pos.y) < 75) {
    p.dead = true;
    p.shooting = false;
  }
}



    
