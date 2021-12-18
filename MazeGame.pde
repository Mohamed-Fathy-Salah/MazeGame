int page = 0;
Home home = new Home(this);
Button back = new Button(0,0,150,50,"back",0);
Maze maze = new Maze(30);

HardPlayer player;
ArrayList<Pair<Integer,Integer>> landmarks = new ArrayList<Pair<Integer,Integer>>();

void setup() {
  size(600,600);
  home.homeSetUp();
}

void draw() {
  if(page == 0){
    //surface.setSize(600,600);
    home.homeDraw();
    if(page !=0 ){
      maze.generateMaze();
      if(page == 1)player = new EasyPlayer();
      else player = new HardPlayer();
    }
  }else if(page == 1){ // easy
    background(255);
    player.update();
    maze.draw();
    
    //back.update();
    
  }else if(page == 2){// hard
    //background(255);
    player.update();
    maze.draw();
    //back.update();
  }
}
