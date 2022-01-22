import java.util.Stack;
import javafx.util.Pair;

class Maze{
    final int WALL = 0, GROUND =1 ,LANDMARK = 2 , END = 3;
    int x , y , x_, y_ , n,side;  
    int[][] matrix;
    PImage[] images ;
    Maze(int n){
       this.n = n;
       this.side = width / n;
       images = new PImage[4];
       //wall = loadImage("Blocks"+seperator+"block_01.png");
       images[WALL] = loadImage("Crates"+separator+"crate_16.png");
       images[GROUND] = loadImage("Ground"+separator+"ground_06.png");
       images[LANDMARK] = loadImage("Crates"+separator+"crate_08.png");
       images[END] = loadImage("Crates"+separator+"crate_45.png");
    }
    Maze(){
      this(30);
    }
    
    private void shuffleArray(int[] arr){
        for(int i = arr.length - 1 ;i > 1;i--){
            int idx = int(random(i+1));
            int tmp = arr[i];
            arr[i] = arr[idx];
            arr[idx] = tmp;
        }
    }
   
    public void generateMaze(){
        int[] starting = {0,n>>1,n-1};
        x = starting[int(random(3))];
        y = starting[int(random(3))];
        
        matrix = new int [n][n];
       
        if(x == (n>>1) && y == (n>>1)){
            x_ = n-1;
            y_ = 0;
        }else{
            x_ = n - x - 1;
            y_ = n - y - 1;
        }
        // run dfs with random direction from x,y to x_,y_
        Stack<Pair<Integer,Integer>> stack = new Stack<Pair<Integer,Integer>>();
        stack.push(new Pair<Integer,Integer>(x,y));
        matrix[x][y] = 1;
        int idx[] = {0,1,2,3};
        int dx[] = {2,-2,0,0};
        int dy[] = {0,0,2,-2};
        while(!stack.isEmpty()){
            Pair<Integer,Integer> p = stack.pop(); 
            int curx = p.getKey() ,cury = p.getValue();
            shuffleArray(idx);   
            int dirs = int(random(3,5));
            //int dirs = 3;
            for(int k = 0;k<dirs;k++){
                int newx = curx + dx[idx[k]] ,newy = cury + dy[idx[k]] ;
                if(newx <0 || newx >=n || newy <0 || newy >=n ||matrix[newx][newy] == GROUND)continue;
                stack.push(new Pair<Integer,Integer>(newx,newy));
                matrix[newx][newy] = matrix[(newx+curx)>>1][(newy+cury)>>1] = GROUND;
            } 
        }
        //making sure there is a path
        if(matrix[x_][y_] == WALL){
          stack.push(new Pair<Integer,Integer>(x_,y_));
          while(!stack.isEmpty()){
              Pair<Integer,Integer> p = stack.pop(); 
              int curx = p.getKey() ,cury = p.getValue();
              if(matrix[curx][cury] == GROUND)break;
              matrix[curx][cury] = GROUND;
              shuffleArray(idx);   
              //int dirs = int(random(2,3));
              int dirs = 3;
              for(int k = 0;k<dirs;k++){
                  int newx = curx + dx[idx[k]] ,newy = cury + dy[idx[k]] ;
                  if(newx <0 || newx >=n || newy <0 || newy >=n)continue;
                  matrix[(newx+curx)>>1][(newy+cury)>>1] = GROUND;
                  stack.push(new Pair<Integer,Integer>(newx,newy));
              } 
          }
        }
        //random points convert to road
        for(int i = 0 ;i<10;i++)
          matrix[int(random(0,n))][int(random(0,n))] = GROUND;
        matrix[x_][y_] = END;
    }
    
    boolean win(){
      return player.x/side == x_ && player.y/side == y_;
    }
    boolean valid(int nx,int ny){
      return nx>=0 && nx<width && ny>=0 && ny<width && matrix[nx/side][ny/side] != WALL;
    }
    
    void draw(){
      for(int i = 0 ;i<n;i++){
        for(int j = 0 ;j<n;j++){
          pushMatrix();
          translate(i*side, j*side);
          scale(float(side) / images[WALL].width);
          image(images[matrix[i][j]] , 0 ,0);
          popMatrix();
        }
      }
    }
    boolean isLandmark(int x,int y){
      return matrix[x/side][y/side] == LANDMARK;
    }
    void set(int x,int y,int value){
      matrix[x/side][y/side] = value;
    }
    void conv2Ground(int x,int y){
      x/=side;
      y/=side;
      int dx[] = {1,1,1,-1,-1,-1,0,0};
      int dy[] = {1,-1,0,1,-1,0,1,-1};
      for(int k = 0;k<8;k++){
        int nx = x + dx[k] , ny = y + dy[k];
        if(nx<n && ny<n && nx>=0 && ny>= 0 && matrix[nx][ny] == WALL) matrix[nx][ny]=GROUND;
      }
    }
    boolean isWall(int x,int y){
      return matrix[x/side][y/side] == WALL;
    }
}
