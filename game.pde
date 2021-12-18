
class HardPlayer{
 
    int diameter = 15,radius = diameter/2,x=radius,y=radius,visionSize=7;
    
    HardPlayer(){}
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
                this.y--;
            else if (keyCode == DOWN  && maze.validX(x,y+1,radius)) 
                this.y++;
            if (keyCode == RIGHT && maze.validY(x+1,y,radius)) 
                this.x++;  
            else if (keyCode == LEFT &&maze.validY(x-1,y,-radius)) 
                this.x--;
        }
        if (keyPressed && key == ' ')
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
    }
}
class EasyPlayer extends HardPlayer{
    @Override
        void playerVision(){
          
        }
}
