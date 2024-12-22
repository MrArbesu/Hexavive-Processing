color backgr;
Player p = new Player();
ArrayList<Barrera> b = new ArrayList<Barrera>();
float tiempoCambio = 0;
float tiempoRest = 0;
float tiempoStart;
float tiempoRespawn = 1000; //milisegundos entre respawn the barreras
float xScore = 50;
float yScore = 50;
float scoreSizeX = 80;
float scoreSizeY = 50;
int score = 0;

bool run = false;
bool end = false;

int highscore = 0;
String[] highscoreS;

String directorio = "data1.txt";

class Player{
   float radio = 70;
   float angulo = radians(0);
   float size = 24;
   float speed = 0.1;
   int side;
   float xPos, yPos;
   Player(){
      actualizarCoor();
   }
   void actualizarCoor(){
      if(angulo > radians(360)) angulo -= radians(360);
      if(angulo < 0) angulo += radians(360);
      xPos = radio * cos(angulo);
      yPos = radio * sin(angulo);
      if(angulo >= 0 && angulo < radians(60)){
         side = 1;
      } else if(angulo >= radians(60) && angulo < radians(120)){
         side = 2;
      } else if(angulo >= radians(120) && angulo < radians(180)){
         side = 3;
      } else if(angulo >= radians(180) && angulo < radians(240)){
         side = 4;
      } else if(angulo >= radians(240) && angulo < radians(300)){
         side = 5;
      } else if(angulo >= radians(300) && angulo < radians(360)){
         side = 6;
      }
   }
   void rightMove(){
      angulo += speed;
      actualizarCoor();
   }
   void leftMove(){
      angulo -= speed;
      actualizarCoor();
   }
}

class Barrera {
   float speed = 5;
   float grosorSpeed = 0.09f;
   int side;
   float x1,x2,x3,x4,y1,y2,y3,y4;
   float angulo1, angulo2;
   float distCentro = 700;
   float grosor = 30;
   bool scored = false;
   Barrera(int sideNum){
      side = sideNum;
      DefinirCoordenadas();
   }
   
   void UpdateCoor(){
      distCentro -= speed;
      grosor -= grosorSpeed;
      DefinirCoordenadas();
      if(distCentro <= p.radio + p.size /2 && distCentro + grosor >= p.radio - p.size /2 && checkAngulo()){
         backgr = color(0,0,0);
         run = false;
      }
   }
   
   bool checkAngulo(){
      switch(side){
         case 1:
         if(p.angulo >= radians(350) || p.angulo <= radians(60)){
            return true;
         } else {
            return false;
         }
         case 2:
         if(p.angulo >= radians(50) && p.angulo <= radians(130)){
            return true;
         } else {
            return false;
         }
         case 3:
         if(p.angulo >= radians(110) && p.angulo <= radians(190)){
            return true;
         } else {
            return false;
         }
         case 4:
         if(p.angulo >= radians(170) && p.angulo <= radians(250)){
            return true;
         } else {
            return false;
         }
         case 5:
         if(p.angulo >= radians(230) && p.angulo <= radians(310)){
            return true;
         } else {
            return false;
         }
         case 6:
         if(p.angulo >= radians(300) || p.angulo <= radians(10)){
            return true;
         } else {
            return false;
         }
      }
   }
   
   void DefinirCoordenadas(){
      switch(side){
         case 1:
         x1 = 1 * distCentro; y1 = 0;
         x2 = 1 * (distCentro + grosor); y2 = 0;
         x3 = 0.5f * (distCentro + grosor); y3 = 0.866025f * (distCentro + grosor);
         x4 = 0.5f * distCentro; y4 = 0.866025f * distCentro;
         break;
         case 2:
         x1 = 0.5f * distCentro; y1 = 0.866025f * distCentro;
         x2 = 0.5f * (distCentro + grosor); y2 = 0.866025f * (distCentro + grosor);
         x3 = -0.5f * (distCentro + grosor); y3 = 0.866025f * (distCentro + grosor);
         x4 = -0.5f * distCentro; y4 = 0.866025f * distCentro;
         break;
         case 3:
         x1 = -0.5f * distCentro; y1 = 0.866025f * distCentro;
         x2 = -0.5f * (distCentro + grosor); y2 = 0.866025f * (distCentro + grosor);
         x3 = -1 * ( distCentro + grosor); y3 = 0;
         x4 = -1 * distCentro; y4 = 0;
         break;
         case 4:
         x1 = -1 * distCentro; y1 = 0;
         x2 = -1 * (distCentro + grosor); y2 = 0;
         x3 = -0.5f * (distCentro + grosor); y3 = -0.866025f * (distCentro + grosor);
         x4 = -0.5f * distCentro; y4 = -0.866025f * distCentro;
         break;
         case 5:
         x1 = -0.5f * distCentro; y1 = -0.866025f * distCentro;
         x2 = -0.5f * (distCentro + grosor); y2 = -0.866025f * (distCentro + grosor);
         x3 = 0.5f * (distCentro + grosor); y3 = -0.866025f * (distCentro + grosor);
         x4 = 0.5f * distCentro; y4 = -0.866025f * distCentro;
         break;
         case 6:
         x1 = 0.5f * distCentro; y1 = -0.866025f * distCentro;
         x2 = 0.5f * (distCentro + grosor); y2 = -0.866025f * (distCentro + grosor);
         x3 = 1 * (distCentro + grosor); y3 = 0;
         x4 = 1 * distCentro; y4 = 0;
         break;
      }
   }
}

