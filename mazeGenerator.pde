import java.util.Stack;
import javafx.util.Pair;

Integer OPENING_X_LEFT = 1;
Integer OPENING_X_RIGHT = 2;
Integer OPENING_Y_UP = 1;
Integer OPENING_Y_DOWN = 2;

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
    while(!stack.isEmpty()){
        Pair<Integer,Integer> p = stack.pop(); 
        int curX = p.getKey() ,curY = p.getValue();
        //TODO
    }
    return matrix;
}
