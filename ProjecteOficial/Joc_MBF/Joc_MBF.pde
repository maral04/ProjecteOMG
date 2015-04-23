/* @pjs preload="Visual/Background/bg_grasslands.png"; */

PImage src = new PImage[1];
PFont font;
PImage backgroundimg = new PImage[3];

//Posició i Width i Height de la part a agafar del personatge.
int ptgx = new int[11];
int ptgy = new int[11];
int ptgw = new int[11];
int ptgh = new int[11];

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;

String[] lines;
boolean printar = true;

void setup() {
  size(1024, 512);
  frameRate(16);
  //smooth();

  //Càrrega dels personatges del Jugador.
  for (var i = 0; i < pgtotal; i++) {
    src[i] = loadImage("Visual/Characters/Player/p"+i+"_spritesheet.png");
  }

  //Càrrega dels Background.
  backgroundimg[0] = loadImage("Visual/Background/bg_castle.png");
  backgroundimg[1] = loadImage("Visual/Background/bg_desert.png");
  backgroundimg[2] = loadImage("Visual/Background/bg_grasslands.png");
  backgroundimg[3] = loadImage("Visual/Background/bg_shroom.png");

  //Atributs de la font
  font = loadFont("Arial, 16, true");
  fill(0);
  textFont(font, 18);
}

//Posa l'imatge al background.
void drawbackground(var b) {
  background(b);
}

void drawtry(var printaa, var i) {
  if (i < 5) {
    text(printaa, 255, 225+(i*22));
  } else {
    text(printaa, 475, 225+((i-5)*22));
  }
}

void draw() {

  drawbackground(backgroundimg[2]);

  //Tría del personatge, 0-1.

  //Cárrega del .txt amb les coordenades linia per linia del personatge a l'Sprite Sheet.
  lines = loadStrings("Visual/Characters/Player/p"+ptg+"_spritesheet.txt");

  /*
  for (int i = 0; i < lines.length; i++) {
   drawtry(lines[i], i);
   }*/

  lines[5].trim();
  String coordptglinia = lines[5].substring(12);
  var espai = 0;
  var chardins;
  var coordfiltrades = "";

  /* ****Char to INT!*/
  for (int i = 0; i < coordptglinia.length; i++) {
    chardins = coordptglinia.charAt(i);
    if (chardins != "") {
      if (espai == 0) {
        ptgx[0] = ptgx[0] + chardins;
      } else {
        if (espai == 1) {
          ptgy[0] = ptgy[0] + chardins;
        } else {
          if (espai == 2) {
            ptgw[0] = ptgw[0] + chardins;
          } else {
            ptgh[0] = ptgh[0] + chardins;
          }
        }
      }
    } else {
      espai++;
    }
  }


  if (printar == true) {
    drawtry(ptgx[0], 1);
    printar = false;
  }
  /*
  drawtry(ptgy[0], 1);
   drawtry(ptgw[0], 1);
   drawtry(ptgh[0], 1);
   */

  //ptgx[0] = coordfiltrades;
  /*println(ptgx[0]);
   println(ptgy[0]);
   println(ptgw[0]);
   println(ptgh[0]);*/
  //println(coordptglinia);


  /*
   ptgx[0] = 0;
   ptgy[0] = 0;
   ptgw[0] = 72;
   ptgh[0] = 97;*/

  //PImage imgJugador = src[ptg].get(ptgx[0], ptgy[0], ptgw[0], ptgh[0]);
  PImage imgJugador = src[ptg].get(0, 0, 72, 97);
  image(imgJugador, 0, 0);

  //w = ;
  //h = ;
}