void setup() {
   highscoreS = loadStrings(directorio);
   if(highscoreS[0] == null){
      highscore = 0;
      highscoreS = new String[1];
   } else {
      highscore = int(highscoreS[0]);
   }
   backgr = color(random(256), random(256), random(256));
   size(screenWidth, screenHeight);
   noStroke();
   textSize(30);
   //run = true;
}

void draw() {
   if(run){
      Run();
   } else {
      if(end){
         End();
      } else {
         Start();
      }
   }
}

void Start(){
   background(backgr);
   textSize(75);
   text("Hexavive",width/2 - 150, 200);
   textSize(50);
   text("Highscore: " + str(highscore), width/2 - 150, 400);
   if(mousePressed){
      run = true;
      end = true;
      tiempoStart = millis();
   }
}

void End(){
   
}

void Run(){
   tiempoRest += millis() - tiempoCambio - tiempoStart;
   tiempoCambio = millis() - tiempoStart;
   if(tiempoRest >= tiempoRespawn){
      tiempoRest -= tiempoRespawn;
      loopAdd();
   }
   for(int i = b.size() - 1; i >= 0; i--){
      Barrera ba = b.get(i);
      ba.UpdateCoor();
      if(ba.distCentro <= 0){
         b.remove(i);
      }
   }
   if(mousePressed){
      if(mouseX >= width /2){
         p.rightMove();
      } else {
         p.leftMove();
      }
   }
   checkScore();
   background(backgr);
   drawBarreras();
   //Temporal();
   drawPlayer();
   drawScore();
}

void loopAdd(){
   int[] sides = loopRandom(int(random(4,6)));
   for(int i = 0; i < sides.length; i++){
      int ran = sides[i];
      b.add(new Barrera(sides[i]));
   }
}

int[] loopRandom(int num){
   int[] sides = new int[num];
   do {
      for(int i = 0; i < sides.length; i++){
         sides[i] = int(random(1,7));
      }
   }
   while(checkSame(sides));
   return sides;
}

bool checkSame(int[] sides){
   for(int i = 0; i < sides.length; i++){
      for(int k = 0; k < sides.length; k++){
         if(sides[i] == sides[k] && i != k){
            return true;
         }
      }
   }
   return false;
}

void drawPlayer(){
   ellipse(p.xPos + width /2, p.yPos + height /2, p.size, p.size);
   //rect(xPos,yPos,p.size,p.size);
   //quad(xPos + p.size/2, yPos + p.size/2, xPos + p.size/2, yPos - p.size/2, xPos - p.size/2, yPos - p.size/2, xPos - p.size/2, yPos + p.size/2);
}

void drawBarreras(){
   for(int i = 0; i < b.size(); i++){
      Barrera ba = b.get(i);
      quad(ba.x1 + width /2, ba.y1 + height /2, ba.x2 + width /2, ba.y2 + height /2, ba.x3 + width /2, ba.y3 + height /2, ba.x4 + width /2, ba.y4 + height /2);
   }
}

void checkScore(){
   bool scored = false;
   for(int i = 0; i < b.size(); i++){
      if(b.get(i).distCentro < p.radio - p.size /2 && b.get(i).scored == false){
         scored = true;
         b.get(i).scored = true;
      }
   }
   if(scored) score++;
   if(score > highscore){
      highscore = score;
      highscoreS[0] = str(highscore);
      saveStrings(directorio, highscoreS);
   }
}

void drawScore(){
   rectMode(CORNER);
   stroke(255);
   fill(backgr);
   rect(xScore,yScore,scoreSizeX,scoreSizeY);
   fill(255);
   text(score,xScore +13.4,yScore +14,scoreSizeX,scoreSizeY);
   text(highscore, 50, 200);
   fill(255);
   noStroke();
}

void Temporal(){
   stroke(0,0,0);
   line(100 * cos(radians(350)) + width /2, 100 * sin(radians(350)) + height /2, width /2, height /2);
   line(0, screenHeight /2, screenWidth, screenHeight /2);
   line(0.5f * 600 + screenWidth /2, 0.866f * 600 + screenHeight /2, 0.5f * -600 + screenWidth /2, 0.866f * -600 + screenHeight /2);
   line(-0.5f * 600 + screenWidth /2, 0.866f * 600 + screenHeight /2, -0.5f * -600 + screenWidth /2, 0.866f * -600 + screenHeight /2);
   text(millis(), 50, 50);
   noStroke();
}
