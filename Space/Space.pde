import processing.sound.*;

Player player;
SoundFile bgm,shooting,explosion,P_explosion;
ArrayList<Particle> particles;

Enemy[][] enemies = new Enemy[15][3];


void setup() {
  frameRate(60);
  fullScreen();
  bgm = new SoundFile(this,"data/Music&SFX/BGM.mp3");
  shooting = new SoundFile(this,"data/Music&SFX/Shooting.mp3");
  explosion = new SoundFile(this,"data/Music&SFX/Explosion.mp3");
  P_explosion = new SoundFile(this,"data/Music&SFX/Player_Explosion.mp3");
  bgm.loop();
  player = new Player();
  particles = new ArrayList<Particle>();
  for (int y = 0; y < 3 ; y ++) { // Spawns in enemies in a grid pattern
  for (int i = 0; i < enemies.length ; i ++) {
    enemies[i][y] = new Enemy(i * 150,y * 150);
  }
  }

}


void draw() {
  background(0);
  player.Display();
  player.shoot();
  
  for (int i = 0; i < particles.size() ; i++) { // Displays particles and removes old ones
    particles.get(i).Display();
    if (particles.get(i).life <= 0) {
      particles.remove(i);
    }
  }
  
  
  for (int y = 0; y < 3; y++) { // Functions for enemies/collision
  for (int i = 0; i < enemies.length; i++){
    enemies[i][y].Display();
    enemies[i][y].attack();
    Collisions(player.bullet,enemies[i][y],player,enemies[i][y].bullet);
    movement(enemies[i][y]);

  }
  }
  

}


void mouseClicked(){ // Shooting function
  if (player.dead == false) {
    shooting.play();
    player.bullet.setPos(mouseX,displayHeight - 210,0,-25);
    player.shooting = true;
  }
}



void Collisions(Bullet b,Enemy e,Player p,Bullet be){
  if (dist(b.pos.x,b.pos.y,e.pos.x + 20,e.pos.y) < 100 && e.spawn == true && player.shooting == true) {
    e.spawn = false; // player has hit an enemy
    explosion.play(); 
    createParticles(e,p); 
    
    for (int y = 0; y < 3; y++) { // Increases enemy speed for every kill
    for (int i = 0; i < enemies.length; i++){
      enemies[i][y].velocity = enemies[i][y].velocity.mult(1.05);
    }
    }
    
    p.shooting = false;
  }
  
  if (dist(mouseX - 50,displayHeight - 150,be.pos.x,be.pos.y) < 65 && p.dead != true) {
    P_explosion.play();
    p.dead = true; // An enemy has hit the player
    p.shooting = false;
    createParticles(e,p);
  }
  
   if (dist(mouseX - 50,displayHeight - 150,e.pos.x,e.pos.y) < 150 && e.spawn == true && p.dead != true) {
    P_explosion.play();
    p.dead = true; // An enemy has touched the player
    p.shooting = false;
    createParticles(e,p);
  }
}

void movement(Enemy e) {
  if (e.pos.x < 0 || e.pos.x > displayWidth - 130) { // Makes all enemies move down as one hit the edge of the screen
    for (int y = 0; y < 3; y++) {
    for (int i = 0; i < enemies.length; i++){
      enemies[i][y].pos.y += 150;
      enemies[i][y].velocity = enemies[i][y].velocity.mult(-1);

    }
    }
  }
}



void createParticles(Enemy e,Player p) { // Creates particles at the player's or enemy's position
  
  if (p.dead == true) {
  
    for (int i = 0; i < 8; i++) {
      particles.add(new Particle());
      particles.get(i).setPos(mouseX,displayHeight - 150);
    }
  } else {
    for (int i = 0; i < 8; i++) {
      particles.add(new Particle());
      particles.get(i).setPos(e.pos.x + 50,e.pos.y + 50);
    }
  }
}
  


    
