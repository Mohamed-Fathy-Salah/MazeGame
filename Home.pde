class Home {
  
  PImage mazeText, gameText;
  PImage[] GIF;
  Button easy, hard , keys;

  void homeSetUp(){
    String separator = "\\";
    if(System.getProperty("os.name").contains("Linux")) separator = "/";
    GIF = new PImage[180];
    
    for(int i=0;i<180;i++){
        GIF[i] = loadImage("BackGround"+separator+"backGround-"+i+".png");
        GIF[i].resize(600,600);
    }
 
    mazeText = loadImage("maze.png");
    gameText = loadImage("game.png");
    easy = new Button(225,400,150,50,"Easy",1);
    hard = new Button(225,450+10,150,50,"Hard",2);
    keys = new Button(225,500+20,150,50,"Keys",3);
  }
  void homeDraw(){
    image( GIF[frameCount%180], 0, 0);
    image(mazeText, 140, 70);
    image(gameText, 133, 70+85);
    fill(0);
    textSize(64);
    text("Mode",300-(textWidth("Mode")/2),380);
    textSize(24);
    easy.update(); 
    hard.update();
    keys.update();
  }
}
