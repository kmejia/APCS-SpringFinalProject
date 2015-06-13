import java.io.*;
import java.util.*;

Random rnd = new Random();
int numCellsRow = 495;
int numCellsCol = 1000;
int cellSize = 50;
boolean lose = false;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
//ArrayList<Block> blocks = new ArrayList<Block>();
Block[] bl = new Block[20];//the linked lists
int score =0;
int[] colors = {
  #FF0000, #00FF00, #0000FF, #F6FF00
};

void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  //triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
  /*the new part -ish for setup purposes
   for (int i = 0; i<bl.length; i++) {
   bl[i] = new Block((i*50) +25,475,#0000FF); //the bottom row
   bl[i].setNext(new Block((i*50) +25 ,(int)(bl[i].yCor - 50) ,  #F6FF00));
   //System.out.println(bl[i]);
   } */
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
    drawBlocks();
    moveBlocks();
    drawOutline();
    if (frameCount%60==0) {
      Block temp = new Block(colors[rnd.nextInt(colors.length)]);
      //System.out.println((temp.xCor-25)/50);
      if (bl[((int)temp.xCor-25)/50]!=null) {
        Block end = bl[((int)temp.xCor-25)/50];
        while (end.getNext () != null) {
          end = end.getNext();
        }
        end.setNext(temp);
      } else { 
        bl[((int)temp.xCor-25)/50] = temp;
      }
      // blocks.add(new Block(colors[rnd.nextInt(colors.length)]));
    }
    //System.out.println(mouseX);
    //System.out.println(mouseY);
  }
  //else {endSequence();}
  //System.out.println(bl);
}

void drawBlocks() {
  for (int i = 0; i < bl.length; i++) {
    for (Block temp = bl[i]; temp!= null; temp = temp.getNext ()) {
      //System.out.println("got here");
      bl[i].drawMe();
    }
  }
}
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

void moveBlocks() {
  for (int i = 0; i < bl.length; i++) {
    for (Block temp = bl[i]; temp != null; temp = temp.getNext ()) {
      Block front = bl[((int)temp.xCor-25)/50];
      Block end = front;
      while (end.getNext () != null) {
        end = end.getNext();
      }
      if (!findBelow(temp, end)) {
        temp.move();
      }
    }
  }
}

boolean findBelow(Block b, Block end) {
  int X = (int)b.xCor;
  int Y = (int)b.yCor;
  if (bl[(X-25)/50] != null && Y+50 == (int)end.yCor) {
    return true;
  }
  return false;
}

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
  //System.out.println("score" +score);
} 

