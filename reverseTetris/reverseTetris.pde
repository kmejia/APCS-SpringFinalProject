
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
  #FF0000, #00FF00//, #0000FF, #F6FF00
};
int difficulty = 0;
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
    ///////////////////    //bl[i].setNext(new Block(50 *i, (int)(bl[i].yCor) - 50, #FFFFFF));
    //bl[i].getNext().drawMe();
  }
  /*thiss part*/


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
  if (!lost()) {
    background(0);
    //    test.drawMe();
    //    test.getNext().drawMe();
    /*uncomment below to see what happens under update 
     
     */
    update();
    drawBlocks();
    moveBlocks();
    update();
    drawOutline();
    if (frameCount% (/*120 - difficulty*/ 60)==0) {
      movers.add(new Block(rnd.nextInt(20) * 50, 0, colors[rnd.nextInt(colors.length)]));
    }
    //    for(int i = 0;i<bl.length;i++){
    //      Block  b = bl[i] ;
    //      while (b!=null){
    //        b = b.getNext();
    //      }
    //    }
  } else {
    endSequence();
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
    if ((int)list.yCor - 50 <=(int)temp.yCor) {
      list.setNext(temp);
      temp.setBelow(list);
      movers.remove(temp);
    }
  }
  //  if (frameCount < 3600) {
  //    difficulty = 90;
  //  }
  //  if (frameCount < 3600) { 
  //    difficulty = 60;
  //  }
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

boolean lost() {
  for (int n = 0; n < bl.length; n++) {
    for (Block temp = bl[n]; temp != null; temp = temp.getNext ()) {
      if ((int)temp.yCor < cellSize) {
        lose = true;
      }
    }
  }
  return lose;
}

Block isBlock() {
  int clickX = mouseX/50;
  int clickY = mouseY/50;
  int Y = 9 - clickY;
  Block temp = bl[clickX];
  while (temp.getNext () != null && Y>0) {
    temp = temp.getNext();
    Y--;
  }
  if (Y!=0) {
    return null;
  } else {
    return temp;
  }
}

void mousePressed() {
  Block current = isBlock();
  if (current != null) {   
    System.out.println("current is "+current + " color is " + current.fillColor + " and nextBlock is " + current.getNext() + " and belowBlock is " + current.getBelow());
  } else {
    System.out.println("@Ghost");
  }
  if ((current!=null )&&(current.fillColor!=#FFFFFF)) {
    if (current.hasFriends()) {
      current.toBeRemoved = true;
      current.removeBlock(current.hasFriends());
    }
    //score++;
    update();
  }
}

void endSequence() {
  noLoop();
  //background(1);
  System.out.println("You have lost. Try again by closing this and starting a new round.");
}

