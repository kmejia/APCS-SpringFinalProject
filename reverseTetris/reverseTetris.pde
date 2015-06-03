import java.io.*;
import java.util.*;
int numCellsRow = 495;
int numCellsCol = 1000;
int cellSize = 50;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
ArrayList<Block> blocks = new ArrayList<Block>();
void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  //triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
  blocks.add(new Block());
}
void makeGrid() {
  for (int col = 0; col<grid.length; col++) {
    for (int row = 0; row<grid[0].length; row++) {
      grid[col][row] = new Cell(col, row);
    }
  }
}
void drawOutline() {
  if (mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
//    int x = mouseX / cellSize;
//    int y = mouseY / cellSize;
   grid[mouseX/cellSize][mouseY/cellSize].outlineMe();
//background(#012489);
  }
}

void draw() {
 background(1);
drawOutline();
drawBlocks();
if (frameCount%60==0){
    blocks.add(new Block());
}
moveBlocks();

}

void drawBlocks(){
  for (int i = 0 ; i < blocks.size();i++){
    blocks.get(i).drawMe();
  }
}
void moveBlocks(){
    for (int i = 0 ; i < blocks.size();i++){
    blocks.get(i).move();
  }
}
  
void mousePressed(){
 // background(#EAB915);
}

