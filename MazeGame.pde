int page = 0, winTime = -1, loseTime = -1;
Home home = new Home(this);
Maze maze = new Maze(30);

HardPlayer player;
ArrayList<Pair<Integer,Integer>> landmarks = new ArrayList<Pair<Integer,Integer>>();

void setup() {
  size(600,600);
  home.homeSetUp();
}

void draw() {
  if(page == 0){
    home.homeDraw();
    if(page !=0 ){
      maze.generateMaze();
      if(page == 1)player = new EasyPlayer();
      else {
        player = new HardPlayer();
        loseTime =  millis() + 5000;
      }
    }
  }else if(page == 1){ // easy
    background(255);
    player.update();
    maze.draw();  
  }else if(page == 2){// hard
    player.update();
    maze.draw();
  }
  if( millis() < winTime ){
    page = 0;
    textSize(102);
    background(255);
    fill(0,255,0);
    text("WIN",300-(textWidth("WIN")/2),320);
  }
  if( millis() > loseTime &&  millis() < loseTime + 2500){
    page = 0;
    textSize(102);
    background(255);
    fill(255,0,0);
    text("GameOver",300-(textWidth("GameOver")/2),320);
  }
}
