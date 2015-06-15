import processing.sound.*;

/* @pjs preload="Visual/Background/bg_grasslands.png"; */

SoundFile introSo, boingSo;
//Movie myPresents;
PImage[] src = new PImage[3];
PFont fontGuay, fontDebugg;
PImage[] backgroundimg = new PImage[4];
PImage[] imgJugador = new PImage[16];
PImage[] imgGrass = new PImage[3];
PImage[] imgStone = new PImage[3];
PImage[] imgTorch = new PImage[3];
PImage[] imgBat = new PImage[3];
PImage[] imgSign = new PImage[5];
PImage[] imgHUD = new PImage[10];
PImage[] imgMapExtres = new PImage[7];
PImage[] imgWater = new PImage[3];
PImage imgCursor;
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
int easyPlatform = 45;
int moviments = 0;
String[] strPuntuacions = new String[10];
boolean tipusMovimentChg = false;
boolean iniciar = true;
boolean salta = false;
boolean dreta = false;
boolean esquerre = false;
boolean aball = false;
//boolean escape = false;
boolean confirma = false;
boolean tipusbug;
boolean debugactiu = false;
boolean torchOn = false;
boolean torchCostat = false;
boolean noTocat = false; //Si toques el ratpanat..
boolean pause = false;
boolean siClickVideo = false;
boolean clickMenu = false; //Fa que el menu inicial no es mogui tant ràpid.
boolean sobrePlatformy = false;
boolean checkPoint = false;
boolean dead = false;
boolean arribat = false;
boolean[] starPillada = new boolean[5];
//boolean ptgConfirma = true; //Comprova que s'hagi sel·leccionat un personatge.

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
  String V = "0.75";
  String U = "0";
  String D = "15/06/2015";
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

  imgStone[0] = loadImage("Visual/Mapa/Stone/stoneHalf_left.png");
  imgStone[1] = loadImage("Visual/Mapa/Stone/stoneHalf_mid.png");
  imgStone[2] = loadImage("Visual/Mapa/Stone/stoneHalf_right.png");

  //Càrrega de l'aigua.
  imgWater[0] = loadImage("Visual/Background/elementsextres/waterTop_low.png");
  imgWater[1] = loadImage("Visual/Background/elementsextres/waterTop_high.png");
  imgWater[2] = loadImage("Visual/Background/elementsextres/water.png");

  //Càrrega dels sons.
  boingSo = new SoundFile(this, "Sound/boing.mp3");
  //introSo = new SoundFile(this, "Sound/intro.mp3");

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
  imgHUD[3] = loadImage("Visual/HUD/arrows.png");
  imgHUD[4] = loadImage("Visual/HUD/wasd.png");
  imgHUD[5] = loadImage("Visual/HUD/hudPlayer_green.png");
  imgHUD[6] = loadImage("Visual/HUD/hudPlayer_pink.png");
  imgHUD[7] = loadImage("Visual/HUD/hudPlayer_beige.png");
  imgHUD[8] = loadImage("Visual/HUD/hudPlayer_blue.png");
  imgHUD[9] = loadImage("Visual/HUD/hudPlayer_yellow.png");

  //Càrrega dels extres del mapa.
  imgMapExtres[0] = loadImage("Visual/Items/itemsMapa/flagBlueHanging.png");
  imgMapExtres[1] = loadImage("Visual/Items/itemsMapa/flagBlue2.png");
  imgMapExtres[2] = loadImage("Visual/Items/itemsMapa/flagGreenHanging.png");
  imgMapExtres[3] = loadImage("Visual/Items/itemsMapa/flagGreen2.png");
  imgMapExtres[4] = loadImage("Visual/Items/itemsMapa/doorOpen_mid.png");
  imgMapExtres[5] = loadImage("Visual/Items/itemsMapa/doorOpen_top.png");
  imgMapExtres[6] = loadImage("Visual/Items/itemsMapa/star.png");

  //imgCursor = loadImage("Visual/Cursor/cursorS.png");

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

  //introSo.play();
  //introSo.loop();
}

