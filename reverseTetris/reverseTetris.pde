import java.io.*;
import java.util.*;

Random rnd = new Random(); S
int numCellsRow = 500;
int numCellsCol = 1000;
int cellSize = 50;
boolean lose = false;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
ArrayList<Block> movers = new ArrayList<Block>();
Block[] bl = new Block[20];//the array of linked lists at the bottom
int[] colors = {
  #FF0000, #00FF00, #0000FF, #F6FF00
};
int difficulty = 0;

void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  makeGrid();
  for (int i = 0; i<bl.length; i++) {
    bl[i] = new Block( 50*i, 450, #FFFFFF );
  }
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
    update();
    drawBlocks();
    moveBlocks();
    update();
    drawOutline();
    if (frameCount% (120 - difficulty)==0) {
      movers.add(new Block(rnd.nextInt(20) * 50, 0, colors[rnd.nextInt(colors.length)]));
    }
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
  if (frameCount < 3600) {
    difficulty = 90;
  }
  if (frameCount < 3600) { 
    difficulty = 60;
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
  if ((current!=null )&&(current.fillColor!=#FFFFFF)) {
    if (current.hasFriends()) {
      current.toBeRemoved = true;
      current.removeBlock(current.hasFriends());
    }
    update();
  }
}

void endSequence() {
  noLoop();
  System.out.println("You have lost. Try again by closing this and starting a new round.");
}

