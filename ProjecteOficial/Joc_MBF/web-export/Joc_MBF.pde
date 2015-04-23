/* @pjs preload="Visual/Characters/Player/p1_spritesheet.png"; */

PImage src;
PFont font;
PImage backgroundimg = new PImage[3];
int w = 75, h = 95; //Width i Height de la part a agafar.
int cols = 4;
int currentSprite=0;
int totalSprites=12;

PImage frames[];
void setup() {
  size(1024, 512);
  frameRate(14);
  //smooth();
  src = loadImage("Visual/Characters/Player/p1_spritesheet.png");
  backgroundimg[0] = loadImage("Visual/Background/bg_castle.png");
  backgroundimg[1] = loadImage("Visual/Background/bg_desert.png");
  backgroundimg[2] = loadImage("Visual/Background/bg_grasslands.png");
  backgroundimg[3] = loadImage("Visual/Background/bg_shroom.png");

  font = loadFont("Arial, 16, true");
  fill(0);
  textFont(font, 18);
}

//Posa la imatge al background.
void drawbackground(var b) {
  background(b);
}

void drawtry(var printaa, var i) {
  if(i < 5){
    text(printaa, 255, 225+(i*22));
  }else{
    text(printaa, 475, 225+((i-5)*22));
  }
}

void draw() {

  drawbackground(backgroundimg[2]);


  String[] lines = loadStrings("Visual/Characters/Player/p1_spritesheet.txt");
  for (int i = 0; i < lines.length; i++) {
    drawtry(lines[i], i);
  }

  String asdomg = lines[5];
  text(asdomg, 55, 225);

  frames = new PImage[totalSprites];
  for (int i = 0; i<frames.length; i++) {
    int tx = floor(i%cols)*w;
    int ty = floor(i/cols)*h;
    frames[i]=src.get(tx, ty, w, h);
  }

  for (int i = 0; i<frames.length; i++) {
    image(frames[i], i*w, i, w, h);
  }
  //image(frames[currentSprite], mouseX, mouseY);
  image(frames[currentSprite], 50, 95);
  //currentSprite=(currentSprite+1)%totalSprites;
}


