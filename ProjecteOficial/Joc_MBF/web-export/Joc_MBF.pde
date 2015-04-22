PImage[] img = new PImage[6];
void setup() {
  size(1080, 480);
  background(0);
  frameRate(6);
  img[0] = loadImage("Characters/p1_spritesheet.png");
  img[1] = img[0].get(25, 25, 25, 25);
  
}


void draw (){
 //image(img[0], 0, 0); 
 image(img[1], 50, 50); 
 //PImage asdasd = get(50,90);
 //asdasd(350, 300);
}