void draw() {
  //platformndBackground(backgroundimg[2]);
  //pushMatrix();
  //myPresents.play();

  //pantalla = 0;
  if (pause == false) {

    /*
    fadeIn(); fadeOut o cosas així
     noStroke();
     fill(0, 0, 0, 191); //75% Opacity
     //rect(0, 0, width, height);*/

    switch(pantalla) {
    case 0:
      //cursor(imgCursor);
      strokeWeight(3);
      pantallaMenu(); 
      textFont(fontGuay, 12);
      fill(0);
      text("© Copyright 2015-2015 Marçal Bordoy Fàbregas - Almost all rights reserved", 0, height-4);
      break;
    case 1: 
      //introSo.stop();
      noStroke();
      pantallaTutorial();
      //textFont(fontGuay, 12);
      //text("© 2015 MBF", 0, height-4);
      break;
    case 2:
      noStroke();
      pantallaN1(); 
      break;
      //default: background(0); break;
    }

    if (pantalla >= 1) {
      if (arribat == false) {
        movimentsHabilitats();
      } else {
        if (pantalla == 1 && posicio < 865) {
          movDret(backgroundimg[2]);
          /*Habilitar per moviment chulo
           if(posicio > 864){
           movEsquerre(backgroundimg[2]);
           }*/
        } else {
          if (pantalla == 2 && posicio > 435) {
            posicioSalt = 95-imgJugador[tipusMoviment].height;
            y = posicioSalt;
            movEsquerre(backgroundimg[2]);
          }
        }
      }
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
    //Fer-lo gran on hover.
    pushMatrix();
    scale(1.1);
    image(imgSign[4], (((width-128)-25)/1.1)-4, (((height-74)-25)/1.1)-3);
    popMatrix();
    //Encerclar-lo on hover.
    noFill();
    //strokeWeight(3);
    rect(width-128-25-4, (height-74)-25-3, 128*1.1, 74*1.1, 15);
    //rect(width-128-25, (height-74)-25, 128, 74, 15);
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

  //Mou el select des del primer element a l'últim.
  if (salta == true && clickMenu == true) {
    if (element == 0) {
      element = 2;
    } else {
      element = element - 1;
    }
    confirma = false;
  }
  if (aball == true && clickMenu == true) {
    if (element == 2) {
      element = 0;
    } else {
      element = element + 1;
    }
    confirma = false;
  }
  clickMenu = false;

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
      modalMaralUP("Nova Partida");
      //pantalla = 1;
      //Controls dins el Contenidor
      stuffContainerNovaPartida();
      break;
    case 1: 
      //Contenidor
      modalMaralUP("Partides");
      //Controls dins el Contenidor
      stuffContainerCarregaPartida();
      break;
    case 2:
      //Contenidor
      modalMaralUP("Controls");

      //Controls dins el Contenidor
      stuffContainerControls();

      break;
    }
  }
}

