class HardPlayer{

    int side,x,y,visionSize,speed,b1,b2,bombTime,bombCount;
    boolean isBomb=false;    
    PImage playerImage, end,bomb,boom;
    HardPlayer(){
      side = int(maze.side/1.5);
      x=maze.x * maze.side;
      y=maze.y * maze.side;
      visionSize=150;
      speed = 2;
      playerImage = loadImage("playerFace_dark.png");
      String seperator = "\\";
      if(System.getProperty("os.name").contains("Linux")) seperator = "/";
      end = loadImage("Crates"+seperator+"crate_45.png");
      bomb= loadImage("bomb.png");
      boom= loadImage("boom.png");
    }
    void playerVision(){
      // fog gradient
      noFill();
      strokeWeight(11);
      for(int i = 0 ;i<125;i++){
        stroke(0,i*2);
        circle(x+side/2,y+side/2,visionSize*i/30);
      }
      
      // fog boundries
      noStroke();
      
      fill(0);
      rect(0,0,width,y-visionSize);
      rect(0,y+visionSize,width,width-y-visionSize);
      rect(0,y-visionSize,x - visionSize,2*visionSize);
      rect(x+visionSize,y-visionSize,width- x - visionSize,2*visionSize);
      
      drawEnd();
    }
    void drawEnd(){
      pushMatrix();
      translate(maze.x_*maze.side, maze.y_*maze.side);
      scale(float(maze.side) / end.width);
      image(end, 0,0);
      popMatrix();
    }
    void playerControls(){
        if (keyPressed && (key == CODED)){ 
          
          if (keyCode == UP && maze.valid(x,y-speed) && maze.valid(x+side , y-speed))   
                this.y-=speed;
            else if (keyCode == DOWN  && maze.valid(x,y+side+speed) && maze.valid(x+side , y+side+speed)) 
                this.y+=speed;
            if (keyCode == RIGHT && maze.valid(x+side+speed,y) && maze.valid(x+side+speed , y+side)) 
                this.x+=speed;  
            else if (keyCode == LEFT && maze.valid(x-speed,y) && maze.valid(x-speed , y+side)) 
                this.x-=speed;
        }
        int sizeFlag = landmarks.size();
        if (key == ' ' && landmarks.size() < MAX_LANDMARKS)
            landmarks.add(new Pair<Integer,Integer>(x+side/2,y+side/2));

        if (landmarks.size() != sizeFlag)
            landmark_sound.play();
         //boom   
        if(key=='b' ||key=='B'){
            //maze.drawBomb(x,y);
            isBomb=true;
            print(1);
            b1=(x+side/2);
            b2=(y+side/2);
            bombTime=millis();
          }  
    }
    
    void drawPlayer(){
      pushMatrix();
      translate(x,y);
      scale(float(side) / playerImage.width);
      // rotating the player
      if (keyCode == RIGHT){
        translate(0,64);
        rotate(radians(-90));
      } 
        
      else if (keyCode == LEFT){
        translate(64,0);
        rotate(radians(90));
      }
        
      else if (keyCode == UP){
        translate(64,64);
        rotate(radians(180));
      }
      image(playerImage,0,0);
      popMatrix();
    }
    void update(){
      playerControls();
      if(isBomb==true){
        if(bombCount<65){
           if( millis() < bombTime + 2000){
               image(bomb,b1-13,b2-13,26,26);      
           }
           if( millis() > bombTime + 2000 && millis() < bombTime + 4000){
               image(boom,b1-25,b2-25,50,50);      
               bo++;
               println(bo);
           }
        }
      }
      playerVision();
      drawPlayer();
      if(maze.win()){
          winTime = millis() + 2500;
      }
    }
}
class EasyPlayer extends HardPlayer{
    @Override
        void playerVision(){
          drawEnd();
        }
}
