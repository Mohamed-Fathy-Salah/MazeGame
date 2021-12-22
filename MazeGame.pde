import java.util.Set;
import java.util.HashSet;

int page = 0, winTime = -1, loseTime = -100000, MAX_LANDMARKS , remainingTime;
Home home = new Home();
Maze maze = new Maze();
HardPlayer player;
//Button back = new Button(225,400,150,50,"Back",5);
Set<Pair<Integer,Integer>> landmarks = new HashSet<Pair<Integer,Integer>>();

void setup() {
  size(600,600); //<>//
  frameRate(30);
  home.homeSetUp();
}

void draw() {
  if(page == 0){
    landmarks.clear();
    surface.setSize(600, 600);
    home.homeDraw();
    if(page == 1 || page == 2){
      maze.generateMaze();
      remainingTime = 60;
      if(page == 1){
        player = new EasyPlayer();
        MAX_LANDMARKS = Integer.MAX_VALUE;
      }
      else {
        surface.setSize(600, 650);
        player = new HardPlayer();
        loseTime =  millis() + remainingTime * 1000;
        MAX_LANDMARKS = 5;
      }
    }
  }else if(page == 1){ // easy
    background(255);
    player.update();
    maze.draw();
  }else if(page == 2){ // hard
    player.update();
    maze.draw();
    
    fill(0);
    rect(0,600,600,50);
    fill(255);
    text("time : ",10,635);
    text("landmarks : ",600-textWidth("landmarks : ")-25,635);
    fill(255,0,0);
    text(Integer.toString(remainingTime) ,textWidth("time : ") + 20,635);
    text(Integer.toString(MAX_LANDMARKS - landmarks.size()) ,600-25,635);
    if(frameCount % 30 == 0)remainingTime--; // every second
  }else if(page == 3){ //keys
    background(0);
    fill(255);
    textSize(30);
    text("↑ up",(600 - textWidth("↑ up"))/2,50);
    text("→ right",(600 - textWidth("→ right"))/2,150);
    text("↓ down",(600 - textWidth("↓ down"))/2,250);
    text("← left",(600 - textWidth("← left"))/2,350);
    text("SPACE landmark",(600 - textWidth("SPACE landmark"))/2,450);
    text("BACK SPACE menu",(600 - textWidth("BACK SPACE menu"))/2,550);
  }
  if( millis() < winTime ){
    page = 0;
    textSize(102);
    background(0);
    fill(0,255,0);
    text("WIN",300-(textWidth("WIN")/2),320);
  }
  if( millis() > loseTime &&  millis() < loseTime + 2500){
    page = 0;
    textSize(102);
    background(0);
    fill(255,0,0);
    text("GameOver",300-(textWidth("GameOver")/2),320);
  }
  if (keyPressed && key == BACKSPACE)
      page = 0;  
}
