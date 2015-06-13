import java.util.*;

class Block {
  Random rnd = new Random();
  float xCor, yCor;
  float speed = 5;
  int fillColor;
  Block left;
  Block right;
  Block up;
  Block down;
  Block next;
  int counter;
  boolean moving = true;
  //color = data
  Block(int colour, int count) {
    //xCor= 25+50*rnd.nextInt(20);
    xCor = 25;
    yCor = 0;
    fillColor = colour;
    counter = count;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
  }

  Block(int x, int y, int colour, int count) {
    xCor = x;
    yCor = y; 
    fillColor = colour;
    counter = count;
  }
  Block() {
    fillColor = 1;
  }

  void drawMe() {
    fill(fillColor);
    rect(xCor, yCor, cellSize, cellSize);
  }

  void move() {
    if (moving) {
      //if (yCor <= numCellsRow-cellSize/2);
      if (/*yCor<=(numCellsRow-25)*/ !findBelow()) {
        yCor += speed;
      }
    }
    drawMe();
  }

  boolean findBelow() {
    if (down.counter != counter) {
      if ((int)yCor >= (int)down.yCor+cellSize) {
        return true;
      }
    }
    return false;
  }

  void setNext(Block n) {
    next = n;
  }

  Block getNext() {
    return next;
  }

  Block getLeft() {
    return left;
  }

  void setLeft() {
  }

  Block getRight() {
    return right;
  }

  Block getUp() {
    return up;
  }

  Block getDown() {
    return down;
  }
  
  void setDown(Block b){
   down = b; 
  }
}

