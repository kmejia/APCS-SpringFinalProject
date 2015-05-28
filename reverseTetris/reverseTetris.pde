import java.io.*;

int numCellsCol = 1000;
int numCellsRow = 500;
int cellSize = 50;
Cell[][] grid = new Cell[numCellsRow][numCellsCol];
void setup() {
  size(1000, 500);
  background(#B40202);
  fill(0);
  triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
}
void makeGrid() {
  for (int col = 0; col<grid.length; col++) {
    for (int row = 0; row<grid[0].length; row++) {
      grid[col][row] = new Cell(col, row);
    }
  }
}
void draw() {
  if(mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    grid[x][y].drawOutline();
}
}

void mousePressed(){
  background(#EAB915);
}

