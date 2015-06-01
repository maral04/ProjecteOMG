import processing.sound.*;

/* @pjs preload="Visual/Background/bg_grasslands.png"; */

SoundFile boingSo;
SoundFile leanSo;
//Movie myPresents;
PImage[] src = new PImage[3];
PFont fontGuay, fontDebugg;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[16];
PImage[] imgGrass = new PImage[4];
PImage[] imgStone = new PImage[4];
PImage[] imgTorch = new PImage[3];
PImage[] imgBat = new PImage[3];
PImage[] imgSign = new PImage[5];
PImage[] imgHUD = new PImage[3];
int pantalla = 0; //Menu i pantalles. Pantalla 0 = tutorial.

int oneAnother = 0;//Pel moviment del ratpenat.
int oneAnotherTRCH = 0; //Pel canvi de torcha
int element = 0; //Element del menú inicial.
boolean direccio = true;
String coordptglinia;
int espai;
char chardins;
String[] coordfiltrades = new String[4];
int posicio = 25;
int posicioSalt = 346;
int posicioSalttmp = posicioSalt;
int tipusMoviment = 5;
int level = 0; 
int timer; 
int tempsGirTorch = 600;
boolean tipusMovimentChg = false;
boolean iniciar = true;
boolean salta = false;
boolean dreta = false;
boolean esquerre = false;
boolean aball = false;
boolean escape = false;
boolean confirma = false;
boolean tipusbug;
boolean debugactiu = true;
boolean torchOn = false;
boolean torchCostat = false;
boolean noTocat = false; //Si toques el ratpanat..
boolean pause = false;
boolean siClickVideo = false;
boolean clickMenu = false;

//Posició i Width i Height de la part a agafar del personatge.
int ptgx[] = new int[16];
int ptgy[] = new int[16];
int ptgw[] = new int[16];
int ptgh[] = new int[16];

//Posició de les plataformes.
int xPlatform = posicio;
int yPlatform;

//Posició de la torch al menú, més endavant per una altra cosa.
float scaleX;
float scaleY;

int pgtotal = 2; //Nombre de personatges disponibles.
int ptg = 0;

int SPD = 9;
int dir, y = posicioSalt;

Extra extraBat1, extraBat2, extraBat3, extraBat4, extraBat5, extraBat6, extraBat7, extraBat8;

void setup() {

  size(1024, 512);
  //frameRate(120);
  //smooth();
  //S = State, V = Versió, U = Update, D = Date.
  String S = "PreAlpha";
  String V = "0.35";
  String U = "0";
  String D = "31/05/2015";
  frame.setTitle("Joc MBF "+S+" V-"+V+" U-"+U+" D-"+D+".");

  //Càrrega del video introductio.
  /*myPresents = new Movie(this, "Wildlife.wmv");
   myPresents.play();*/

  scaleX = width/5.5;

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
  boingSo = new SoundFile(this, "Sound/boing.mp3");
  leanSo = new SoundFile(this, "Sound/leanon.mp3");

  //Càrrega d'objectes del mapa variats.
  imgTorch[0] = loadImage("Visual/Background/elementsextres/torch/torch1.png");
  imgTorch[1] = loadImage("Visual/Background/elementsextres/torch/torch2.png");
  imgTorch[2] = loadImage("Visual/Background/elementsextres/torch/torchOff.png");

  //Càrrega d'imatges d'extres, bat...
  imgBat[0] = loadImage("Visual/Characters/Tutorial/bat.png");
  imgBat[1] = loadImage("Visual/Characters/Tutorial/bat_fly.png");
  imgBat[2] = loadImage("Visual/Characters/Tutorial/bat_hang.png");

  //Càrrega d'imatges, signes...
  imgSign[0] = loadImage("Visual/Background/elementsextres/sign/sign.png");
  imgSign[1] = loadImage("Visual/Background/elementsextres/sign/signExit.png");
  imgSign[2] = loadImage("Visual/Background/elementsextres/sign/signLeft.png");
  imgSign[3] = loadImage("Visual/Background/elementsextres/sign/signRight.png");
  imgSign[4] = loadImage("Visual/Background/elementsextres/sign/signExitv2.png");

  //Càrrega d'imatges de l'HUD.
  imgHUD[0] = loadImage("Visual/HUD/hudX.png");
  imgHUD[1] = loadImage("Visual/HUD/hudPlayer_green.png");
  imgHUD[2] = loadImage("Visual/HUD/hudPlayer_pink.png");

  //Atributs de la font
  //font = loadFont("LuckiestGuy.vlw");
  fontGuay = createFont("Font/LuckiestGuy.ttf", 22);
  fontDebugg = createFont("Font/FRADM.TTF", 16);
  //font = loadFont("Arial");
  //textFont(fontGuay, 22);
  //fill(0);
  //textFont(font, 18);

  //Objectes ratpentats, extres*. Randomment col·locats.
  //parseInt(random(1,9))
  extraBat1 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8))); //Direccio, xPos, yPos, speed.
  extraBat2 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat3 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat4 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat5 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat6 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat7 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  extraBat8 = new Extra(0, parseInt(random(width-150, width-50)), parseInt(random(20, height-55-99)), parseInt(random(1, 8)));
  
}

