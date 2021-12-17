 int page = 0;
Home home = new Home(this);
Button back = new Button(0,0,150,50,"back",0);
HardPlayer hardPlayer = new HardPlayer() , easyPlayer = new EasyPlayer();
Maze maze = new Maze(30);
ArrayList<Pair<Integer,Integer>> landmarks = new ArrayList<Pair<Integer,Integer>>();

void setup() {
  size(600,600);
  home.homeSetUp();
}

void draw() {
  if(page == 0){
    surface.setSize(600,600);
    home.homeDraw();
  }else if(page == 1){ // easy
    background(255);
    maze.draw();
    easyPlayer.update();
    //back.update();
    
  }else if(page == 2){// hard
    //background(255);
    hardPlayer.update();
    maze.draw();
    //back.update();
  }
}
