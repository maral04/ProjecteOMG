/* @pjs preload="Visual/Background/bg_grasslands.png"; */

PImage[] src = new PImage[3];
PFont font;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[12];
PImage[] imgJugadorFlp = new PImage[12];

boolean flipdone = false;
boolean direccioEsquerre = false;
boolean direccioDreta = true;
boolean direccio = false;
String coordptglinia;
int espai;
char chardins;
String[] coordfiltrades = new String[4];
float velocitat = 15.0;

//Posició i Width i Height de la part a agafar del personatge.
int ptgx[] = new int[12];
int ptgy[] = new int[12];
int ptgw[] = new int[12];
int ptgh[] = new int[12];

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;


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
}


void draw() {
  drawbackground(backgroundimg[2]);
  movimentPtg();
  movDret(backgroundimg[2]);
    
}

void movDret(PImage b) {
  //Colisió extrem Esquerre.
  if(velocitat > 1024-imgJugador[0].width){
    velocitat = velocitat -10;
    movEsquerre(backgroundimg[2]);
  }else{
    drawbackground(b);
    if (direccio == true) {
      scale(-1, 1);
      direccio = false;
    }
    image(imgJugador[0], (velocitat), 50);
    velocitat = velocitat + 4;
  }
}

void movEsquerre(PImage b) {
  //Colisió extrem Dret.
  if(velocitat < 0 ){
    velocitat = velocitat +10;
    movDret(backgroundimg[2]);
  }else{
    drawbackground(b);
    if (direccio == false) {
      scale(-1, 1);
      direccio = true;
    }
    image(imgJugador[0], ((-imgJugador[0].width)-velocitat), 50);
    velocitat = velocitat - 4;
  }
}

void movimentPtg() {
  //Tría del personatge, 0-1.
  //Cárrega del .txt amb les coordenades linia per linia del personatge a l'Sprite Sheet.
  String[] lines = loadStrings("Visual/Characters/Player/p"+ptg+"_spritesheet.txt");
  noLoop();

  /*
  for (int i = 0; i < lines.length; i++) {
   drawtry(lines[i], i);
   }
   */

  //Linia a començar. 
  var liniaInici = 5;
  var liniafinal = 16;

  for (int j = liniaInici; j < liniafinal; j++) {
    lines[j].trim();
    coordptglinia = lines[j].substring(12);
    espai = 0;

    //Omplim l'array amb strings buits.
    for (var i = 0; i != coordfiltrades.length; i++) {
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
    ptgx[j-5] = parseInt(coordfiltrades[0]);
    ptgy[j-5] = parseInt(coordfiltrades[1]);
    ptgw[j-5] = parseInt(coordfiltrades[2]);
    ptgh[j-5] = parseInt(coordfiltrades[3]);
  }

  //Bucle que carrega els sectors de la sheet a un array d'imatges.
  for (int i = 0; i < 12; i++) {
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

void keyPressed()
{
  if (keyCode == LEFT || key == 'a' || key == 'A')
  {
    movEsquerre(backgroundimg[2]);
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D')
  {
    movDret(backgroundimg[2]);
  }
}

/*
void keyPressed(){
 if(keys['a'] || keys['A']) { 
 //p2.move(-1,0); 
 //left = 1;
 //image(imgJugador[0], 20, 20);
 
 }
 
 if(keys['d'] || keys['D']) { 
 //p2.move(1,0); 
 //right = 1;
 //image(imgJugador[0], 20, 20);
 }
 
 if(keys[' ']) { 
 //p2.move(-1,0); 
 println("spaace");
 }
 
 
 if(keys['w'] || keys['W']) { 
 //p2.move(0,-1); 
 
 }
 if(keys['s'] || keys['S']) { 
 //p2.move(0,1); 
 
 }
 
 }
 */
