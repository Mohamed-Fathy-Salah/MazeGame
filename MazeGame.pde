import processing.sound.*;

int page = 0, winTime = -1, loseTime = -100000 , remainingTime;
Home home;
Maze maze;
HardPlayer player;
//Button back = new Button(225,400,150,50,"Back",5);

SoundFile win_sound, back_sound, click, lose_sound, landmark_sound,explosion;

void setup() {
  size(600,600); //<>//
  frameRate(30);
  win_sound = new SoundFile(this, "cartoon_success_fanfair.wav");
  win_sound.amp(0.5);
  lose_sound = new SoundFile(this, "losing.wav");
  lose_sound.amp(0.5);
  landmark_sound = new SoundFile(this, "coin.wav");
  back_sound = new SoundFile(this, "Fluffing-a-Duck.wav");
  explosion = new SoundFile(this, "explosion.wav");
  //explosion.amp(0.5);
  click = new SoundFile(this, "click.wav");
  back_sound.play();
  home = new Home();
  home.homeSetUp();
  maze = new Maze(15,40);
  player = new EasyPlayer();
}

void draw() {
  
  if(page == 0){
    surface.setSize(600, 600);
    home.homeDraw();
    if(page == 1 || page == 2){
      maze.generateMaze();
      remainingTime = 10;
      if(page == 1){
        player = new EasyPlayer();
      }
      else {
        surface.setSize(600, 650);
        player = new HardPlayer();
        loseTime =  millis() + remainingTime * 1000;
      }
    }
  }else if(page == 1){ // easy 
    maze.draw();
    player.update();
  }else if(page == 2){ // hard
    maze.draw();
    player.update();
    
    fill(0);
    rect(0,600,600,50);
    fill(255);
    text("time : ",10,635);
    text("landmarks : ",600 - textWidth("landmarks : ")-25,635);
    text("bombs : ",235,635);
    fill(255,0,0);
    text(Integer.toString(remainingTime) ,textWidth("time : ") + 20,635);
    text(Integer.toString(player.MAX_LANDMARKS) ,600-25,635);
    text(Integer.toString(player.bombCount) , 335 ,635);
    if(frameCount % 30 == 0)remainingTime--; // every second
  }else if(page == 3){ //keys
    background(0);
    fill(255);
    textSize(30);
    text("↑ | up",(600 - textWidth("↑ | up"))/2,50);
    text("→ | right",(600 - textWidth("→ | right"))/2,130);
    text("↓ | down",(600 - textWidth("↓ | down"))/2,220);
    text("← | left",(600 - textWidth("← | left"))/2,310);
    text("SPACE | landmark",(600 - textWidth("SPACE | landmark"))/2,400);
    text("B | land bomb",(600 - textWidth("B | land bomb"))/2,490);
    text("BACK | SPACE menu",(600 - textWidth("BACK | SPACE menu"))/2,580);
  }
  if( millis() < winTime ){
      win_sound.play();
      page = 0;
      textSize(102);
      background(0);
      fill(0,255,0);
      text("WIN",300-(textWidth("WIN")/2),320);
    }
    if( millis() > loseTime &&  millis() < loseTime + 2500){
      page = 0;      
      lose_sound.play();
      textSize(102);
      background(0);
      fill(255,0,0);
      text("GameOver",300-(textWidth("GameOver")/2),320);
    }
  
  if (keyPressed && key == BACKSPACE)
      page = 0;  
}
