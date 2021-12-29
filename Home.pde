class Home {
  
  PImage mazeText, gameText;
  PImage[] GIF;
  Button easy, hard , keys;

  void homeSetUp(){
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
    
    backImg1 = loadImage("homeButton2.png");
    backImg2 = loadImage("homeButton1.png");
    
    
    backButton = new Button(510,10,100,100,0,backImg1,backImg2);
    soundButton = new Button(20,10,100,100,0,backImg1,backImg2);
    maze = new Maze(15);
    player = new EasyPlayer();
    
    back_sound.play();
  }
  
  void drawKeys(){
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
  
  void drawHard(){
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
    remainingTime = (loseTime - millis())/1000+1;
    backButton.display(); //back button
    if(mousePressed && backButton.hovered) loseTime = -10000000;
  }
  
  void drawEasy(){
     maze.draw();
     player.update();
     backButton.display();
  }
  
  void drawMenu(){
    surface.setSize(600, 600);
    
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
    //soundButton.mute();
    
    if(page == 1 || page == 2){
      maze.generateMaze();
      remainingTime = 60;
      if(page == 1){
        player = new EasyPlayer();
      }
      else {
        surface.setSize(600, 650);
        player = new HardPlayer();
        loseTime =  millis() + remainingTime * 1000;
      }
    }
  }
}
