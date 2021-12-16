import java.util.Stack;
import javafx.util.Pair;

Integer OPENING_X_LEFT = 1;
Integer OPENING_X_RIGHT = 2;
Integer OPENING_Y_UP = 1;
Integer OPENING_Y_DOWN = 2;

void shuffleArray(int[] arr){
    for(int i = arr.length - 1 ;i > 0;i--){
        int idx = int(random(i+1));
        int tmp = arr[i];
        arr[i] = arr[idx];
        arr[idx] = tmp;
    }
}
int[][] generateMaze(Integer n ,Integer openingX,Integer openingY){

    int[][] matrix = new int[n][n];
    int x = 0 , y = 0 , x_ = n-1, y_ = n-1;

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
    for(int i = 0 ;i<n;i++){
      for(int j = 0 ;j<n;j++)print(matrix[i][j]);
      print('\n');
    }
    return matrix;
}

void setup(){
  generateMaze(9,OPENING_X_RIGHT + OPENING_X_LEFT,OPENING_Y_DOWN+OPENING_Y_UP);
}
