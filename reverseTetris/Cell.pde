class Cell{
  int col,  Srow;
  
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
    stroke(0);
  }
}


