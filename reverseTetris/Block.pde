import java.util.*;
class Block{
  Random rnd = new Random();
float xCor, yCor;
float speed = 5;
int colour  = rnd.nextInt(5);
  Block(){
    yCor = 0;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    xCor= 50*rnd.nextInt(20);  
}
  void move(){
    yCor += speed;
      drawMe();
  }
    void drawMe() {
    fill(#773C90);
    rect(xCor, yCor, cellSize, cellSize);
  }
  
}
