class Cell{
  int col, row;
  
  Cell(int a, int b){
    col = a;
    row = b; 
  }
  
  void outlineMe(){
    if (mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length &&
    mouseY < cellSize*grid[0].length) {
    noFill();
    stroke(#00FF00);
    rectMode(CORNER);
    rect(col * cellSize, row * cellSize, cellSize, cellSize); 
    rectMode(CENTER);
    stroke(0);
    }
  }
void drawOutline() {
  if(mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    grid[x][y].outlineMe();
  }
}
}
