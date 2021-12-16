int playerX= 400 , playerY=400;  //initial pos of player



void setup(){

size(800,800);
strokeWeight(3);
 
 
}

void draw(){

background(color(0,0,0));  //background of maze
playerVision(playerX,playerY,100); // what player can see
player(playerX,playerY); // 

//draw maze
line(600,0,600,800); // test line of maze 
  
}


void player(int x , int y ){

  fill(255, 0, 0); //player
  circle(x, y, 25);  //player

}

void playerVision(int x, int y,int size)
{
fill(200); // shadow of player
circle(x, y, size); //shadow of player
}
// controls of player
void controls(){
 if (keyPressed && (key == CODED)) 
  if (keyCode == UP)   
    y--;
  else if (keyCode == DOWN) 
    y++;
  else if (keyCode == RIGHT) 
    x++;  
  else if (keyCode == LEFT) 
    x--;
};

