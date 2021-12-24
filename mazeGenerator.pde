import java.util.Stack;
import javafx.util.Pair;

class Maze{
    int x , y , x_, y_ , n,side;  
    int[][] matrix;
    
    Maze(int n,int side){
       this.n = n;
       this.side = side;
    }
    
    Maze(){
      n = 30;
      side = 20;
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
                if(newx <0 || newx >=n || newy <0 || newy >=n ||matrix[newx][newy] == 1)continue;
                stack.push(new Pair<Integer,Integer>(newx,newy));
                matrix[newx][newy] = matrix[(newx+curx)>>1][(newy+cury)>>1] = 1;
            } 
        }
        //making sure there is a path
        if(matrix[x_][y_] == 0){
          stack.push(new Pair<Integer,Integer>(x_,y_));
          while(!stack.isEmpty()){
              Pair<Integer,Integer> p = stack.pop(); 
              int curx = p.getKey() ,cury = p.getValue();
              if(matrix[curx][cury] == 1)break;
              matrix[curx][cury] = 1;
              shuffleArray(idx);   
              //int dirs = int(random(2,3));
              int dirs = 3;
              for(int k = 0;k<dirs;k++){
                  int newx = curx + dx[idx[k]] ,newy = cury + dy[idx[k]] ;
                  if(newx <0 || newx >=n || newy <0 || newy >=n)continue;
                  matrix[(newx+curx)>>1][(newy+cury)>>1] = 1;
                  stack.push(new Pair<Integer,Integer>(newx,newy));
              } 
          }
        }
        //random points convert to road
        for(int i = 0 ;i<10;i++)
          matrix[int(random(0,(n>>1) - 1))<<1][int(random(0,(n>>1) - 1))<<1] =1;
        
    }
    
    boolean win(){
      return player.x/side == x_ && player.y/side == y_;
    }
    boolean validX(int nx,int ny,int radius){
      return nx+abs(radius) < width && nx-abs(radius) >=0 && ny+radius>=0 && ny+radius<width 
        && matrix[(nx+radius)/side][(ny+radius)/side] == 1 && maze.matrix[(nx-radius)/side][(ny+radius)/side] == 1 ;
    }
    boolean validY(int nx,int ny,int radius){
      return ny+abs(radius) < width && ny-abs(radius) >=0 && nx+radius>=0 && nx+radius<width 
        && matrix[(nx+radius)/side][(ny+radius)/side] == 1 && maze.matrix[(nx+radius)/side][(ny-radius)/side] == 1 ;
    }
    void draw(){
        noStroke();
        for(int i = 0 ;i<n;i++){
          for(int j = 0 ;j<n;j++){
            if(matrix[i][j] == 0){
              fill(200,0,0);
              rect(i*side , j*side , side,side);
            }else{
              fill(0,0,200);
              rect(i*side , j*side , side,side);
            }
          }
        }
        //landmarks
        fill(0); 
        for(Pair<Integer,Integer> landmark:landmarks)
          circle(landmark.getKey(),landmark.getValue(), player.diameter); 
    }
}