void draw() {
  //platformndBackground(backgroundimg[2]);
  //pushMatrix();
  //myPresents.play();

  //pantalla = 0;
  if (pause == false) {
    switch(pantalla) {
    case 0: 
      pantallaMenu(); 
      textFont(fontGuay, 12);
      fill(0);
      text("© Copyright 2015-2015 Marçal Bordoy Fàbregas - Almost all rights reserved", 0, height-4);
      break;
    case 1: 
      noStroke();
      pantallaTutorial();
      //textFont(fontGuay, 12);
      //text("© 2015 MBF", 0, height-4);
      break;
      //case 2: drawScreenTwo(); break;
      //default: background(0); break;
    }

    if (pantalla >= 1) {
      movimentsHabilitats();
    }
  }
}

/*
  if (torchOn == true) {
 if (millis()- timer >= tempsGirTorch) {
 dibuixarTorch(0, 40, 40);
 }
 if (millis()- timer >= tempsGirTorch*2) {
 dibuixarTorch(1, 40, 40);
 timer = millis();
 }
 } else {
 dibuixarTorch(2, 40, 40);
 }*/

void pantallaMenu() {
  background(backgroundimg[0]);
  // pantalla = pantalla+1;
  //Quan pasi a la seguent pantalla, iniciar = true;
  //if (iniciar == true) {
  if (noTocat == false) {
    extraBat1.display();
    extraBat2.display();
    extraBat3.display();
    extraBat4.display();
    extraBat5.display();
    extraBat6.display();
    extraBat7.display();
    extraBat8.display();
  } else {
    extraBat1.drive();
    extraBat2.drive();
    extraBat3.drive();
    extraBat4.drive();
    extraBat5.drive();
    extraBat6.drive();
    extraBat7.drive();
    extraBat8.drive();
  }
  if (debugactiu == true) {
    textFont(fontDebugg);
    //stroke(2);
    fill(0, 255, 35);
    text("Bat 1: Speed = "+extraBat1.xspeed, extraBat1.xpos, extraBat1.ypos);
    text("Bat 2: Speed = "+extraBat2.xspeed, extraBat2.xpos, extraBat2.ypos);
    text("Bat 3: Speed = "+extraBat3.xspeed, extraBat3.xpos, extraBat3.ypos);
    text("Bat 4: Speed = "+extraBat4.xspeed, extraBat4.xpos, extraBat4.ypos);
    text("Bat 5: Speed = "+extraBat5.xspeed, extraBat5.xpos, extraBat5.ypos);
    text("Bat 6: Speed = "+extraBat6.xspeed, extraBat6.xpos, extraBat6.ypos);
    text("Bat 7: Speed = "+extraBat7.xspeed, extraBat7.xpos, extraBat7.ypos);
    text("Bat 8: Speed = "+extraBat8.xspeed, extraBat8.xpos, extraBat8.ypos);
  }


  image(imgSign[4], (width-128)-25, (height-74)-25);

  if ((mouseX >= (width-128)-25 && mouseY >= (height-74)-25) &&
    (mouseX <= (width-128)-25+128 && mouseY <= (height-74)-25+74)
    ) {
    noFill();
    rect(width-128-25, (height-74)-25, 128, 74, 15);
    //line((width-128)-25, (height-74)-25, (width-128)-25+128, (height-74)-25+74);
    if (mouseButton == LEFT) {
      /*boolean sortirSegur = false;
       if (sortirSegur == true) {
       }*/
      exit();
    }
  }

  if (noTocat == false) {
    if ((mouseX >= extraBat1.xpos &&
      mouseX <= extraBat1.xpos+38 &&
      mouseY >= extraBat1.ypos &&
      mouseY <= extraBat1.ypos+48) ||
      (mouseX >= extraBat2.xpos &&
      mouseX <= extraBat2.xpos+38 &&
      mouseY >= extraBat2.ypos &&
      mouseY <= extraBat2.ypos+48) ||
      (mouseX >= extraBat3.xpos &&
      mouseX <= extraBat3.xpos+38 &&
      mouseY >= extraBat3.ypos &&
      mouseY <= extraBat3.ypos+48) ||
      (mouseX >= extraBat4.xpos &&
      mouseX <= extraBat4.xpos+38 &&
      mouseY >= extraBat4.ypos &&
      mouseY <= extraBat4.ypos+48) ||
      (mouseX >= extraBat5.xpos &&
      mouseX <= extraBat5.xpos+38 &&
      mouseY >= extraBat5.ypos &&
      mouseY <= extraBat5.ypos+48) ||
      (mouseX >= extraBat6.xpos &&
      mouseX <= extraBat6.xpos+38 &&
      mouseY >= extraBat6.ypos &&
      mouseY <= extraBat6.ypos+48) ||
      (mouseX >= extraBat7.xpos &&
      mouseX <= extraBat7.xpos+38 &&
      mouseY >= extraBat7.ypos &&
      mouseY <= extraBat7.ypos+48) ||
      (mouseX >= extraBat8.xpos &&
      mouseX <= extraBat8.xpos+38 &&
      mouseY >= extraBat8.ypos &&
      mouseY <= extraBat8.ypos+48)
      ) {
      noTocat = true;
    }
  }
  //text(extraBat1.width,150,200);
  //iniciar = false;
  //}

  //


  //Mou el select des del primer element a l'últim.
  if (salta == true && clickMenu == true) {
    if (element == 0) {
      element = 2;
      confirma = false;
    } else {
      element = element - 1;
    }
  }
  if (aball == true && clickMenu == true) {
    if (element == 2) {
      element = 0;
      confirma = false;
    } else {
      element = element + 1;
    }
  }
  clickMenu = false;
  //Transparència dels rectangles del Menú.

  fill(#cedfe0);
  stroke(#bbcbcc);
  if (element == 0) {
    scaleY = height/6;
    rect(width/3.6, height/3.9, 305, 44, 75);
  } else {
    if (element == 1) {
      scaleY = height/3;
      rect(width/3.6, height/2.35, 380, 44, 75);
    } else {
      scaleY = height/2;
      rect(width/3.6, height/1.69, 220, 44, 75);
    }
  }

  //Dibuixa la torch per mostrar qué s'està sel·leccionant en el Menú.
  dibuixarTorch(scaleX, scaleY);


  //Dibuixa el Text del menú.
  //El text comença a dibuixar-se d'esquerra aball!

  //Debugg del Text:
  if (debugactiu == true) {
    //fill();
    stroke(#00FF19);
    strokeWeight(4);
    line((width-128)-25, (height-74)-25, (width-128)-25+128, (height-74)-25+74); //Exit.
    //line((width/3.5)-4, (height/1.5)-33, (width/3.5)+204, (height/1.5)); //Controls
    line((width/3.5)-4, (height/1.2)-20, (width/3.5)+234, (height/1.2)+4); //Video-Guies externes
  }

  textFont(fontGuay, 66);
  fill(44);
  stroke(255);
  text("Joc MBF", width/6, (height/6));

  textFont(fontGuay, 44);


  text("Nova Partida", width/3.5, (height/3));



  text("Carrega Partida", width/3.5, (height/2));



  text("Controls", width/3.5, (height/1.5));




  textFont(fontGuay, 22);
  //Obre enllaç extern a youtube, només un cop fins que surt del recuadre i torna a entrar per no provocar
  //un super bucle que obre 60 youtubes per segont.
  if ((mouseX >= (width/3.5)-4 && mouseY >= (height/1.2)-20) &&
    (mouseX <= (width/3.5)+234 && mouseY <= (height/1.2)+4)

  ) {
    fill(#cedfe0);
    stroke(#bbcbcc);
    rect(width/3.6, height/1.29, 250, 44, 75);
    if (siClickVideo == false) {
      if (mouseButton == LEFT) {

        link("https://www.youtube.com/channel/UC1X4rvRTjsv8eSq3PQTsAtg", "_new");
        siClickVideo = true;
      }
    }
  } else {
    siClickVideo = false;
  }
  fill(44);
  text("Video-Guies externes", width/3.5, (height/1.2));

  if (confirma == true) {
    switch(element) {

    case 0: 
      //Nova Partida
      //demanarDades();
      pantalla = 1;
      confirma = false;
      break;
    case 1: 
      //Carrega Partida
      //carregarPartida();
      //text("NOPE", width/2, height/2);
      confirma = false;
      break;
    case 2: 
      if (escape == false) {
        //Controls
        fill(#999999);
        rectMode(CENTER);
        rect(width/2, height/2-10, width/2*1.15, height/2*1.10, 75);
        rectMode(CORNER);
        image(imgHUD[0],(width/2)+180,(height/2-10)-160);
      }else{
        escape = true;
      }

      break;
    }
  }
}

void pantallaTutorial() {
  if (iniciar == true) {
    inici();
    //torchOn = true;
  }
}

class Extra {

  int direccioC;
  int xpos;
  int ypos;
  int xspeed;

  Extra(int d, int xp, int yp, int xs) {
    direccioC = d;
    xpos = xp;
    ypos = yp;
    xspeed = xs;
  }

  void display() {
    image(imgBat[2], xpos, ypos);
  }

  void drive() {
    //Dreta a Esquerre.
    if (direccioC == 0) {
      xpos = xpos - xspeed;
      if (xpos <= 0-70) {
        xpos = width;
        //do{
        ypos = parseInt(random(20, height-55-99));
        //}while();
        xspeed = parseInt(random(1, 8));
      }
    } 
    /*
      //Esquerra a Dreta.
     if (direccioC == 2) {
     xpos = xpos + xspeed;
     if (xpos >= width) {
     xpos = 0;
     ypos = parseInt(random(20, height-55));
     xspeed = parseInt(random(1, 8));
     }
     }
     */
    if (oneAnother <= 35) {
      image(imgBat[0], xpos, ypos);
      oneAnother++;
    } else {
      if (oneAnother <= 70) {
        image(imgBat[1], xpos, ypos);
        oneAnother++;
      } else {
        image(imgBat[0], xpos, ypos);
        oneAnother = 1;
      }
    }

    //image(imgBat[1], xpos, ypos);
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

  //Al enviar el paràmetre false, el primer número es per al començament i el segon pel final.
  introduirPlatforms(1, 13, 0, false);

  introduirPlatforms(4, 5, -85, false);

  introduirPlatforms(5, 8, -250, false);

  introduirPlatforms(9, 10, -125, false);

  popMatrix();


  /*
    if (direccio == true) {
   debugspc(true, false);
   image(imgJugador[tipusMoviment], posicio, posicioSalt);
   } else {
   scale(-1, 1);
   debugspc(false, true);
   image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), (y));
   scale(-1, 1);
   }
   */

  sobrePlatforms();

  //}
}

//Si està saltant per sobre de la plataforma, es quedarà sobre d'aquesta.
void sobrePlatforms() {
  //console.log((((yPlatform-85)/2)-5)+"| X Jugador: "+((imgJugador[tipusMoviment].width)+posicio)+" Y Jugador: "+y);
  //console.log(dir);

  //Al enviar el paràmetre true, el primer número es per al començament i el segon es la llargada.
  //introduirPlatforms(0, 7, 0, true);
  introduirPlatforms(2, 1, -85, true);
  introduirPlatforms(5, 1, -125, true);
  introduirPlatforms(3, 2, -275, true);
  //rect((xPlatform+(imgGrass[0].width)*4)+35,yPlatform+-250,25,25);

  if ((y <= ((yPlatform-275)/2)-5) /*&& (y >= 225)*/
    && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*3)-15)
    && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*5)+35)
    ) {

    if (dir == 9) {
      posicioSalt = ((yPlatform-315)-10)/2;
    }
  } else {
    if ((y <= ((yPlatform-85)/2)-5) /*&& (y >= 225)*/
      && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*2)-15)
      && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*3)+35)
      ) {

      if (dir == 9) {
        posicioSalt = ((yPlatform-125)-10)/2;
      }
      //console.log("X Plataforma: "+(xPlatform+(imgGrass[0].width)*2)+" Y Plataforma: "+(yPlatform-85)/2);
    } else {
      if ((y <= ((yPlatform-125)/2)-5) /*&& (y >= 225)*/
        && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*5)-15)
        && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*6)+35)
        ) {

        if (dir == 9) {
          posicioSalt = ((yPlatform-165)-10)/2;
        }
      } else {

        if (dir != -9) {
          posicioSalt = 346;
        }
      }
    }
  }


  /*
  console.log("X Jugador: "+((imgJugador[tipusMoviment].width)+posicio)+" Y Jugador: "+y);
   console.log("X Plataforma: "+(xPlatform+(imgGrass[0].width)*2)+" Y Plataforma: "+(yPlatform-85)/2);
   */
}

