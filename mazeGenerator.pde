import java.util.Stack;
import javafx.util.Pair;

class Maze{
    int x , y , x_, y_ , n,side;  
    int OPENING_X_LEFT = 1;
    int OPENING_X_RIGHT = 2;
    int OPENING_Y_UP = 1;
    int OPENING_Y_DOWN = 2;
    
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
        for(int i = arr.length - 1 ;i > 0;i--){
            int idx = int(random(i+1));
            int tmp = arr[i];
            arr[i] = arr[idx];
            arr[idx] = tmp;
        }
    }

    public void generateMaze(){
      int openingX = int(random(1,4)),openingY = int(random(1,4)); // start at random places
        x = y = 0;
        x_= y_= n-1;
        matrix = new int [n][n];
       
        if((openingX & OPENING_X_LEFT)== OPENING_X_LEFT){
            // center x
            if((openingX & OPENING_X_RIGHT)== OPENING_X_RIGHT)x = n>>1;
            else x = 0;
        }else if((openingX & OPENING_X_RIGHT) == OPENING_X_RIGHT)x = n-1;

        if((openingY & OPENING_Y_UP)== OPENING_Y_UP){
            //center y
            if((openingY & OPENING_Y_DOWN)== OPENING_Y_DOWN)y = n>>1;
            else y = 0;
        }else if((openingY & OPENING_Y_DOWN)== OPENING_Y_DOWN)y = n-1;

        // start in center exit in top center
        if(openingX == (OPENING_X_LEFT | OPENING_X_RIGHT) &&  openingY == (OPENING_Y_UP | OPENING_Y_DOWN)){
            x_ = n-1;
            y_ = 0;
        }else {
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
            //int dirs = int(random(2,3));
            int dirs = 3;
            for(int k = 0;k<dirs;k++){
                int newx = curx + dx[idx[k]] ,newy = cury + dy[idx[k]] ;
                if(newx <0 || newx >=n || newy <0 || newy >=n || matrix[newx][newy] == 1)continue;
                stack.push(new Pair<Integer,Integer>(newx,newy));
                matrix[newx][newy] = matrix[(newx+curx)>>1][(newy+cury)>>1] = 1;
            } 
        }
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
                stack.push(new Pair<Integer,Integer>(newx,newy));
                matrix[(newx+curx)>>1][(newy+cury)>>1] = 1;
            } 
        }
        
        for(int i = 0 ;i<15;i++){
          matrix[int(random(0,n))][int(random(0,n))] =1;
        }
    }
    
    boolean win(int x, int y){
      return x/20 == x_ && y/20 == y_;
    }
    boolean validX(int nx,int ny,int radius){
     
      return nx+abs(radius) < width && nx-abs(radius) >=0 && ny+radius>=0 && ny+radius<height 
        && matrix[(nx+radius)/side][(ny+radius)/side] == 1 && maze.matrix[(nx-radius)/side][(ny+radius)/side] == 1 ;
    }
    boolean validY(int nx,int ny,int radius){
      return ny+abs(radius) < height && ny-abs(radius) >=0 && nx+radius>=0 && nx+radius<width 
        && matrix[(nx+radius)/side][(ny+radius)/side] == 1 && maze.matrix[(nx+radius)/side][(ny-radius)/side] == 1 ;
    }
    void draw(){
        fill(0);
        for(int i = 0 ;i<n;i++){
          for(int j = 0 ;j<n;j++){
            if(matrix[i][j] == 0)
              rect(i*side , j*side , side,side);
          }
        }
        //TODO: bynzel ta7taha
        fill(0); //player
        for(Pair<Integer,Integer> landmark:landmarks){
          circle(landmark.getKey(),landmark.getValue(), player.diameter);  //player
        }
        // the end
        fill(0,255,0);
        rect(x_*side , y_ * side , side , side);
        
    }
}
