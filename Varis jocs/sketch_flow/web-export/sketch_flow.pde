int[][] board = {
  {0, 1, 0, 0, 0, 0, 0, 2}, 
  {0, 3, 0, 0, 0, 0, 4, 0}, 
  {0, 0, 0, 0, 5, 0, 6, 0}, 
  {0, 0, 0, 6, 0, 0, 2, 0}, 
  {0, 0, 0, 1, 7, 0, 0, 0}, 
  {0, 3, 4, 0, 0, 0, 7, 0}, 
  {0, 0, 0, 0, 5, 0, 0, 0}, 
  {8, 0, 0, 0, 0, 0, 0, 8}
};
int gw = 50,startx, starty, curx, cury; boolean selected = false, won = false;
color numToColor(int num) {
  if (num==1) return color(0, 0, 255);   if (num==2) return color(255, 0, 0);
  if (num==3) return color(255, 100, 0); if (num==4) return color(0, 255, 0);
  if (num==5) return color(0, 255, 255); if (num==6) return color(255, 0, 255);
  if (num==7) return color(255, 255, 0); if (num==8) return color(50, 0, 100);
  return color(255);
}
void setup() { size(400,400); size(board[0].length*gw, board.length*gw); ellipseMode(CORNER); }
void drawboard() {
  for (int j=0;j<board.length;j++) {
    for (int i=0;i<board[j].length;i++) {
      int x = i*gw,y = j*gw;
      fill(0); stroke(100); rect(x, y, gw, gw);
      fill(numToColor(board[j][i]));
      if (board[j][i]>0) ellipse(x, y, gw, gw);
      if (board[j][i]<0) { //pipes are less than 0
        boolean left = false, right = false, above = false, below = false;
        if( i > 0 && abs(board[j][i])==abs(board[j][i-1])) left = true;
        if( j > 0 && abs(board[j][i])==abs(board[j-1][i])) above = true;
        if( i < board.length-1 && abs(board[j][i])==abs(board[j][i+1])) right = true;
        if( j < board.length-1 && abs(board[j][i])==abs(board[j+1][i])) below = true;
        fill(numToColor(-board[j][i]));
        noStroke();
        rect(x+gw/4, y+gw/4, gw/2, gw/2);
        if(above && below) rect(x+gw/4, y, gw/2, gw);
        if(left && right) rect(x, y+gw/4, gw, gw/2);
        if(above && left) { rect(x, y+gw/4, gw/2, gw/2); rect(x+gw/4, y, gw/2, gw/2); }
        if(above && right) {rect(x+gw/2, y+gw/4, gw/2, gw/2); rect(x+gw/4, y, gw/2, gw/2); }
        if(below && left) { rect(x, y+gw/4, gw/2, gw/2); rect(x+gw/4, y+gw/2, gw/2, gw/2); }
        if(below && right) {rect(x+gw/2, y+gw/4, gw/2, gw/2); rect(x+gw/4, y+gw/2, gw/2, gw/2); }
      }
    }
  }
}
void checkwin() {
  won = true;
  for (int j=0;j<board.length;j++) for (int i=0;i<board[j].length;i++) {
    boolean foundpipe = false;
    if (board[j][i]>0) {
      for (int m=0;m<board.length;m++) for (int k=0;k<board[m].length;k++)
        if (board[m][k]==-board[j][i]) foundpipe = true;
      if (foundpipe ==false) won = false;
    }
  }
}
void draw() {
  background(0); drawboard();
  if (!won) {
    if (mousePressed && !selected) {
      startx = int(mouseX / gw); starty = int(mouseY / gw);
      curx=startx; cury=starty;
      if (board[starty][startx] > 0) selected = true;
    }
    if (mousePressed==false && selected==true) {
      selected = false;
      int endx = -1, endy = -1;
      for (int j=0;j<board.length;j++) {
        for (int i=0;i<board[j].length;i++) {
          if ( !(i==startx && j==starty) && board[j][i] == board[starty][startx]) {
            endx = i; endy = j;
          }
        }
      }
      if (  (curx == endx && cury == endy + 1) ||
        (curx == endx && cury == endy - 1) ||
        (curx == endx + 1 && cury == endy) ||
        (curx == endx - 1 && cury == endy)) checkwin();
      else {
        for (int j=0;j<board.length;j++) {
          for(int i=0;i<board[j].length;i++) if(board[j][i]==-board[starty][startx]) board[j][i]=0;
        }
      }
    }
    if (mousePressed==true && selected==true) {
      int x = int(mouseX/gw), y = int(mouseY/gw);
      if (x>=0 && y >= 0 && y<board.length&&x<board[0].length && board[y][x]==0) { 
        if (  (x == curx + 1 && y == cury) ||
          (x==curx-1&&y==cury) || (x == curx && y == cury + 1) || (x == curx && y == cury - 1)) {
          board[y][x] = -board[starty][startx];
          curx = x; cury = y;
        }
      }
    }
  }
  else {
    fill(255); textAlign(CENTER); textSize(40); text("YOU WON", 0, height/2-50, width, height);
  }
}

