import java.util.*;

class Block {
  Random rnd = new Random();
  float xCor, yCor;
  float speed = 5;
  int fillColor;
  Block left;
  Block right;
  Block up;
  Block below;
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
    below = null;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
  }
  Block(int x, int y, int colour) {
    xCor = x;
    yCor = y; 
    fillColor = colour;
    next=null;
    below = null;
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
    Block temp = this;
    System.out.println(temp);
    while ((temp!= null )&& ((int)temp.yCor!= y - 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blockt to check
  if ( temp ==null) {
    return false;
      }  
      while (( temp!= null)&&((int)temp.yCor!= y + 50)) {
       if( temp.fillColor ==c) {
        return true;
       } 
        temp = temp.getNext();
      }
      //at this point best case is temp is uppermost noude 
      //of 3 block colum this method checks 
      if (temp==null) {
      return false;    
      }
      return  temp.fillColor ==c;
  }
  boolean willCenterHave(int y, int c){//works only for the center block(what's clicked)
    Block temp = this;
    while ((temp!= null)&&((int)temp.yCor!= y - 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blockt to check
  if ( temp ==null) {
    return false;
      }  
      while ((temp!= null)&&(int)temp.yCor!= y + 50 ) {
       if( (temp.fillColor ==c) && (temp.yCor!=y)) {//we dont count the block itself
        return true;
       } 
        temp = temp.getNext();
      }
      //at this point best case is temp is uppermost noude 
      //of 3 block colum this method checks 
      if (temp==null) {
      return false;    
      }
      return  temp.fillColor ==c;
  }
  boolean hasFriends() {
    int Y = (int)yCor;
    int i = (int)xCor / 50;
    Block left,center, right;
        center = bl[i + 0]; 
        //cases for when we click the left/right edges
    if (i==0) {
    right = bl[i + 1]; 
     return right.willHave(Y ,fillColor ) ||
   center.willCenterHave(Y ,fillColor) ; 
    }
    if(i==19) {
     left = bl[i - 1];  
     return left.willHave(Y ,fillColor ) ||
   center.willCenterHave(Y ,fillColor) ;
    }
    
    //these should be the starting blocks 
                                   //of the linked list
left = bl[i - 1]; 
 right = bl[i + 1];
   return left.willHave(Y ,fillColor ) ||
   center.willCenterHave(Y ,fillColor) || 
    right.willHave(Y ,fillColor);
  }
  void removeBlock(Boolean yes){
    if(yes){
   fillColor = #000000;
     }
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
