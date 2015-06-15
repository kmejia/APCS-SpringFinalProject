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
  public String toString() {
    String ans = "" ;
    return ans  + xCor+"," + yCor;
  }
  Block(int colour, int count) {
    //xCor= 25+50*rnd.nextInt(20);
    xCor = 25;
    yCor = 0;
    fillColor = colour;
    counter = count;
    next=null;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
  }
  Block(int x, int y, int colour) {
    xCor = x;
    yCor = y; 
    fillColor = colour;
    next=null;
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
    yCor += speed;
  }


  void setNext(Block n) {
    next = n;
  }
  
  void removeBlock(){
   fillColor = #000000;
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

  Block getBelow() {
    return down;
  }

  void setBelow(Block b) {
    down = b;
  }
}
