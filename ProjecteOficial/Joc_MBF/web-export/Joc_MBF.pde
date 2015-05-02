/* @pjs preload="Visual/Background/bg_grasslands.png"; */


PImage[] src = new PImage[3];
PFont font;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[16];

boolean flipdone = false;
boolean direccioEsquerre = false;
boolean direccioDreta = true;
boolean direccio = false;
String coordptglinia;
int espai;
char chardins;
String[] coordfiltrades = new String[4];
int posicio = 15;
int tipusMoviment = 5;
boolean tipusMovimentChg = false;
boolean salta = false;

//Posició i Width i Height de la part a agafar del personatge.
int ptgx[] = new int[13];
int ptgy[] = new int[13];
int ptgw[] = new int[13];
int ptgh[] = new int[13];

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;


final static short DIM = 100, SPD = 4, BOLD = 4;
final static short FLOOR = 215, JUMP = 75;

static int dir, x, y = FLOOR;
var asd = 0;

void setup() {
  size(1024, 512);
  frameRate(7);
  //smooth();

  //Càrrega dels personatges del Jugador.
  for (int i = 0; i < pgtotal; i++) {
    //El carrega molts cops.
    src[i] = loadImage("Visual/Characters/Player/p"+i+"_spritesheet.png");
  }

  //Càrrega dels Background.
  backgroundimg[0] = loadImage("Visual/Background/bg_castle.png");
  backgroundimg[1] = loadImage("Visual/Background/bg_desert.png");
  backgroundimg[2] = loadImage("Visual/Background/bg_grasslands.png");
  backgroundimg[3] = loadImage("Visual/Background/bg_shroom.png");

  //Càrrega dels sons.


  //Atributs de la font
  font = loadFont("Arial, 16, true");
  fill(0);
  textFont(font, 18);
  
  //Inicialització
  movimentPtg();
  movDret(backgroundimg[2]);
}

void draw() {
  drawbackground(backgroundimg[2]);

  if (dir != 0)  move();
  rect(x, y, DIM, DIM);
  
  image(imgJugador[1], x+imgJugador[1].width, y+imgJugador[1].height);
}

void movDret(PImage b) {
  //Colisió extrem Esquerre.
  if (posicio > 1024-imgJugador[0].width) {
    posicio = posicio -10;
    movEsquerre(backgroundimg[2]);
  } else {
    drawbackground(b);
    if (direccio == true) {
      scale(-1, 1);
      direccio = false;
    }
    if (salta == true) {
      tipusMoviment = 3;
    }
    image(imgJugador[tipusMoviment], (posicio), 50);
    posicio = posicio + 4;
    canviImgPtgMvt();
  }
}

void movEsquerre(PImage b) {
  //Colisió extrem Dret.
  if (posicio < 0 ) {
    posicio = posicio +10;
    movDret(backgroundimg[2]);
  } else {
    drawbackground(b);
    if (direccio == false) {
      scale(-1, 1);
      direccio = true;
    }
    image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), 50);
    posicio = posicio - 4;
    canviImgPtgMvt();
  }
}

void saltar(PImage b) {
  canviImgPtgMvt();
}

//Fa l'efecte de moviment al canviar l'imatge del personatge, cames braços etc..
void canviImgPtgMvt() {

  if (salta == true) {
    tipusMoviment = 14;
    salta = false;
  } else {
    if (tipusMoviment < imgJugador.length-1) {
      tipusMoviment++;
    } else {
      tipusMoviment = 5;
    }
  }


  //Moviment simple 3x.
  /*if(tipusMoviment < 2 && tipusMovimentChg == false){
   tipusMoviment++;
   }else{
   tipusMoviment--;
   if(tipusMoviment == 0){
   tipusMovimentChg = false;
   }else{
   tipusMovimentChg = true;
   }
   }*/
}