//Construeix la part de la dreta / principi fora el for.
//Quan entra al for acostuma a construir la part central, ja que n'hi haurà mées i per tant
//com més amunt menys moviments.
//Si arriba al final, col·loca la part dreta.
void introduirPlatforms(int numInicial, int numFinal, int posYplat, boolean debugOnly) {

  if (debugOnly == false) {
    image(imgGrass[0], xPlatform+(imgGrass[0].width)*(numInicial-1), yPlatform+posYplat);
    for (int i = numInicial; i < numFinal; i++) {
      if (i < numFinal-1) {
        image(imgGrass[1], xPlatform+(imgGrass[0].width)*i, yPlatform+posYplat);
      } else {
        image(imgGrass[2], xPlatform+(imgGrass[0].width)*i, yPlatform+posYplat);
      }
    }
  } else {
    if (debugactiu == true) {
      //Si toca l'extrem esquerre del rectangle, o si entra tot el rectangle rosa en el calippo.
      fill(0, 255, 45);
      rect((xPlatform+(imgGrass[1].width)*numInicial)-15, (((yPlatform-posYplat)/2)+posYplat), (xPlatform+(imgGrass[1].width)*numFinal)+25, 5);
      fill(0, 0, 0);

      //Text amb les coordenades 
      //Cap del personatge.
      text(posicio, 15, 22);
      text(posicioSalt+imgJugador[tipusMoviment].width, 15, 42);
      //Peus del personatge.
      text(y, 60, 22);
      text(posicioSalt+imgJugador[tipusMoviment].height, 60, 42);
      fill(0, 255, 45);
    }
  }
}

