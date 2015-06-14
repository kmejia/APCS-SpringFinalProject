import java.io.*;
import java.util.*;

Random rnd = new Random();
int numCellsRow = 500;
int numCellsCol = 1000;
int cellSize = 50;
boolean lose = false;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
ArrayList<Block> movers = new ArrayList<Block>();
Block[] bl = new Block[20];//the array of linked lists at the bottom
int score =0;
int[] colors = {
  #FF0000, #00FF00, #0000FF, #F6FF00
};
int counter = 0;
//Block test = new Block((0*50) + 25, 427, #FFFFFF);
//Block test2 =new Block((0*50) + 25, 427 - 50, #FFFFFF);
void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  //triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
  /*the new part -ish for setup purposes*/
  for (int i = 0; i<bl.length; i++) {
    bl[i] = new Block( 50*i, 450, #FFFFFF ); //the bottom row
    //Block d =new Block(50 *i, (int)(bl[i].yCor) - 50, #FFFFFF);
    //d.drawMe();
    bl[i].setNext(new Block(50 *i, (int)(bl[i].yCor) - 50, #FFFFFF));
    //bl[i].getNext().drawMe();
    // System.out.println(bl[i].getNext());
    //System.out.println((int)(bl[i].yCor) - 100);
  }
  /*thiss part
   
   
   
   
   
   
   
   */


  // Block test= new Block(0, 25, #FFFFFF)  ;
  //  test.setBelow(test.findBelow());
  // movers.add(test); 

  //    for (int i = 0; i<bl.length; i++) {
  //      for(Block temp=bl[i];temp!=null; temp = temp.getNext()) {
  //      temp.drawMe();
  //      }
  //    }
  //  drawBlocks();
  //blocks.add(new Block());
}

void makeGrid() {
  for (int col = 0; col<grid.length; col++) {
    for (int row = 0; row<grid[0].length; row++) {
      grid[col][row] = new Cell(col, row);
    }
  }
}

void drawOutline() {
  if (mouseX >=0 && mouseY >= 0 && mouseX <= cellSize*grid.length && mouseY <= cellSize*grid[0].length) {
    grid[mouseX/cellSize][mouseY/cellSize].outlineMe();
  }
}


void draw() {
  //System.out.println(mouseY);
  if (!lose) {
    background(0);
    //lost();
    //    test.drawMe();
    //    test.getNext().drawMe();
    /*uncomment below to see what happens under update 
     
     */
      update();
    drawBlocks();
    moveBlocks();
    //   drawOutline();
    if (frameCount%120==0) {
      movers.add(new Block(0, 0, #FFFFFF));
    }
    //    if (frameCount%60==0) {
    //      Block temp = new Block(colors[rnd.nextInt(colors.length)],counter);
    //      //counter++;
    //      //System.out.println(counter);
    //      //System.out.println((temp.xCor-25)/50);
    //      if (bl[((int)temp.xCor-25)/50]!=null) {
    //        Block end = bl[((int)temp.xCor-25)/50];
    //        while (end.getNext () != null) {
    //          end = end.getNext();
    //        }
    //        end.setNext(temp);
    //      } else { 
    //        bl[((int)temp.xCor-25)/50] = temp;
    //      }
    //      // blocks.add(new Block(colors[rnd.nextInt(colors.length)]));
    //    }
    //    //System.out.println(mouseX);
    //    //System.out.println(mouseY);
    //  }
    //else {endSequence();}
    //System.out.println(bl[0]);
  }
}
void update() {
  for (int i = 0; i<movers.size (); i++) {
    Block temp = movers.get(i);
    int j= (int)temp.xCor / 50;//the converted xCor
    Block list = bl[j];
    while (list.getNext ()!= null) {
      list = list.getNext();
    }
    //at this point list is the last node
    //now i want to check if it's right below temp, which is moving
    if ((int)list.yCor - 50 ==(int)temp.yCor) {
      list.setNext(temp);
      movers.remove(temp);
    }
  }
}

void drawBlocks() {
  for (int i = 0; i<bl.length; i++) {
    for (Block temp=bl[i]; temp!=null; temp = temp.getNext ()) {
      temp.drawMe();
    }
  }
}
void moveBlocks() {
  for (int i = 0; i<movers.size (); i++) {
    Block temp = movers.get(i);
    temp.drawMe();
    temp.move();
  }
}
//int i = 1;
//Block temp = bl[i];
//while(temp!=null) {
//  temp.drawMe();
//  temp = temp.getNext(); }

//void cancel(){
// blocks.get(4).moving = false;
//}

//void moveBlocks() {
//  for (int i = 0; i < bl.length; i++) { 
//    for (Block temp = bl[i]; temp != null; temp = temp.getNext ()) {
//      Block front = bl[((int)temp.xCor-25)/50];
//      Block end = front;
//      while (end.getNext()!= null) {
//        end = end.getNext();
//      }
//      if (findBelow(temp, end)) {
//        end.setNext(temp);
//        temp.drawMe();
//      } else {
//        temp.move();
//        //      for (int r = 0; r < blocks.size (); r++) {
//        //        if (X == (int)blocks.get(r).xCor && Y + cellSize == (int)blocks.get(r).yCor) {
//        //          temp2 = blocks.get(r);
//        //        }
//        //      }
//        //      //  temp.setDown(temp2);\
//      }
//    }
//  }
//}

//void moveBlocks() {
//  for (int i = 0; i < bl.length; i++) {
//    for (Block temp = bl[i]; temp != null; temp = temp.getNext ()) {
//      Block front = bl[((int)temp.xCor-25)/50];
//      Block end = front;
//      System.out.println(front);
//      while (end.getNext () != null) {
//        end = end.getNext();
//      }
//      temp.setDown(end);
//      temp.move();
//      if (!findBelow(temp, end)) {
//        temp.move();
//      }
//      else{
//        System.out.println("We're almost there");
//        temp.setMoving(false);
//        temp.drawMe();
//      }
//    }
//  }
//}

//boolean findBelow(Block b, Block end) {
//  int X = (int)b.xCor;
//  int Y = (int)b.yCor;
//  if (end.counter != b.counter) {
//    if ((int)b.yCor <= (int)end.yCor+cellSize*2){
//      return true;
//    }
//  }
//  return false;
//}

//boolean lost() {
//  for (int n = 0; n < blocks.size (); n++) {
//    if (blocks.get(n).yCor == 0) {
//      lose = true;
//    }
//  }
//  return lose;
//}

void mousePressed() {
  lose = true;//placeholder
}

void endSequence() {
  noLoop();
  background(1);
  System.out.println("score" +score);
} 

