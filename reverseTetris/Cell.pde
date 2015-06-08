class Cell{
  int col, row;
  
  Cell(int a, int b){
    col = a;
    row = b; 
  }
  boolean taken = false;
  void outlineMe(){
    noFill();
    stroke(#FFFFFF);
    rectMode(CORNER);
    rect(col * cellSize, row * cellSize, cellSize, cellSize); 
    rectMode(CENTER);
    stroke(0);
  }
}


