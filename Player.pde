import processing.sound.*;
class HardPlayer{

    int side,x,y,visionSize,speed,bx,by,bombTime,bombCount,MAX_LANDMARKS; 
    PImage playerImage, bomb,boom;
    boolean bombPlaced = false;
     
    HardPlayer(){
      side = int(maze.side/1.5);
      x=maze.x * maze.side;
      y=maze.y * maze.side;
      visionSize=150;
      speed = 2;
      playerImage = loadImage("playerFace_dark.png");
      
      bomb= loadImage("bomb.png");
      boom= loadImage("boom.png");
      bombCount = 2;
      MAX_LANDMARKS = 5;
    }
    
    void playerVision(){
      vision.rayTracing(x+side/2,y+side/2);
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
        if (key == ' ' && !maze.isLandmark(x+side/2,y+side/2) && MAX_LANDMARKS > 0){
            maze.set(x+side/2,y+side/2,maze.LANDMARK);
            //landmark_sound.play();
            MAX_LANDMARKS--;
        }
         //boom   
        if((key=='b' ||key=='B') && bombCount>0 && !bombPlaced){
            bx=(x+side/2);
            by=(y+side/2);
            bombCount--;
            bombTime=millis();
            bombPlaced = true;
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
      if( millis() < bombTime + 2000){
          image(bomb,bx-13,by-13,26,26);
      }else if( millis() > bombTime + 2000 && millis() < bombTime + 3000){
          image(boom,bx-25,by-25,50,50);
          if(bombPlaced) {
            bombPlaced = false;
            //explosion.play();
          }
          maze.conv2Ground(bx,by);
      }
      playerVision();
      drawPlayer();
      if(maze.win()){
          winTime = millis() + 2500;
      }
    }
}
class EasyPlayer extends HardPlayer{
    EasyPlayer(){
      super();
      bombCount = Integer.MAX_VALUE;
      MAX_LANDMARKS = Integer.MAX_VALUE;
    }
    @Override
        void playerVision(){}
}
