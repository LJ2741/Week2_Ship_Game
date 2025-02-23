import processing.sound.*;

Player player;
SoundFile bgm,shooting,explosion,P_explosion;
ArrayList<Particle> particles;
JSONObject json;
int enemies_killed = 0;
int savedTime = millis();
int totalTime = 15000;
int score = 0;
int highscore = 0;
Enemy[][] enemies = new Enemy[15][3];


void setup() {
  frameRate(60);
  fullScreen();
  bgm = new SoundFile(this,"data/Music&SFX/BGM.mp3");
  shooting = new SoundFile(this,"data/Music&SFX/Shooting.mp3");
  explosion = new SoundFile(this,"data/Music&SFX/Explosion.mp3");
  P_explosion = new SoundFile(this,"data/Music&SFX/Player_Explosion.mp3");
  json = loadJSONObject("data/highscore.json");
  highscore = json.getInt("highscore");
  bgm.loop();
  player = new Player();
  particles = new ArrayList<Particle>();
  spawnEnemies();

}


void draw() {
  background(0);
  reset();
  score();
  player.Display();
  player.shoot();
  
  for (int y = 0; y < 3; y++) { // Functions for enemies/collision
  for (int i = 0; i < enemies.length; i++){
    enemies[i][y].Display();
    enemies[i][y].attack();
    Collisions(player.bullet,enemies[i][y],player,enemies[i][y].bullet);
    movement(enemies[i][y]);

  }
  }
  
  
  for (int i = 0; i < particles.size() ; i++) { // Displays particles and removes old ones
    particles.get(i).Display();
    if (particles.get(i).life <= 0) {
      particles.remove(i);
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
    
    score += 100;
    enemies_killed += 1;
    p.shooting = false;
  }
  
  if (dist(p.pos.x,p.pos.y,be.pos.x,be.pos.y) < 65 && p.dead != true) {
    P_explosion.play();
    p.dead = true; // An enemy has hit the player
    p.shooting = false;
    createParticles(e,p);
  }
  
   if (dist(p.pos.x - 50,p.pos.y,e.pos.x,e.pos.y) < 150 && e.spawn == true && p.dead != true) {
    P_explosion.play();
    p.dead = true; // An enemy has touched the player
    p.shooting = false;
    createParticles(e,p);
  }
}

void movement(Enemy e) {
  if (e.pos.x < 0 || e.pos.x > displayWidth - 130) { // Makes all enemies move down as one hits the edge of the screen
    for (int y = 0; y < 3; y++) {
    for (int i = 0; i < enemies.length; i++){
      enemies[i][y].velocity = enemies[i][y].velocity.mult(-1);
      enemies[i][y].pos.y += 150;

    }
    }
  }
}



void createParticles(Enemy e,Player p) { // Creates particles at the player's or enemy's position
  
  if (p.dead == true) {
  
    for (int i = 0; i < 25; i++) {
      particles.add(new Particle());
      particles.get(i).setPos(p.pos.x,p.pos.y);
    }
  } else {
    for (int i = 0; i < 25; i++) {
      particles.add(new Particle());
      particles.get(i).setPos(e.pos.x + 60,e.pos.y + 50);
    }
  }
}
  
void spawnEnemies() {
  for (int y = 0; y < 3 ; y ++) { // Spawns in enemies in a grid pattern
  for (int i = 0; i < enemies.length ; i ++) {
    enemies[i][y] = new Enemy(i * 150,y * 150 + 130);
    enemies[i][y].spawn = true;
  }
  }
}
  
  

void reset() { // Resets the game and sets the highscore if the player is killed or all enemies are killed
  
  if (player.dead == true) { // player is killed and highscore is set
    
    if (score > highscore) { // Saves the new highscore into a json file
      highscore = score;
      json = loadJSONObject("data/highscore.json");
      json.setInt("highscore",highscore);
      saveJSONObject(json,"data/highscore.json");
    }
    
    score = 0;
    enemies_killed = 0;
    int passedTime = millis() - savedTime;
    
    if (passedTime > totalTime) {
      player.dead = false;
      spawnEnemies();
      savedTime = millis();
    }
        
  }

    
  if (enemies_killed == 45) { // player has won and the game is reset
    enemies_killed = 0;
    spawnEnemies();
  }
}
    
void score() { // Displays the current score and highscore
  textSize(100);
  textAlign(LEFT);
  text("score " + score,25,110);
  fill(255);
  textAlign(RIGHT);
  text("highscore " + highscore,displayWidth - 25,110);
}

void keyPressed() { // Press backspace to reset the highscore
  if (keyCode == BACKSPACE) {
    highscore = 0;
    json = loadJSONObject("data/highscore.json");
    json.setInt("highscore",0);
    saveJSONObject(json,"data/highscore.json");
  }
}
  

    
