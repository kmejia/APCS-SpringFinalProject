import java.util.*;

class Block{
  Random rnd = new Random();
  float xCor, yCor;
  float speed = 25;
  int fillColor;
  Block left;
  Block right;
  Block up;
  Block down;
  Block next;
  boolean moving = true;
  //color = data
  Block(int colour){
   xCor= 25+50*rnd.nextInt(20);
   yCor = 0;
   fillColor = colour;
    //xCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);      
  }
  
  Block(int x, int y, int colour){
   xCor = x;
   yCor = y; 
   fillColor = colour;
  }
   Block(){
    fillColor = 1;
   }
   
  void drawMe() {
    fill(fillColor);
    rect(xCor, yCor, cellSize, cellSize);
  }
  
  void move(){
    if( moving){
    //if (yCor <= numCellsRow-cellSize/2){
    if(yCor<=(numCellsRow-25)){
      yCor += speed;
    }
    }
      drawMe();
  }
 void stop(){
   moving = false;
   
 }
 void setNext(Block n){
   next = n;}
   
   Block getNext(){
     return next;
   }
  Block getLeft(){
    return left; 
  }
  
  void setLeft(){ 
  }
  
  Block getRight(){
    return right; 
  }
  
  Block getUp(){
    return up;
  }
  
  Block getDown(){
    return down;
  }
}
