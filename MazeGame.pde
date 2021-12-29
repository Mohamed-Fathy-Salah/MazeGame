import processing.sound.*;

String separator = "\\";

int page = 0, winTime = -1, loseTime = -100000 , remainingTime;
Home home;
Maze maze;
HardPlayer player;
PImage backImg1,backImg2,soundImg1,soundImg2;
Button backButton,soundButton ;

SoundFile win_sound, back_sound, click, lose_sound, landmark_sound,explosion;
 //<>//
void setup() {
  if(System.getProperty("os.name").contains("Linux")) separator = "/"; //<>//
  size(600,600); 
  //frameRate(30);
  
  win_sound = new SoundFile(this, "sounds"+separator+"cartoon_success_fanfair.wav");
  win_sound.amp(0.5);
  lose_sound = new SoundFile(this, "sounds"+separator+"losing.wav");
  lose_sound.amp(0.5);
  landmark_sound = new SoundFile(this, "sounds"+separator+"coin.wav");
  back_sound = new SoundFile(this, "sounds"+separator+"Fluffing-a-Duck.wav");
  explosion = new SoundFile(this, "sounds"+separator+"explosion.wav");
  click = new SoundFile(this, "sounds"+separator+"click.wav");
  
  home = new Home();
  home.homeSetUp();

}

void draw() {
  if(page == 0){
    home.drawMenu();
  }else if(page == 1){ // easy 
     home.drawEasy();
  }else if(page == 2){ // hard
     home.drawHard();
  }else if(page == 3){ //keys
     home.drawKeys();
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

  
