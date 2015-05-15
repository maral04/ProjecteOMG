/* @pjs preload="Visual/Background/bg_grasslands.png"; */

PImage[] src = new PImage[3];
PFont font;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[16];
PImage[] imgGrass = new PImage[4];
PImage[] imgStone = new PImage[4];

boolean flipdone = false;
boolean direccio = true;
String coordptglinia;
int espai;
char chardins;
String[] coordfiltrades = new String[4];
int posicio = 25;
int posicioSalt = 346;
int posicioSalttmp = posicioSalt;
int tipusMoviment = 5;
int level = 0; //Pantalla, 0 = tutorial.
boolean tipusMovimentChg = false;
boolean iniciar = true;
boolean salta = false;
boolean dreta = false;
boolean esquerre = false;
boolean tipusbug;
boolean debugactiu = true;

//Posició i Width i Height de la part a agafar del personatge.
int ptgx[] = new int[13];
int ptgy[] = new int[13];
int ptgw[] = new int[13];
int ptgh[] = new int[13];

//Posició de les plataformes.
int xPlatform = posicio;
int yPlatform;

float scaleX;
float scaleY;

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;

int SPD = 7;
int dir, y = posicioSalt;

void setup() {
  size(1024, 512);
  //frameRate(7);
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

  //Càrrega del terre/plataformes.
  imgGrass[0] = loadImage("Visual/Mapa/Grass/grassHalf_left.png");
  imgGrass[1] = loadImage("Visual/Mapa/Grass/grassHalf_mid.png");
  imgGrass[2] = loadImage("Visual/Mapa/Grass/grassHalf_right.png");


  //Càrrega dels sons.


  //Atributs de la font
  font = loadFont("Arial, 16, true");
  fill(0);
  textFont(font, 18);
}

void draw() {
  //platformndBackground(backgroundimg[2]);
  //pushMatrix();
  if (iniciar == true) {
    inici();
  }
  if (dreta == true && esquerre != true) {
    movDret(backgroundimg[2]);
  }
  if (esquerre == true && dreta != true) {
    movEsquerre(backgroundimg[2]);
  }
  if (dir != 0) {
    tipusMoviment = 3;
    movSalt();
    //console.log("posicióBase: "+posicioSalt+" | SPD: "+SPD+" | dir: "+dir+" | y: "+y);
  } else {
    salta = false;
  }
}

//Posa l'imatge al background així com les plataformes del nivell dessitjat.
void platformndBackground(PImage b) {
  background(b);

  //Fer switch case de levels.
  //if(){

  scaleX = 0.6;
  scaleY = 0.6;

  pushMatrix();
  scale(scaleX, scaleY);

  xPlatform = parseInt(14/scaleX);
  yPlatform = parseInt(435/scaleY);

  introduirPlatforms(1, 13, 0);

  introduirPlatforms(4, 5, -85);

  introduirPlatforms(5, 8, -250);

  introduirPlatforms(9, 10, -125);


  //Si està saltant per sobre de la plataforma, es quedarà sobre d'aquesta.
  if ((y <= (yPlatform-85)/2)
    && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*2)-15)
    && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*3)+35)
    ) {
    //posicioSalttmp = posicioSalt;
    posicioSalt = ((yPlatform-125)-10)/2;
    //posicioSalt =(yPlatform-85)/2;
    //console.log("X Plataforma: "+(xPlatform+(imgGrass[0].width)*2)+" Y Plataforma: "+(yPlatform-85)/2);
  } else {
    //posicioSalt = 346;
    //if(salta == false){
    posicioSalt = 346;
    //}
    //posicioSalt = posicioSalttmp;
  }

  /*
  console.log("X Jugador: "+((imgJugador[tipusMoviment].width)+posicio)+" Y Jugador: "+y);
   console.log("X Plataforma: "+(xPlatform+(imgGrass[0].width)*2)+" Y Plataforma: "+(yPlatform-85)/2);
   */

  popMatrix();

  //}
}