void stuffContainerNovaPartida() {
  textFont(fontGuay, 33);
  text("Personatge:", width/3.8, (height/2.3));
  /*text("Nom:", width/1.8, (height/2.3));*/

  if ((mouseX >= 565 && mouseY >= 250) &&
    (mouseX <= 735 && mouseY <= 300)
    ) {
    /*
      if ((mouseX >= 590 && mouseY >= 315) &&
     (mouseX <= 775 && mouseY <= 370)
     ) {*/
    //cursor(HAND);
    //Efecte de que es fa gran.
    fill(#ffffff);
    //stroke(#bbcbcc);
    //rect(590, 315, 180, 53, 75);
    rect(557, 245, 180, 53, 75);
    fill(44);
    //text("Comença!", width/1.70, (height/1.45));
    text("Comença!", width/1.80, (height/1.80));

    if (mouseButton == LEFT) {
      //En un futur checkeja si el nom està introduit.
      pantalla = 1;
    }
  } else {
    /*fill(#cedfe0);
     stroke(#bbcbcc);
     rect(590, 315, 180, 53, 75);*/
    fill(44);
    //text("Comença!", width/1.70, (height/1.45));
    text("Comença!", width/1.80, (height/1.80));
  }


  /*fill(#cedfe0);
   stroke(#bbcbcc);*/
  /*
  textFont(fontGuay, 22);
   text("caixa", width/1.75, (height/2));*/


  pushMatrix();
  scale(0.6);

  image(imgHUD[5], width/2.3, (height/1.32));
  image(imgHUD[6], width/1.80, (height/1.32));
  image(imgHUD[7], width/1.48, (height/1.32));
  image(imgHUD[8], width/2.02, (height/1.05));
  image(imgHUD[9], width/1.62, (height/1.05));

  /*
  fill(255, 255, 255);
   textFont(fontGuay, 44);
   text(mouseX+" "+mouseY, 50, 50);*/

  if ((mouseX >= 280 && mouseY >= 245) &&
    (mouseX <= 330 && mouseY <= 300)
    ) {
    image(imgHUD[5], width/2.3, (height/1.32));

    //Efecte de que es fa gran.
    pushMatrix();
    scale(1.05);
    image(imgHUD[5], (width/2.3)-24, (height/1.32)-22);
    popMatrix();
    if (mouseButton == LEFT) {
      ptg = 0;
    }
  }

  if ((mouseX >= 350 && mouseY >= 250) &&
    (mouseX <= 405 && mouseY <= 300)
    ) {
    image(imgHUD[6], width/1.80, (height/1.32));

    //Efecte de que es fa gran.
    pushMatrix();
    scale(1.05);
    image(imgHUD[6], (width/1.80)-30, (height/1.32)-22);
    popMatrix();
    if (mouseButton == LEFT) {
      ptg = 1;
    }
  }

  //Els que no estàn disponibles amb un neglaso a sobre.
  noStroke();
  fill(0, 0, 0, 127);
  if ((mouseX >= 426 && mouseY >= 250) &&
    (mouseX <= 475 && mouseY <= 300)
    ) {
    ellipse(width/1.355, height/1.13, 88, 88);
  }

  if ((mouseX >= 315 && mouseY >= 305) &&
    (mouseX <= 365 && mouseY <= 355)
    ) {
    ellipse(width/1.795, height/0.925, 88, 88);
  }

  if ((mouseX >= 390 && mouseY >= 305) &&
    (mouseX <= 445 && mouseY <= 355)
    ) {
    ellipse(width/1.47, height/0.925, 88, 88);
  }

  popMatrix();

  stroke(255);
  fill(0, 0, 0, 0);
  if (ptg == 0) {
    ellipse(305, 272, 60, 60);
  } else {
    if (ptg == 1) {
      ellipse(379.5, 272, 60, 60);
    }
  }
}

void stuffContainerCarregaPartida() {
  //Buscar a l'arxiu X la partida.

  //Si no troba l'arxiu:

  textFont(fontGuay, 33);
  fill(205, 45, 45);
  text("No s'ha trobat cap partida.", width/3.8, (height/2.3));

  //Si l'arxiu es il·legible:
  //text("No s'ha pogut llegir l'arxiu.", width/3.8, (height/2.3));
}

void stuffContainerControls() {
  textFont(fontGuay, 33);
  text("Moviment:", width/3.8, (height/2.3));
  text("Altres:", width/1.8, (height/2.3));

  textFont(fontGuay, 22);
  //text("Screenshot:", width/1.75, (height/2));
  text("Pausa:", width/1.75, (height/2));
  text("Debug:", width/1.75, (height/1.75));
  textFont(fontGuay, 33);
  fill(#004d9b);
  //text("C", width/1.40, (height/2));
  text("P", width/1.53, (height/2));
  text("T", width/1.53, (height/1.75));

  pushMatrix();
  scale(0.6);

  image(imgHUD[4], width/2.27, (height/1.22));
  image(imgHUD[3], width/1.47, (height/1.22));
  popMatrix();
}

//Rep un text i el posa en un "Modal Popup" juntament amb la X per tancar-lo.
void modalMaralUP(String cap) {
  //Posa el fons en modo... segundo plano.
  noStroke();
  fill(0, 0, 0, 191); //75% Opacity
  rect(0, 0, width, height);
  //Contenidor
  fill(#cedfe0);
  stroke(#bbcbcc);
  rectMode(CENTER);
  rect(width/2, height/2-10, width/2*1.15, height/2*1.10, 75);
  rectMode(CORNER);
  image(imgHUD[0], (width/2)+210, (height/2-10)-120);
  textFont(fontGuay, 55);
  fill(44);
  text(cap, width/4, (height/3));

  //Tancament del contenidor
  if ((mouseX >= (width/2)+210 && mouseY >= (height/2-10)-120) &&
    (mouseX <= (width/2)+210+53 && mouseY <= (height/2-10)-120+52)
    ) {
    //Efecte de que es fa gran.
    pushMatrix();
    scale(1.1);
    image(imgHUD[0], (((width/2)+210)/1.1)-2, (((height/2-10)-120)/1.1)-2);
    popMatrix();
    if (mouseButton == LEFT) {
      //Sino poso lo del mouse no acaba de funcionar, s'auto-tanca.
      mouseX = mouseX+(60);
      mouseY = mouseY-(60);
      confirma = false;
    }
  }
}

void pantallaTutorial() {
  if (iniciar == true) {
    inici();
    //torchOn = true;
  }
}

void pantallaN1() {
  if (iniciar == true) {
    inici();
    //inici();
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

//Tot els extres de la pantalla després de platform.
void altresPantalla() {
  textFont(fontGuay, 28);
  fill(#ffcc00);
  //Contador d'Stars.
  int stars = 0;
  for (int i = 0; i < starPillada.length; i++) {
    if (starPillada[i] == true) {
      stars++;
    }
  }
  text("Stars: "+stars, 50, 50);
  fill(#1ea7e1);
  text("Moviments: "+moviments, 50, 80);

  if (pantalla == 1) {
    //image(imgMapExtres[6], parseInt(random(165, 400)), 200-imgMapExtres[6].height);
    if (starPillada[0] == false) {
      if (posicioSalt == 346 && posicio+(imgJugador[tipusMoviment].width/2) >= 165 
        && posicio <= 165+(imgMapExtres[6].width)/2) {
        starPillada[0] = true;
      }
    }

    if (starPillada[1] == false) {
      if (posicioSalt == 295 && posicio+(imgJugador[tipusMoviment].width/2) >= 300 
        && posicio <= 300+(imgMapExtres[6].width)/2) {
        starPillada[1] = true;
      }
    }
    if (starPillada[2] == false) {
      if (posicioSalt == 275 && posicio+(imgJugador[tipusMoviment].width/2) >= 655 
        && posicio <= 655+(imgMapExtres[6].width)/2) {
        starPillada[2] = true;
      }
    }
    if (starPillada[3] == false) {
      if (posicioSalt == 197 && posicio+(imgJugador[tipusMoviment].width/2) >= 525 
        && posicio <= 525+(imgMapExtres[6].width)/2) {
        starPillada[3] = true;
      }
    }
    if (starPillada[4] == false) {
      if (posicioSalt == 112 && posicio+(imgJugador[tipusMoviment].width/2) >= 225 
        && posicio <= 225+(imgMapExtres[6].width)/2) {
        starPillada[4] = true;
      }
    }

    if (starPillada[0] == false) {
      image(imgMapExtres[6], 165, 430-imgMapExtres[6].height);
    } 
    if (starPillada[1] == false) {
      image(imgMapExtres[6], 300, 385-imgMapExtres[6].height);
    } 
    if (starPillada[2] == false) {
      image(imgMapExtres[6], 655, 360-imgMapExtres[6].height);
    } 
    if (starPillada[3] == false) {
      image(imgMapExtres[6], 525, 285-imgMapExtres[6].height);
    } 
    if (starPillada[4] == false) {
      image(imgMapExtres[6], 225, 200-imgMapExtres[6].height);
    }

    if (arribat == false) {
      image(imgMapExtres[2], 810, 90-imgMapExtres[0].height);
      if (checkPoint == false) {
        image(imgMapExtres[0], 540, 130-imgMapExtres[0].height);
      } else {
        image(imgMapExtres[1], 540, 130-imgMapExtres[1].height);
      }
    } else {
      image(imgMapExtres[3], 810, 90-imgMapExtres[1].height);
      checkPoint = false;
      fill(44);
      text("R = Reintentar", 710, 165);
      text("C = Continuar", 710, 205);

      //Array amb moltes partides, agafa la que té el màxim de monedes i màxim de moviments.
      /*

       for (int i = 0; i < strPuntuacions.length; i++) {
       if (strPuntuacions[i] == "") {
       strPuntuacions[i] = ""+stars+","+moviments;
       break;
       }
       }
       text(strPuntuacions[0],150,150);
       
       //text(strPuntuacions.length,50,50);
       
       */

      fill(#80be1f);
      text("*Millor Puntuació: ", 50, 115);
      fill(#ffcc00);
      text(stars+" Stars", 50, 145);
      fill(#1ea7e1);
      text(moviments+" Moviments", 175, 145);
    }
  } else {
    if (pantalla == 2) {
      if (starPillada[0] == false) {
        if (posicioSalt == 346 && posicio+(imgJugador[tipusMoviment].width/2) >= 165 
          && posicio <= 165+(imgMapExtres[6].width)/2) {
          starPillada[0] = true;
        }
      }
      if (starPillada[1] == false) {
        if (posicioSalt == 188 && posicio+(imgJugador[tipusMoviment].width/2) >= 465 
          && posicio <= 465+(imgMapExtres[6].width)/2) {
          starPillada[1] = true;
        }
      }
      if (starPillada[2] == false) {
        if (posicioSalt == 273 && posicio+(imgJugador[tipusMoviment].width/2) >= 635 
          && posicio <= 635+(imgMapExtres[6].width)/2) {
          starPillada[2] = true;
        }
      }
      if (starPillada[3] == false) {
        if (posicioSalt == 73 && posicio+(imgJugador[tipusMoviment].width/2) >= 655 
          && posicio <= 655+(imgMapExtres[6].width)/2) {
          starPillada[3] = true;
        }
      }
      if (starPillada[4] == false) {
        if (y <= 205 && y >= 95 && posicio+(imgJugador[tipusMoviment].width/2) >= 965 
          && posicio <= 965+(imgMapExtres[6].width)/2) {
          starPillada[4] = true;
        }
      }

      if (starPillada[0] == false) {
        image(imgMapExtres[6], 165, 430-imgMapExtres[6].height);
      } 
      if (starPillada[1] == false) {
        image(imgMapExtres[6], 465, 275-imgMapExtres[6].height);
      }
      if (starPillada[2] == false) {
        image(imgMapExtres[6], 655, 360-imgMapExtres[6].height);
      } 
      if (starPillada[3] == false) {
        image(imgMapExtres[6], 635, 175-imgMapExtres[6].height);
      } 
      if (starPillada[4] == false) {
        image(imgMapExtres[6], 965, 210-imgMapExtres[6].height);
      }

      if (arribat == false) {
        image(imgMapExtres[2], 505, 85-imgMapExtres[0].height);
        if (checkPoint == false) {
          image(imgMapExtres[0], 315, 230-imgMapExtres[0].height);
        } else {
          image(imgMapExtres[1], 315, 230-imgMapExtres[1].height);
        }
      } else {
        image(imgMapExtres[3], 505, 85-imgMapExtres[1].height);
        checkPoint = false;
        fill(44);
        text("R = Reintentar", 405, 155);
        //text("C = Continuar", 405, 185);

        fill(#80be1f);
        text("*Millor Puntuació: ", 50, 115);
        fill(#ffcc00);
        text(stars+" Stars", 50, 145);
        fill(#1ea7e1);
        text(moviments+" Moviments", 175, 145);
      }
    }
  }
  textFont(fontDebugg, 14);
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

  if (pantalla == 1) {
    //Al enviar el paràmetre false, el primer número es per al començament i el segon pel final.
    introduirPlatforms(1, 13, 0, false, 0);

    introduirPlatforms(4, 5, -85, false, 0);

    introduirPlatforms(5, 8, -250, false, 0);

    introduirPlatforms(9, 10, -125, false, 0);

    introduirPlatforms(3, 5, -395, false, 0);

    introduirPlatforms(7, 8, -510, false, 1);

    introduirPlatforms(10, 12, -575, false, 1);
  } else {
    if (pantalla == 2) {
      introduirPlatforms(1, 5, 0, false, 0);

      introduirPlatforms(10, 13, 0, false, 0);

      introduirPlatforms(5, 6, -125, false, 0);

      introduirPlatforms(9, 10, -125, false, 0);

      introduirPlatforms(7, 8, -265, false, 0);

      introduirPlatforms(4, 5, -345, false, 1);

      introduirPlatforms(10, 12, -325, false, 0);

      introduirPlatforms(8, 9, -455, false, 0);

      introduirPlatforms(6, 8, -585, false, 1);

      //X Despistar
      introduirPlatforms(12, 13, -535, false, 0);
    }
  }
  //introduirPlatforms(11, 12, -575, false);

  popMatrix();

  altresPantalla();
  
  if (pantalla == 1) {
    fill(#80be1f);
    text("Recollir estrelles aumenta la puntuació", 165, 260);
    text("No són obligatories per acabar la pantalla", 155, 275);
    text("Pots atravesar una plataforma saltant", 375, 345);
    text("Anar a una plataforma inferiór t'envia a la plataforma més baixa", 555, 420);
    text("Les plataformes de roca solen contenir objectius importants", 540, 190);
  } 
  sobrePlatforms();
  mousedbg();
}

void mousedbg() {
  if (debugactiu == true) {
    text(mouseX+" "+mouseY, mouseX, mouseY);
  }
}

//Si està saltant per sobre de la plataforma, es quedarà sobre d'aquesta.
void sobrePlatforms() {
  if (arribat == false) {
    moviments++;
  }
  if (debugactiu == true) {
    easyPlatform = 10;
  } else {
    easyPlatform = 0;
  }
  //console.log((((yPlatform-85)/2)-5)+"| X Jugador: "+((imgJugador[tipusMoviment].width)+posicio)+" Y Jugador: "+y);
  //console.log(dir);

  if (pantalla == 1) {
    //Al enviar el paràmetre true, el primer número es per al començament i el segon es la llargada.
    //introduirPlatforms(0, 7, 0, true);
    introduirPlatforms(2, 1, -85, true, 0);
    introduirPlatforms(5, 1, -125, true, 0);
    //introduirPlatforms(3, 2, -275, true);

    //rect((xPlatform+(imgGrass[0].width)*4)+35,yPlatform+-250,25,25);

    sobrePlatformy = false;

    if (y <= 85 && y >= 1
      && (posicio >= 475-40-easyPlatform && posicio <= 627-15)
      ) {
      sobrePlatformy = true;
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-625)-10)/2;
        y = posicioSalt;
      }
      checkPoint = true;
    }

    //>
    if (y <= 110 && (y >= 1)
      && (posicio >= 705-40-easyPlatform && posicio <= 935-15)
      ) {
      sobrePlatformy = true;
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-700)-10)/2;
        y = posicioSalt;
      }
      arribat = true;
    }

    //<
    if ((y <= ((yPlatform-395)/2)-5) && (y + imgJugador[tipusMoviment].height >= 205)
      && (posicio >= 165-(imgJugador[tipusMoviment].width/2)-15-easyPlatform && posicio <= 398-15)
      ) {
      sobrePlatformy = true;
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-490)-10)/2;
        y = posicioSalt;
      }
    }

    if ((y <= ((yPlatform-275)/2)-5) && (y + imgJugador[tipusMoviment].height >= 290)
      && posicio >= 320-(imgJugador[tipusMoviment].width/2)-15-easyPlatform && posicio <= 628-15-easyPlatform
      ) {
      sobrePlatformy = true;
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-320)-10)/2;
        y = posicioSalt;
      }
    }

    //<
    //315 -> 280
    if ((y <= ((yPlatform-85)/2)-5) && y >= 280
      && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*2)-15-easyPlatform)
      && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*3)+35+easyPlatform)
      ) {
      sobrePlatformy = true;
      //295, just dins la plataforma.
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-125)-10)/2;
        y = posicioSalt;
      }
    }
    //>
    //295
    if (y >= 260 && (y <= ((yPlatform-125)/2)-5)
      && ((imgJugador[tipusMoviment].width)+posicio >= (xPlatform+(imgGrass[0].width)*5)-15-easyPlatform)
      && ((imgJugador[tipusMoviment].width)+posicio <= (xPlatform+(imgGrass[0].width)*6)+35+easyPlatform)
      ) {
      sobrePlatformy = true;
      if (dir == 9 || dir == 0) {
        posicioSalt = ((yPlatform-165)-10)/2;
        y = posicioSalt;
      }
    }
  } else {
    //Recordatori, primer check y màxima i després check peus minim.
    if (pantalla == 2) {
      introduirPlatforms(1, -1, 1000, true, 0); // Pot donar errors.

      sobrePlatformy = false;

      if (y <= 150 && y + imgJugador[tipusMoviment].height >= 165
        && (posicio >= 245-40-easyPlatform && posicio <= 400-15)
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 235-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
        checkPoint = true;
      }

      //SMidTop
      if (y <= 35 //&& y + imgJugador[tipusMoviment].height >= 15
      && (posicio >= 400-40-easyPlatform && posicio <= 620-15)
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 95-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
        arribat = true;
      }

      //<G
      if ((y <= ((yPlatform-125)/2)-5) && (y + imgJugador[tipusMoviment].height >= 365)
        && (posicio >= 320-40-easyPlatform && posicio <= 475-15)
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 370-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
      }

      //MidG
      if ((y <= ((yPlatform-265)/2)-5) && y + imgJugador[tipusMoviment].height >= 280
        && (posicio >= 475-35-easyPlatform) && posicio <= 625-25+easyPlatform
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 285-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
      }

      //G>
      if ((y <= ((yPlatform-125)/2)-5) && (y + imgJugador[tipusMoviment].height >= 365)
        && (posicio >= 630-40-easyPlatform && posicio <= 780-15)
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 370-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
      }

      //G>>
      if ((y <= ((yPlatform-325)/2)-5) && (y + imgJugador[tipusMoviment].height >= 245)
        && (posicio >= 705-40-easyPlatform && posicio <= 935-15) && posicioSalt != 273
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 250-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
      }

      //G>MID
      if ((y <= ((yPlatform-455)/2)-5) && (y + imgJugador[tipusMoviment].height >= 165)
        && (posicio >= 550-40-easyPlatform && posicio <= 705-20) && (y <= 80)
        ) {
        sobrePlatformy = true;
        if (dir == 9 || dir == 0) {
          posicioSalt = 170-imgJugador[tipusMoviment].height;
          y = posicioSalt;
        }
      }
    }
  }

  //Si no està saltant, cau.
  if ( (dir == 0) && sobrePlatformy == false) {
    posicioSalt = 346;
    y = posicioSalt;
    if (y == 346 &&
      posicio >= 400-20 && posicio+imgJugador[tipusMoviment].width <= 705+15 && pantalla == 2) {
      posicio = 25;
    }
  }
  if (pantalla == 2) {
    fill(#80be1f);
    text("Si vas a caure, tornes al principi \n(els moviments segueixen aumentant)", 455, 465);
    fill(0, 255, 45);
  }
  if (checkPoint == true) {
    /*fill(#1ea7e1, 75);
     rect(480,160,50,20,95);*/
    fill(#1ea7e1, 225);
    if (pantalla == 1) {
      text("S+Moviment per Tornar", 480, 185);
    } else {
      if (pantalla == 2) {
        text("S+Moviment per Tornar", 250, 285);
      }
    }
    if (aball == true) {
      if (pantalla == 1) {
        posicioSalt = ((yPlatform-625)-10)/2;
        y = posicioSalt;
        posicio = 545;

        //dreta = false;
        // dead = false;
        aball = false;
        sobrePlatforms();
      } else {
        if (pantalla == 2) {
          posicioSalt = 235-imgJugador[tipusMoviment].height;
          y = posicioSalt;
          posicio = 300;

          aball = false;
          sobrePlatforms();
        }
      }
    }
  }

  /*else {
   if (sobrePlatformy == true) {
   //
   sobrePlatformy = false;
   }*/


  /*
  console.log("X Jugador: "+((imgJugador[tipusMoviment].width)+posicio)+" Y Jugador: "+y);
   console.log("X Plataforma: "+(xPlatform+(imgGrass[0].width)*2)+" Y Plataforma: "+(yPlatform-85)/2);
   */
}

//Construeix la part de la dreta / principi fora el for.
//Quan entra al for acostuma a construir la part central, ja que n'hi haurà mées i per tant
//com més amunt menys moviments.
//Si arriba al final, col·loca la part dreta.
void introduirPlatforms(int numInicial, int numFinal, int posYplat, boolean debugOnly, int tipus) {
  PImage[] imgColocar = new PImage[3]; 
  if (tipus == 0) {
    for (int i = 0; i < imgColocar.length; i++) {
      imgColocar[i] = imgGrass[i];
    }
  } else {
    if (tipus == 1) {
      for (int i = 0; i < imgColocar.length; i++) {
        imgColocar[i] = imgStone[i];
      }
    }
  }

  if (debugOnly == false) {
    image(imgColocar[0], xPlatform+(imgColocar[0].width)*(numInicial-1), yPlatform+posYplat);
    for (int i = numInicial; i < numFinal; i++) {
      if (i < numFinal-1) {
        image(imgColocar[1], xPlatform+(imgColocar[0].width)*i, yPlatform+posYplat);
      } else {
        image(imgColocar[2], xPlatform+(imgColocar[0].width)*i, yPlatform+posYplat);
      }
    }
  } else {
    if (debugactiu == true) {
      //Si toca l'extrem esquerre del rectangle, o si entra tot el rectangle rosa en el calippo.
      fill(0, 255, 45);
      rect((xPlatform+(imgColocar[1].width)*numInicial)-15, (((yPlatform-posYplat)/2)+posYplat), (xPlatform+(imgColocar[1].width)*numFinal)+25, 5);
      fill(0, 0, 0);

      //Text amb les coordenades 
      //Cap del personatge.
      text(posicio, 15, 22);
      text(posicioSalt+imgJugador[tipusMoviment].width, 15, 42);
      //Peus del personatge.
      text(y, 60, 22);
      text(posicioSalt+imgJugador[tipusMoviment].height, 60, 42);
      fill(0, 255, 45);
      text("Direcció: "+dir+" "+sobrePlatformy, 50, 160);

      text("PosSalt "+posicioSalt+" | Y: "+y, 50, 175);
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
/*
void recorregutAutomatic(){
 movDret(backgroundimg[2]);
 }*/

void restartGuay() {
  arribat = false;
  moviments = 0;
  posicioSalt = 346;
  y = posicioSalt;
  posicio = 25;
  for (int i = 0; i < starPillada.length; i++) {
    starPillada[i] = false;
  }
  checkPoint = false;
  movDret(backgroundimg[2]);
}

void keyPressed()
{
  /* if (pantalla == 0) {
   } else {*/
  if (pause == false) {
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      dreta = true;
      direccio = true;
      if (pantalla == 0) {
        confirma = true;
      }
    }
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      esquerre = true;
      direccio = false;
      if (pantalla == 0) {
        confirma = false;
      }
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
      if (pantalla == 0) {
        aball = true;
        clickMenu = true;
      }
      if (pantalla >= 1) {
        if (aball == false) {
          aball = true;
        } else {
          aball = false;
        }
      }
    }

    //restart
    if (key == 'r' || key == 'R') {
      if (arribat == true) {
        restartGuay();
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
    //Canviat a tecla continuar.
    if (key == 'c' || key == 'C') {
      if (pantalla == 1 && arribat == true) {
        pantalla = 2;
        restartGuay();
      }
      //saveFrame("Screenshots/output-####.png");
    }
    //Debugg actiu o no
    if (key == 't' || key == 'T') {
      if (debugactiu == true) {
        debugactiu = false;
      } else {
        debugactiu = true;
      }
    }
  }
  //Pausa partida si el debugg està actiu.
  // if (debugactiu == true) {
  if (key == 'p' || key == 'P') {
    if (pause == false) {
      pause = true;

      noStroke();
      fill(0, 0, 0, 175);
      rect(0, 0, width, height);

      textFont(fontGuay, 62);
      fill(145);

      text("PAUSED", (width/2)-100, height/2);
      if (pantalla > 1) {
        dreta = false;
        esquerre = false;
      }
    } else {
      pause = false;
      if (pantalla > 1) {
        movDret(backgroundimg[2]);
      }
    }
  }/*
    if (key == 'm' || key == 'M') {
   automatic = true;
   recorregutAutomatic();
   }*/
  //}

  //}
}

void keyReleased() {
  /*if (pantalla == 0) {
   } else {*/
  if (pause == false) {
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
  }
  //}
}

