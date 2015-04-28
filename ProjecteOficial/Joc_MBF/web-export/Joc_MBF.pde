/* @pjs preload="Visual/Background/bg_grasslands.png"; */

PImage[] src = new PImage[3];
PFont font;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[12];


String coordptglinia;
int espai;
char chardins;
String[] coordfiltrades = new String[4];

//Posició i Width i Height de la part a agafar del personatge.
int ptgx[] = new int[12];
int ptgy[] = new int[12];
int ptgw[] = new int[12];
int ptgh[] = new int[12];

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;


void setup() {
  size(1024, 512);
  frameRate(12);
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

  //Atributs de la font
  font = loadFont("Arial, 16, true");
  fill(0);
  textFont(font, 18);
}


void draw() {
  drawbackground(backgroundimg[2]);
  movimentPtg();
  
  //imgJugador = src[ptg].get(0, 0, 72, 97);
  image(imgJugador[0], 20, 20);
}

void movimentPtg(){
  //Tría del personatge, 0-1.
  //Cárrega del .txt amb les coordenades linia per linia del personatge a l'Sprite Sheet.
  String[] lines = loadStrings("Visual/Characters/Player/p"+ptg+"_spritesheet.txt");
  noLoop();

  /*
  for (int i = 0; i < lines.length; i++) {
    drawtry(lines[i], i);
  }
  */
   
  lines[5].trim();
  coordptglinia = lines[5].substring(12);
  espai = 0;
  
 // drawtry(coordptglinia, -2);

  //Omplim l'array amb strings buits.
  for (var i = 0; i != coordfiltrades.length; i++) {
    coordfiltrades[i] = "";
  }
   
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
  for (int i = 0; i < 1; i++) {
    ptgx[i] = parseInt(coordfiltrades[0]);
    ptgy[i] = parseInt(coordfiltrades[1]);
    ptgw[i] = parseInt(coordfiltrades[2]);
    ptgh[i] = parseInt(coordfiltrades[3]);
  }
   
  drawtry("o. "+ptgx[0]+" .", 1);
  drawtry("o. "+ptgy[0]+" .", 2);
  drawtry("o. "+ptgw[0]+" .", 3);
  drawtry("o. "+ptgh[0]+" .", 4);
 

  /*
  ptgx[0] = parseInt(ptgx[0]);
  ptgy[0] = parseInt(ptgy[0]);
  ptgw[0] = parseInt(ptgw[0]);
  ptgh[0] = parseInt(ptgh[0]);
  /*
  
   
  /*
  for (int i = 0; i < 1; i++) {
   drawtry(ptgx[0], 1);
   drawtry(ptgy[0], 2);
   drawtry(ptgw[0], 3);
   drawtry(ptgh[0], 4);
   }
   */
   
  //Bucle que carrega els sectors de la sheet a un array d'imatges.
  //for asd
  imgJugador[0] = src[ptg].get(ptgx[0], ptgy[0], ptgw[0], ptgh[0]);
  
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