//Construeix la part de la dreta / principi fora el for.
//Quan entra al for acostuma a construir la part central, ja que n'hi haurà mées i per tant
//com més amunt menys moviments.
//Si arriba al final, col·loca la part dreta.
void introduirPlatforms(int numInicial, int numFinal, int posYplat) {
  image(imgGrass[0], xPlatform+(imgGrass[0].width)*(numInicial-1), yPlatform+posYplat);
  for (var i = numInicial; i < numFinal; i++) {
    if (i < numFinal-1) {
      image(imgGrass[1], xPlatform+(imgGrass[0].width)*i, yPlatform+posYplat);
    } else {
      image(imgGrass[2], xPlatform+(imgGrass[0].width)*i, yPlatform+posYplat);
    }
  }
}

void nivells() {
}

void movSalt() {
  platformndBackground(backgroundimg[2]);
  if ((y += dir) < posicioSalt-(imgJugador[tipusMoviment].height)) {
    dir = dir*-1;
  } else {
    if (y > posicioSalt) {
      dir = 0;
      y = posicioSalt;
    }
  }
  //Torna a possar-se de peu.
  if (y == posicioSalt) {
    tipusMoviment = 5;
  }

  if (direccio == false) {
    dreta = false;
    //Salt quiet a l'esquerra.
    if (esquerre == false) {
      scale(-1, 1);
      debugspc(false);
      image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), (y));
      scale(-1, 1);
    } else {
      //Salt moviment a l'esquerra.
      scale(-1, 1);
      debugspc(false);
      image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), (y));
      scale(-1, 1);
    }
  } else {
    debugspc(true);
    image(imgJugador[tipusMoviment], (posicio), (y));
  }
}

void inici() {
  movimentPtg();
  movDret(backgroundimg[2]);
  iniciar = false;
}

void movDret(PImage b) {
  //Colisió extrem Esquerre.
  if (posicio > 1024-imgJugador[5].width) {
    posicio = posicio - imgJugador[tipusMoviment].width/2;
    movEsquerre(backgroundimg[2]);
  } else {
    bothMoviments(b);
    debugspc(true);
    image(imgJugador[tipusMoviment], posicio, posicioSalt);
    posicio = posicio + 3;
  }
}

void movEsquerre(PImage b) {
  //Colisió extrem Dret.
  if (posicio < 0) {
    posicio = posicio + imgJugador[tipusMoviment].width/2;
    movDret(backgroundimg[2]);
  } else {
    bothMoviments(b);
    scale(-1, 1);
    debugspc(false);
    image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), posicioSalt);
    scale(-1, 1);
    posicio = posicio - 3;
  }
}

void bothMoviments(PImage b) {
  //Fa l'efecte de moviment al canviar l'imatge del personatge, cames braços etc..
  if (salta == false) {
    if (tipusMoviment < imgJugador.length-1) {
      tipusMoviment++;
    } else {
      tipusMoviment = 5;
    }
    platformndBackground(b);
  }
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

void debugspc(boolean tipusbuggaso) {
  if (debugactiu == true) {
    if (tipusbuggaso == true) {
      rect((posicio), (y), imgJugador[tipusMoviment].width, imgJugador[tipusMoviment].height );
    } else {
      rect(((-imgJugador[tipusMoviment].width)-posicio), (y), imgJugador[tipusMoviment].width, imgJugador[tipusMoviment].height );
    }
  }
}

void keyPressed()
{
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    dreta = true;
    direccio = true;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    esquerre = true;
    direccio = false;
  }
  if (keyCode == UP || key == 'w' || key == 'W') {
    salta = true;
    if (dir == 0) {
      dir = -SPD;
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT || key == 'd' || key == 'D')
  {
    dreta = false;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A')
  {
    esquerre = false;
  }
  if (keyCode == UP || key == 'w' || key == 'W')
  {
    salta = false;
  }
}
/*
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

