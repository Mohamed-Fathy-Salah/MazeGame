import processing.sound.*;
class HardPlayer{

    int side,x,y,visionSize,speed,b1,b2,bombTime,bombCount,MAX_LANDMARKS; 
    PImage playerImage, end,bomb,boom;
    boolean bombPlaced = false;
     
    HardPlayer(){
      String seperator = "\\";
      if(System.getProperty("os.name").contains("Linux")) seperator = "/";
      
      side = int(maze.side/1.5);
      x=maze.x * maze.side;
      y=maze.y * maze.side;
      visionSize=150;
      speed = 2;
      playerImage = loadImage("playerFace_dark.png");
      end = loadImage("Crates"+seperator+"crate_45.png");
      bomb= loadImage("bomb.png");
      boom= loadImage("boom.png");
      bombCount = 2;
      MAX_LANDMARKS = 5;
    }
    boolean valid(int x,int y){
      if(x<0 || x>14 || y<0 || y>14)return false;
      return true;
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
        if (key == ' ' && !maze.isLandmark(x,y) && MAX_LANDMARKS > 0){
            maze.set(x,y,maze.LANDMARK);
            landmark_sound.play();
            MAX_LANDMARKS--;
        }
         //boom   
        if((key=='b' ||key=='B') && bombCount>0 && !bombPlaced){
            b1=(x+side/2);
            b2=(y+side/2);
            bombCount--;
            bombTime=millis();
            bombPlaced = true;
          }  
    }
    
    void drawPlayer(){
      //landmarks
      //fill(0); 
      
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
          image(bomb,b1-13,b2-13,26,26);
      }else if( millis() > bombTime + 2000 && millis() < bombTime + 3000){
          image(boom,b1-25,b2-25,50,50); 
          explosion.play();
          int xx=b1/40 ,yy=b2/40;
          if(valid(xx-1,yy))maze.matrix[xx-1][yy]=1;
          if(valid(xx+1,yy))maze.matrix[xx+1][yy]=1;
          if(valid(xx,yy+1))maze.matrix[xx][yy+1]=1;
          if(valid(xx,yy-1))maze.matrix[xx][yy-1]=1;
          if(valid(xx-1,yy-1))maze.matrix[xx-1][yy-1]=1;
          if(valid(xx+1,yy-1))maze.matrix[xx+1][yy-1]=1;
          if(valid(xx-1,yy+1))maze.matrix[xx-1][yy+1]=1;
          if(valid(xx+1,yy+1))maze.matrix[xx+1][yy+1]=1;
      }else if (millis() >= bombTime+3000)bombPlaced = false;
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
          bombCount = Integer.MAX_VALUE;
          MAX_LANDMARKS = Integer.MAX_VALUE;
        }
}
