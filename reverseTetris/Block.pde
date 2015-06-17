import java.util.*;

class Block {
  Random rnd = new Random();
  float xCor, yCor;
  float speed = 5;
  int fillColor;
  Block below;
  Block next;
  Boolean toBeRemoved = false;
  boolean moving = true;
  public String toString() {
    String ans = "" ;
    return ans  + xCor+"," + yCor;
  }
  Block(int x, int y, int colour) {
    xCor = x;
    yCor = y; 
    fillColor = colour;
    next=null;
    below = null;
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

  boolean willHave(int y, int c) {
    Block temp = this;
    while ( (temp!= null)&&((int)temp.yCor> y + 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blocks to check
    if ( temp ==null) {
      return false;
    }  
    while ( (temp!= null)&&((int)temp.yCor< y -50 )) {
      if ((temp.fillColor ==c) && (temp.yCor==y)) {
        temp.toBeRemoved = true;
        return true;
      } 
      temp = temp.getNext();
    }
    //at this point best case is temp is uppermost node of 3 block column this method checks 
    return false;
  }
  boolean willCenterHave(int y, int c) {
    //works only for the center block(what's clicked)
    Block temp = this;
    while ( (temp!= null)&&((int)temp.yCor> y + 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blocks to check
    if (temp==null) {
      return false;
    }
    if ((temp.fillColor ==c) && ((int)temp.yCor!=y)) {            
      temp.toBeRemoved = true;
      return true;
    }
    while ( (temp!= null)&&((int)temp.yCor> y -50 )) {
      if ( (temp.fillColor ==c) && (temp.yCor!=y)) {//we dont count the block itself
        return true;
      } 
      temp = temp.getNext();
    }
    //at this point best case is temp is uppermost node of 3 block colum this method checks 
    if (temp==null) {
      return false;
    }
    if (temp.fillColor ==c) {        
      temp.toBeRemoved = true;
      return true;
    }     

    return  temp.fillColor ==c;
  }
  boolean hasFriends() {
    int Y = (int)yCor;
    int i = (int)xCor / 50;
    Block left, center, right;
    center = bl[i + 0]; 
    //cases for when we click the left/right edges
    if (i==0) {
      right = bl[i + 1]; 
      return right.willHave(Y, fillColor ) ||
        center.willCenterHave(Y, fillColor) ;
    }
    if (i==19) {
      left = bl[i - 1];  
      return left.willHave(Y, fillColor ) ||
        center.willCenterHave(Y, fillColor) ;
    }

    //these should be the starting blocks of the linked list
    left = bl[i - 1]; 
    right = bl[i + 1];
    return left.willHave(Y, fillColor ) ||
      center.willCenterHave(Y, fillColor) || 
      right.willHave(Y, fillColor);
  }
  void removeBlock(Boolean yes) {
    if (yes) {
      if ((int)xCor/50-1 >= 0 ) {
        removeSingle((int)xCor/50 - 1, (int) yCor, fillColor);
      }
      if ((int)xCor/50+1 < 19 ){
        removeSingle((int)xCor/50 +1, (int) yCor, fillColor);
      } 
      removeSingle((int)xCor/50, (int) yCor, fillColor);
    }
  }
  void removeSingle(int index, int y, int clr) {
    Block deleted = bl[index];
    Block piggyback = deleted;
    while (deleted.getNext () != null && deleted.yCor > y) {
      piggyback = deleted;
      deleted = deleted.getNext();
    }
    if (clr == deleted.fillColor) {
      if (deleted.getNext() ==null) {//case where the tippy top block is deleted
        piggyback.setNext(null);
        deleted = null;
        killTheLower(piggyback);
      } else {
        alternateRemove(index);
      }
    }
  } 

  /* Various (graveyard) of functions to stack blocks...
   void shiftTheRest(Block first) {
   int emergency = 10;
   while (first!=null && emergency>0) {
   emergency--;
   Block temp = first;
   Block next;
   if (!first.toBeRemoved) {
   next = first.getNext();
   temp.setNext(null);
   movers.add(temp);
   } else {
   next = first.getNext();
   temp.setNext(null);
   //        if (temp.getNext()!=null && temp.getNext().getNext()!=null) {
   //          next = temp.getNext().getNext();
   //        } else {
   //          next = null;
   //        }
   }
   first = next;
   temp.setNext(null);
   update();
   }
   }
   
   void killTargeted(Block first) {
   Block trace = bl[(int)first.xCor/50];
   Block head = first.getNext();
   while (head.getNext () != null) {  
   boolean move = true;
   trace = head;
   if (head.toBeRemoved) {
   Block temp = head;
   move = false;
   trace.setNext(null);
   if (temp.getNext() != null) {
   movers.add(temp.getNext());
   }
   temp = null;
   }
   if (move) {
   trace = trace.getNext();
   }
   head = head.getNext();
   }
   }
   */

  void killTheLower(Block piggyback) {
    while (piggyback!=null && piggyback.toBeRemoved) {
      piggyback = piggyback.getBelow();      
      piggyback.setNext(null);
      update();
    }
    piggyback.setNext(null);
  }

  void alternateRemove(int index) {
    Block blk = bl[index];
    Block start = blk;
    boolean other = false;
    while (blk.getNext () != null) {
      blk = blk.getNext();
    } 
    while (blk.getBelow () != null) {
      if (!blk.toBeRemoved) {    
        movers.add(blk);
      }
      blk = blk.getBelow();
      blk.setNext(null);
    }
    //    while (blk != null) {
    //      if (blk.toBeRemoved) {
    //        blk = blk.getNext();
    //      } else {
    //        other = false;
    //        Block next = blk;
    //        while (next!=null&&next.toBeRemoved) {
    //          next = next.getNext();
    //        }
    //        if (next.getNext()!=null) {
    //          blk = next.getNext();
    //        } else {
    //          blk.setNext(next); 
    //          blk = next;
    //        }
    //      }
    //      if (other) {
    //        bl[index] = start;
    //      }
    //    }
  }

  Block getBelow() {
    return below;
  }

  void setBelow(Block b) {
    below = b;
  }
}

