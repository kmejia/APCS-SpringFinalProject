import java.io.*;
import java.util.*;

Random rnd = new Random();
int numCellsRow = 495;
int numCellsCol = 1000;
int cellSize = 50;
Cell[][] grid = new Cell[numCellsCol][numCellsRow];
ArrayList<Block> blocks = new ArrayList<Block>();
int[] colors = {#FF0000, #00FF00, #0000FF, #F6FF00};

void setup() {
  size(1000, 500);
  background(1);
  fill(0);
  //triangle(18, 18, 18, 360, 81, 360);
  makeGrid();
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
  if (mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
//    int x = mouseX / cellSize;
//    int y = mouseY / cellSize;
   grid[mouseX/cellSize][mouseY/cellSize].outlineMe();
//background(#012489);
  }
}

void draw() {
  background(255);
  moveBlocks();
  drawOutline();
  drawBlocks();
  if (frameCount%60==0){
    blocks.add(new Block(colors[rnd.nextInt(colors.length)]));
  }
  System.out.println(mouseX);
  System.out.println(mouseY);

}

void drawBlocks(){
  for (int i = 0 ; i < blocks.size();i++){
    blocks.get(i).drawMe();
  }
}
//void cancel(){
// blocks.get(4).moving = false;
//}
void moveBlocks(){
    for (int i = 0 ; i < blocks.size();i++){ 
Block temp = blocks.get(i);
//for (int i = 0 ; i < blocks.size();i++){ 
//if (!findBelow(temp)){
// 
temp.move();}
    }
//   }

// boolean findBelow(Block b){
//   int Y = (int)b.yCor;
//     for (int i = 0 ; i < blocks.size();i++){
//       if Y + 25 = (int)blocks.get(i).yCor{ 
//         return true;
//       }
//     }return false
// }
//   
void mousePressed(){
 
}

