import java.io.*;
import java.util.*;

Random rnd = new Random();
int numCellsRow = 495;
int numCellsCol = 1000;
int cellSize = 50;
boolean lose = false;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
ArrayList<Block> blocks = new ArrayList<Block>();
Block[] bl = new Block[20];//the linked
int[] colors = {
  #FF0000, #00FF00, #0000FF, #F6FF00
};

void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  //triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
  //  for (int i = 0; i<bl.length; i++) {
  //    bl[i] = new Block(); //null as the bottom
  //
  //    System.out.println(bl[i]);
  //}
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
  if (!lose) {
    background(0);
    //lost();
    moveBlocks();
    drawOutline();
    drawBlocks();
    if (frameCount%60==0) {
      Block temp = new Block(colors[rnd.nextInt(colors.length)]);
      System.out.println((temp.xCor-25)/50);
      if (bl[((int)temp.xCor-25)/50]!=null) {
        temp.setNext(bl[((int)temp.xCor-25)/50]);
        System.out.println("this be working");
      } else { 
        bl[((int)temp.xCor-25)/50] = temp;
      }
      // blocks.add(new Block(colors[rnd.nextInt(colors.length)]));
    }
    //System.out.println(mouseX);
    //System.out.println(mouseY);
  }
  //System.out.println(bl);
}

void drawBlocks() {
  for (int i = 0; i < bl.length; i++) {
    for (Block temp = bl[i]; temp!= null; temp = temp.getNext ()) {
      bl[i].drawMe();
    }
  }
}
//void cancel(){
// blocks.get(4).moving = false;
//}
void moveBlocks() {
  for (int i = 0; i < bl.length; i++) { 
    Block piggyback = bl[((int)temp.xCor-25)/50].;
    for (Block temp = bl[i]; temp != null; temp = temp.getNext()) {
      piggyback = temp;
      if (findBelow(temp, i)) {
        temp.setNext(null);
        temp.drawMe();
      } else {
        temp.move();
        //      for (int r = 0; r < blocks.size (); r++) {
        //        if (X == (int)blocks.get(r).xCor && Y + cellSize == (int)blocks.get(r).yCor) {
        //          temp2 = blocks.get(r);
        //        }
        //      }
        //      //  temp.setDown(temp2);\
        
      }
    }
  }
}

boolean findBelow(Block b, int index) {
  int X = (int)b.xCor;
  int Y = (int)b.yCor;
  // int r = 0;
  for (Block temp = bl[index]; temp !=null; temp = temp.getNext ()) {
    if ( (int)Y + cellSize == (int)temp.yCor) { 
      // temp.setNext(b);
      System.out.println("working");
      return true;
    }
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
}

