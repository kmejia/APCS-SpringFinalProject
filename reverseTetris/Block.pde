import java.util.*;
class Block{
  Random rnd = new Random();
float xCor, yCor;
float speed = 5;
  Block(){
        yCor = 125;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    xCor=925;  
}
  void move(){
    xCor -= speed;
      drawMe();
  }
    void drawMe() {
    fill(#773C90);
    rect(xCor, yCor, cellSize, cellSize);
  }
  
}
