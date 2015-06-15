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
    below = null
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
  }
  Block(int x, int y, int colour) {
    xCor = x;
    yCor = y; 
    fillColor = colour;
    next=null;
    below = null
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

  Block getNext() {
    return next;
  }
  
  void setNext(Block n) {
    next = n;
  }
  /* new content*/
  boolean willHave(int y, int c){
    
  return false;
  }
  boolean hasFriends() {
    int Y = yCor;
    Block left = bl[(int)xCor / 50 - 1]; 
   Block center = bl[(int)xCor / 50 + 0]; 
   Block  left = bl[(int)xCor / 50 + 1]; 
   return left.willHave(Y ,fillColor ) ||
   center.willCenterHave(y ,fillColor) || 
   and right.willHave(y ,fillColor);
  }
  void removeBlock(Boolean yes){
    if(yes){
   fillColor = #000000;
   "
  }

  Block getLeft() {
    return left;
  }

  void setLeft() {
  }

  Block getRight() {
    return right;
  }

  Block getBelow() {
    return below;
  }

  void setBelow(Block b) {
    below = b;
  }
}
