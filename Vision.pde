class Vision{

    void circularFog(int x,int y ,int visionSize){
      // fog gradient
      int weight = 5 , itr = (visionSize + weight - 1)/weight;
      noFill();
      strokeWeight(weight);
      for(int i = 0 ;i<=itr;i++){
        stroke(0,55+i*200/itr);
        circle(x,y,visionSize + i* weight);
      }
      //outer circle
      strokeWeight(visionSize*(sqrt(8)-2));
      stroke(0,255);
      circle(x,y,visionSize*sqrt(8));
      // fog boundries
      noStroke();
      
      fill(0);
      int x1 = x-visionSize , x2 = x+visionSize ;
      int y1 = y-visionSize , y2 = y+visionSize ;
      rect(0,0,width,y1);//up
      rect(0,y2,width,width-y2);//down
      rect(0,y1,x1,2*visionSize);//left
      rect(x2,y1,width - x2,2*visionSize);//right
    }
    void gaussianFog(int x,int y,int visionSize){
      //not optimized by any means :'D
        for(int i = 0 ;i<width;i++){
            for(int j = 0;j<width;j++){
                float tmp = 255 - 500*exp(sqrt((x-i)*(x-i) + (y-j)*(y-j)) / (-.5*visionSize));
                if(tmp > 200 )tmp = 255;
                else if (tmp < 0) tmp = 0;
                println(tmp);
                stroke(0,tmp);
                point(i,j);
            }
        }
    }
    void rayTracing(int x,int y){
      int n = 10;
      
      int[][][] arr= new int[4][n+1][2];
      
      for(int i = 0;i<=n;i++){
        //top right
        int dx = x+i , dy = y - n + i;
        while(maze.valid(dx,dy)){
          dx+= i;
          dy+= i-n;
        }
        arr[0][i][0] = dx;
        arr[0][i][1] = dy;
        
        //top left
        dx = x - i ; dy = y - n + i;
        while(maze.valid(dx,dy)){
          dx-=i;
          dy+=i-n;
        }
        arr[1][i][0] = dx;
        arr[1][i][1] = dy;
        
        //dowm right
        dx = x+i ; dy = y + n - i;
        while(maze.valid(dx,dy)){
          dx+= i;
          dy+= n-i;
        }
        arr[2][i][0] = dx;
        arr[2][i][1] = dy;
        
        //down left
        dx = x - i ; dy = y + n - i;
        while(maze.valid(dx,dy)){
          dx-=i;
          dy+=n-i;
        }
        arr[3][i][0] = dx;
        arr[3][i][1] = dy;
      }
      
      strokeWeight(3);
      for(int j = 0 ;j<4;j++){
        for(int i = 0 ;i<=n;i++){
          // round the points to the closest point on the wall
          //int dx = arr[i][0] - arr[i][0]%maze.side;
          //int dy = arr[i][1] - arr[i][1]%maze.side;
          //if(abs(arr[i][0] - dx) < abs(arr[i][1] - dy))arr[i][0] = dx;
          //else arr[i][1] = dy;
          point(arr[j][i][0],arr[j][i][1]);
        }
      }
    }
    void rowCol(int x,int y){
      int x1 = x - x%maze.side  , y1 = y - y%maze.side;
      int x2 = x1+maze.side , y2 = y1+maze.side;
      fill(0);
      rect(0,0,x1,y1);
      rect(x2,0,width - x2,y1);
      rect(0,y2,x1,width-y2);
      rect(x2,y2,width-x2,width-y2);
      
      int i;
      for(i = maze.side ;i + x1 < maze.n * maze.side && !maze.isWall(i + x1,y1);i+=maze.side);
      i+=maze.side;
      rect(i + x1 , y1 , width - (i+x1), maze.side);
      
      for(i = maze.side ;i + y1 < maze.n * maze.side && !maze.isWall(x1,i+y1);i+=maze.side);
      i+=maze.side;
      rect(x1 ,i + y1 , maze.side , width - (i + y1));
      
      for(i = -maze.side ;i + x1 >= 0 && !maze.isWall(i + x1,y1);i-=maze.side);
      rect(0 , y1 , i+x1, maze.side);
      
      for(i = -maze.side ;i + y1 >= 0 && !maze.isWall(x1,i + y1);i-=maze.side);
      rect(x1 , 0 ,maze.side ,i+y1 );
  }
}
