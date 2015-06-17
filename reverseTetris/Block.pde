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
  Boolean toBeRemoved = false;
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

  boolean willHave(int y, int c) {
    Block temp = this;
    while ( (temp!= null)&&((int)temp.yCor> y + 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blockt to check
    if ( temp ==null) {
      return false;
    }  
    //        if (temp.fillColor ==c) {
    //    return true;
    //  }
    while ( (temp!= null)&&((int)temp.yCor> y -50 )) {
      if ((temp.fillColor ==c) && (temp.yCor==y)) {
        temp.toBeRemoved = true;
        return true;
      } 
      temp = temp.getNext();
    }
    //at this point best case is temp is uppermost noude 
    //of 3 block colum this method checks 
    return false;
    //   if (temp==null) {
    //      return false;
    //    }
    //    if (temp.fillColor ==c) {
    //    return true;
    //  }
    //    
    //    return  temp.fillColor ==c;
  }
  boolean willCenterHave(int y, int c) {//works only for the center block(what's clicked)
    Block temp = this;
    while ( (temp!= null)&&((int)temp.yCor> y + 50 )) {
      temp = temp.getNext();
    }// at this point block it bottom of the column of 3 blockt to check
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
    //at this point best case is temp is uppermost noude 
    //of 3 block colum this method checks 
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

    //these should be the starting blocks 
    //of the linked list
    left = bl[i - 1]; 
    right = bl[i + 1];
    return left.willHave(Y, fillColor ) ||
      center.willCenterHave(Y, fillColor) || 
      right.willHave(Y, fillColor);
  }
  void removeBlock(Boolean yes) {
    if (yes) {
      //      int c = fillColor;
      //      Block temp = bl[(int)xCor/50];
      //      while((temp.getNext()!=null) &&(temp.fillColor!=c)) {
      //        temp = temp.getNext();
      //      }//at this point temp's next has color c
      //      temp.setNext(null);//nodes with color c no longer attatched to linked list
      //  Block temp2 = this;
      //      while ((temp2!=null) && (temp2.getNext().fillColor == c)){
      /////  fillColor = #FF03FB;

      if ((int)xCor/50-1 >= 0) {
        removeSingle((int)xCor/50 - 1, (int) yCor, fillColor);
      }
      if ((int)xCor/50+1 < 19) {
        removeSingle((int)xCor/50 +1, (int) yCor, fillColor);
      } 
      removeSingle((int)xCor/50, (int) yCor, fillColor);

      //  

      //      temp2 = temp2.getNext();
      //      }//at this point ever next should be in moving
      //      while (temp2!=null){
      //        movers.add(temp2);
      //        temp2 = temp2.getNext();
      //      }
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
        //      while (piggyback!=null && piggyback.toBeRemoved) {
        //        piggyback.getBelow().setNext(null);
        //        piggyback = piggyback.getBelow();
        //        update();
        //      }
      } else {
        alternateRemove(index);
        //      Block temp = deleted.getNext();
        //      piggyback.setNext(null);
        //      temp.setBelow(piggyback);
        //      deleted = null;
        //      shiftTheRest(temp);
        //      killTheLower(piggyback);
        //      while (temp!=null) {
        //        if (!temp.toBeRemoved) {
        //          piggyback.setNext(temp);
        //          movers.add(temp);//every thing above piggyback is in the movers arraylist
        //        } else{
        //          if (temp.getNext()!= null){
        //          movers.add(temp.getNext());
        //          } else{
        //           temp.setNext(null);
        //          }
        //        }
        //        piggyback = temp;
        //        temp = temp.getNext();
        //      }
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

