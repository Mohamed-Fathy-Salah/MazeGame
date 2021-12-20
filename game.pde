
class HardPlayer{
 
    int diameter ,radius,x,y,visionSize,speed;
    
    HardPlayer(){
      diameter = int(maze.side/1.5);
      radius = diameter /2;
      x=maze.x * maze.side +maze.side/2;
      y=maze.y * maze.side +maze.side/2;
      visionSize=7;
      speed = 1;
    }
    void playerVision(){      
        background(0);  //background of maze
        
        for(int i = 0 ;i< 25;i++){
          fill(255,255,255,200 - i*5); // shadow of end
          circle(maze.x_ * maze.side, maze.y_ * maze.side, 5*i); //shadow of end
        }
        
        for(int i = 0 ;i< 50;i++){
          fill(255,255,255,255 - i*5); // shadow of player
          circle(this.x, this.y, visionSize*i); //shadow of player
        }
    }
    
    void playerControls(){
        if (keyPressed && (key == CODED)){ 
            if (keyCode == UP && maze.validX(x,y-1,-radius))   
                this.y-=speed;
            else if (keyCode == DOWN  && maze.validX(x,y+1,radius)) 
                this.y+=speed;
            if (keyCode == RIGHT && maze.validY(x+1,y,radius)) 
                this.x+=speed;  
            else if (keyCode == LEFT &&maze.validY(x-1,y,-radius)) 
                this.x-=speed;
        }
        if (keyPressed && key == ' ' && landmarks.size() < MAX_LANDMARKS)
                 landmarks.add(new Pair<Integer,Integer>(x,y));
       if (keyPressed && key == BACKSPACE)
                 page = 0;  
        
    }
    
    void drawPlayer(){
    fill(255, 0, 0); //player
    circle(x, y, diameter);  //player
    }
    void update(){
      playerControls();
      playerVision();
      drawPlayer();
      if(maze.win(x,y)){
          winTime = millis() + 2500;
          x=radius;
          y=radius;
        }
    }
}
class EasyPlayer extends HardPlayer{
    @Override
        void playerVision(){
          
        }
}