void movimentPtg() {
  //Tría del personatge, 0-1.
  //Cárrega del .txt amb les coordenades linia per linia del personatge a l'Sprite Sheet.
  String[] lines = loadStrings("Visual/Characters/Player/p"+ptg+"_spritesheet.txt");
  //noLoop();

  //Linia a començar. 
  int liniaInici = 0;
  int liniafinal = 16;

  for (int j = liniaInici; j < liniafinal; j++) {
    lines[j].trim();
    coordptglinia = lines[j].substring(12);
    espai = 0;

    //Omplim l'array amb strings buits.
    for (int i = 0; i != coordfiltrades.length; i++) {
      coordfiltrades[i] = "";
    }

    //Agafem cada coordenada i l'assignem.
    //(X, Y, Width, Height)
    for (int i = 0; i < coordptglinia.length; i++) {
      chardins = coordptglinia.charAt(i);
      if (!chardins.equals(" ")) {
        if (espai == 0) {
          coordfiltrades[0] = coordfiltrades[0] + chardins;
        } else {
          if (espai == 1) {
            coordfiltrades[1] = coordfiltrades[1] + chardins;
          } else {
            if (espai == 2) {
              coordfiltrades[2] = coordfiltrades[2] + chardins;
            } else {
              coordfiltrades[3] = coordfiltrades[3] + chardins;
            }
          }
        }
      } else {
        espai++;
      }
    }

    //Pasem d'String a INT el contingut.
    ptgx[j] = parseInt(coordfiltrades[0]);
    ptgy[j] = parseInt(coordfiltrades[1]);
    ptgw[j] = parseInt(coordfiltrades[2]);
    ptgh[j] = parseInt(coordfiltrades[3]);
  }

  //Bucle que carrega els sectors de la sheet a un array d'imatges.
  for (int i = liniaInici; i < liniafinal; i++) {
    imgJugador[i] = src[ptg].get(ptgx[i], ptgy[i], ptgw[i], ptgh[i]);
  }
}

//Posa l'imatge al background.
void drawbackground(PImage b) {
  background(b);
}

void drawtry(String printaa, int i) {
  if (i < 5) {
    text(printaa, 255, 225+(i*22));
  } else {
    text(printaa, 475, 225+((i-5)*22));
  }
}
/*
void keyPressed()
 {
 if (keyCode == RIGHT || key == 'd' || key == 'D'){
 movDret(backgroundimg[2]);
 }else{
 if (keyCode == LEFT || key == 'a' || key == 'A'){
 movEsquerre(backgroundimg[2]);
 }
 }
 if (keyCode == UP || key == 'w' || key == 'W')
 {
 salta = true;
 saltar(backgroundimg[2]);
 }
 }*/

void keyPressed() {
   if (keyCode == UP || key == 'w' || key == 'W')
 {
 salta = false;
 if (dir == 0)  dir = -SPD;
 }
 
}

static void move() {
  if ((y += dir) < JUMP)  dir *= -1;

  else if (y > FLOOR) {
    dir = 0;
    y = FLOOR;
  }
}


/*
void keyReleased() {
 if (keyCode == LEFT || key == 'a' || key == 'A')
 {
 esquerre = false;
 }
 if (keyCode == RIGHT || key == 'd' || key == 'D')
 {
 dreta = false;
 }
 if (keyCode == UP || key == 'w' || key == 'W')
 {
 salta = false;
 }
 }*/
/*
class Player
 {
 
 static final float gravity = 0.14;
 static final float bounceVel = 6.1;
 static final float maxYVel = 12;
 static final float maxXVel = 2;
 
 float x, y, xVel, yVel;
 int w, h;
 Player(int x, int y)
 {
 this.x = x;
 this.y = y;
 w = h = 20;
 }
 
 void display()
 {
 fill(204, 0, 0);
 rect(x, y, w, h);
 }
 
 void move()
 {
 x += xVel;
 y += yVel;
 
 // wrap around
 if (x > width-w) x = 0;
 if (x < 0) x = width-w;
 
 // horizontal
 if (!gameOver)
 {
 if (aPressed) xVel -= 0.05;
 else if (dPressed) xVel += 0.05;
 else
 {
 if (xVel > 0) xVel -= 0.03;
 else  xVel += 0.03;
 }
 }
 if (abs(xVel) < 0.01) xVel = 0;
 xVel = min(maxXVel, xVel);
 xVel = max(-maxXVel, xVel);
 
 // vertical
 yVel += gravity;
 yVel = min(maxYVel, yVel);
 yVel = max(-maxYVel, yVel);
 }
 
 
 void collide(Platform p)
 {
 // standard rectangle intersections, but only for our lowest quarter
 if (x         < p.x + p.w &&
 x + w      > p.x       &&
 y+h/2+h/4  < p.y + p.h &&
 y + h      > p.y)
 {
 // but we only care about platforms when falling
 if (yVel > 0) {
 // for bouncing
 yVel = -bounceVel;
 }
 }
 }
 }
 
 class Platform
 {
 float x, y, w, h;
 float xvel, yvel;
 
 Platform(int x, int y, int w, int h)
 {
 this.x = x;
 this.y = y;
 this.w = w;
 this.h = h;
 }
 
 void display()
 {
 fill(0);
 rect(x, y, w, h);
 }
 
 void move()
 {
 x += xvel;
 y += yvel;
 }
 }
 */