void nivells() {
}

void inici() {
  carregaPtg();
  movDret(backgroundimg[2]);
  iniciar = false;
}

void displayPtg() {

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
      debugspc(false, true);
      image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), (y));
      scale(-1, 1);
    } else {
      //Salt moviment a l'esquerra.
      scale(-1, 1);
      debugspc(false, true);
      image(imgJugador[tipusMoviment], ((-imgJugador[tipusMoviment].width)-posicio), (y));
      scale(-1, 1);
    }
  } else {
    debugspc(true, true);
    image(imgJugador[tipusMoviment], (posicio), (y));
  }
}

void movDret(PImage b) {
  //Colisió extrem Esquerre.
  if (posicio > 1024-imgJugador[5].width) {
    boingSo.play();
    posicio = posicio - imgJugador[tipusMoviment].width/2;
    movEsquerre(backgroundimg[2]);
  } else {
    bothMoviments(b);
    debugspc(true, false);
    image(imgJugador[tipusMoviment], posicio, posicioSalt);
    posicio = posicio + 3;
  }
}

void movEsquerre(PImage b) {
  //Colisió extrem Dret.
  if (posicio < 0) {
    boingSo.play();
    //boingSo.rate(2);
    //leanSo.play();
    posicio = posicio + imgJugador[tipusMoviment].width/2;
    movDret(backgroundimg[2]);
    //boingSo.stop();
  } else {
    bothMoviments(b);
    scale(-1, 1);
    debugspc(false, false);
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

void carregaPtg() {
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
    for (int i = 0; i < coordptglinia.length (); i++) {
      chardins = coordptglinia.charAt(i);
      //Quan es javascript, " ", si es java ' '.
      if (chardins != (' ')) {
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
    //console.log(ptgx[j]+" "+ptgy[j]+" "+ptgw[j]+" "+ptgh[j]);
  }

  //Bucle que carrega els sectors de la sheet a un array d'imatges.
  for (int i = liniaInici; i < liniafinal; i++) {
    imgJugador[i] = src[ptg].get(ptgx[i], ptgy[i], ptgw[i], ptgh[i]);
  }
}

void dibuixarTorch(float torchX, float torchY) {
  if (oneAnotherTRCH <= 30) {
    image(imgTorch[0], torchX, torchY);
    oneAnotherTRCH++;
  } else {
    if (oneAnotherTRCH <= 60) {
      image(imgTorch[1], torchX, torchY);
      oneAnotherTRCH++;
    } else {
      image(imgTorch[0], torchX, torchY);
      oneAnotherTRCH = 1;
    }
  }
}

void debugspc(boolean tipusbuggaso, boolean YoS) {
  int posYinteriorS = posicioSalt;

  if (YoS == true) {
    posYinteriorS = y;
  }
  if (debugactiu == true) {
    if (tipusbuggaso == true) {
      rect((posicio), (posYinteriorS), imgJugador[tipusMoviment].width, imgJugador[tipusMoviment].height );
      fill(255, 0, 225);
      rect((posicio), (posYinteriorS), imgJugador[tipusMoviment].width, 5);
    } else {
      rect(((-imgJugador[tipusMoviment].width)-posicio), (posYinteriorS), imgJugador[tipusMoviment].width, imgJugador[tipusMoviment].height );
      fill(255, 0, 225);
      rect(((-imgJugador[tipusMoviment].width)-posicio), (posYinteriorS), imgJugador[tipusMoviment].width, 5);
    }
  }
}

void movimentsHabilitats() {
  if (dreta == true && esquerre != true) {
    movDret(backgroundimg[2]);
  }
  if (esquerre == true && dreta != true) {
    //displayPtg();
    movEsquerre(backgroundimg[2]);
  }
  if (dir != 0) {
    tipusMoviment = 3;
    displayPtg();
    //console.log("posicióBase: "+posicioSalt+" | SPD: "+SPD+" | dir: "+dir+" | y: "+y);
  } else {
    salta = false;
  }
}

void keyPressed()
{
  /* if (pantalla == 0) {
   } else {*/
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
    if (pantalla == 0) {
      clickMenu = true;
    } else {
      if (dir == 0) {
        dir = -SPD;
      }
    }
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    aball = true;
    if (pantalla == 0) {
      clickMenu = true;
    }
  }
  /*
  //Pausa la partida o surt de finestres. //L'ESCAPE tanca tot el programa, processing fault..
  if (keyCode == ESC) {
    escape = true;
  }*/

  if (keyCode == ENTER) {
    confirma = true;
  }

  //Guarda una screenshot en una carpeta anomenada "Screenshots".
  if (key == 'c' || key == 'C') {
    saveFrame("Screenshots/output-####.png");
  }
  //Debugg actiu o no
  if (key == 't' || key == 'T') {
    if (debugactiu == true) {
      debugactiu = false;
    } else {
      debugactiu = true;
    }
  }
  //Pausa partida si el debugg està actiu.
  if (debugactiu == true) {
    if (key == 'p' || key == 'P') {
      if (pause == false) {
        pause = true;
      } else {
        pause = false;
      }
    }
  }

  //}
}

void keyReleased() {
  /*if (pantalla == 0) {
   } else {*/
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
  if (keyCode == DOWN || key == 's' || key == 'S') {
    aball = false;
  }
  //}
}

