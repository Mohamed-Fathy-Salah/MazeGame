int page = 0;
Home home = new Home(this);
Button back = new Button(100,100,150,50,"back",0);

void setup() {
  size(600,600);
  home.homeSetUp();
  
}

void draw() {
  if(page == 0){
    surface.setSize(600,600);
    home.homeDraw();
  }else if(page == 1){
    surface.setSize(300,300);
    background(255,0,0);
    back.update();
  }else if(page == 2){
    surface.setSize(300,300);
    background(255,255,0);
    back.update();
  }
    
}
