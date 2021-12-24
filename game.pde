class HardPlayer{

    int diameter ,radius,x,y,visionSize,speed;
    
    HardPlayer(){
      diameter = int(maze.side/1.5);
      radius = diameter /2;
      x=maze.x * maze.side +maze.side/2;
      y=maze.y * maze.side +maze.side/2;
      visionSize=150;
      speed = 2;
    }
    void playerVision(){
      // fog gradient
      noFill();
      strokeWeight(11);
      for(int i = 0 ;i<125;i++){
        stroke(0,i*2);
        circle(x,y,visionSize*i/30);
      }
      
      // fog boundries
      noStroke();
      
      fill(0);
      rect(0,0,width,y-visionSize);
      rect(0,y+visionSize,width,width-y-visionSize);
      rect(0,y-visionSize,x - visionSize,2*visionSize);
      rect(x+visionSize,y-visionSize,width- x - visionSize,2*visionSize);
      
      // end
      fill(0,255,0,200);
      circle(maze.x_*maze.side + maze.side/2 , maze.y_ * maze.side + maze.side/2 , maze.side);
    }
    
    void playerControls(){
        if (keyPressed && (key == CODED)){ 
            if (keyCode == UP && maze.validX(x,y-speed,-radius))   
                this.y-=speed;
            else if (keyCode == DOWN  && maze.validX(x,y+speed,radius)) 
                this.y+=speed;
            if (keyCode == RIGHT && maze.validY(x+speed,y,radius)) 
                this.x+=speed;  
            else if (keyCode == LEFT && maze.validY(x-speed,y,-radius)) 
                this.x-=speed;
        }
        if (key == ' ' && landmarks.size() < MAX_LANDMARKS)
            landmarks.add(new Pair<Integer,Integer>(x,y));
    }
    
    void drawPlayer(){
      noStroke();
      fill(255, 0, 0); //player
      circle(x, y, diameter);  //player
    }
    void update(){
      playerControls();
      playerVision();
      drawPlayer();
      if(maze.win()){
          winTime = millis() + 2500;
          x=radius;
          y=radius;
        }
    }
}
class EasyPlayer extends HardPlayer{
    @Override
        void playerVision(){
          // end
          fill(0,255,0,200);
          circle(maze.x_*maze.side + maze.side/2 , maze.y_ * maze.side + maze.side/2 , maze.side);
        }
}
