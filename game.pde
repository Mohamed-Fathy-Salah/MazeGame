class HardPlayer{
    int diameter = 15,radius = diameter/2,x=radius,y=radius,visionSize=7;
    
    HardPlayer(){}
    void playerVision(){
        background(0);  //background of maze
        for(int i = 0 ;i< 50;i++){
          fill(255,255,255,255 - i*5); // shadow of player
          circle(this.x, this.y, visionSize*i); //shadow of player
        }
    }
    
    void playerControls(){
        if (keyPressed && (key == CODED)){ 
            if (keyCode == UP && maze.valid(x+radius,y-1-radius)&& maze.valid(x-radius,y-1-radius) && maze.matrix[(x+radius)/20][(y-1-radius)/20] == 1 && maze.matrix[(x-radius)/20][(y-1-radius)/20] == 1)   
                this.y--;
            else if (keyCode == DOWN  && maze.valid(x+radius,y+1+radius) && maze.valid(x-radius,y+1+radius)&& maze.matrix[(x+radius)/20][(y+1+radius)/20] == 1 && maze.matrix[(x-radius)/20][(y+1+radius)/20] == 1) 
                this.y++;
            if (keyCode == RIGHT && maze.valid(x+1+radius,y+radius)&& maze.valid(x+1+radius,y-radius)&& maze.matrix[(x+1+radius)/20][(y+radius)/20] == 1&& maze.matrix[(x+1+radius)/20][(y-radius)/20] == 1) 
                this.x++;  
            else if (keyCode == LEFT  &&maze.valid(x-1-radius,y+radius)&&maze.valid(x-1-radius,y-radius)&& maze.matrix[(x-1-radius)/20][(y+radius)/20] == 1&& maze.matrix[(x-1-radius)/20][(y-radius)/20] == 1) 
                this.x--;
        }
        if (keyPressed && key == ' ')
                 landmarks.add(new Pair<Integer,Integer>(x,y));
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
