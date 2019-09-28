char opc;
char j;
int grassObjectID;
int spikeObjectID;
int groundObjectID;
int translation;
SimpleObject[] grass;
SimpleObject[] spike;
SimpleObject[] ground; 
SimpleObject[] grassProblem;
SimpleObject[] spikeProblem;
SimpleObject[] groundProblem;
Button[] mainButtons=new Button[3];
Button[] runnerButtonsC=new Button[3];
Button[] runnerButtonsSC=new Button[4];
Object sky;
PlayerR player;
void setup() {
  j= 'm';
  opc='0';
  translation=0;
  frameRate(120);
  runnerButtonsC[0]=new Button(224+56, 0, loadImage("BUTTON_0.png"), "BUTTON_0.png");
  runnerButtonsC[2]=new Button(334, 0, loadImage("BUTTON_1.png"), "BUTTON_1.png");
  runnerButtonsC[1]=new Button(112+224+56, 0, loadImage("BUTTON_2.png"), "BUTTON_2.png");
  mainButtons[0] = new Button(300, 350, 200, 50, "Runner", "BUTTON_4.png");
  mainButtons[2] =  new Button(210, 200, 400, 80, "PROYECT", "BUTTON_6.png");

  grass=new SimpleObject[100];
  spike=new SimpleObject[100];
  ground=new SimpleObject[100];
  for (int i=0; i<grass.length; i++)
    grass[i]=new SimpleObject(-56, 0, translation, loadImage("Floor_Runner.png"), "Floor_Runner.png");
  for (int i=0; i<spike.length; i++)
    spike[i]=new SimpleObject(-56, 0, translation, loadImage("Spike_Runner.png"), "Spike_Runner.png");
  for (int i=0; i<ground.length; i++)
    ground[i]=new SimpleObject(-56, 0, translation, loadImage("Ground_Runner.png"), "Ground_Runner.png");
  grassObjectID=0;
  spikeObjectID=0;
  groundObjectID=0;
  sky=new SimpleObject(-25, -25, translation, loadImage("Sky.png"), "sky");
  player=new PlayerR(0, 0, loadImage("PROYECT_YUI.png"));


  size(800, 600);
}
boolean verificationArray(SimpleObject[] ob) {
  if (verification(int((translation+mouseX)/56)*56, int(mouseY/56)*56, ob)!=false) 
    return true;
  else
    return false;
}
boolean verification(int x, int y, Object[] ob) {
  for (Object p : ob) {
    if (p.getx()==x&&(p.gety()==y)) {
      return false;
    }
  }
  return true;
}
void verificationObject(SimpleObject[] ob, SimpleObject[] ob2, SimpleObject[] ob3, int code, int startx, int starty) {
  if (verificationArray (ob)&&verificationArray (ob2)&&verificationArray (ob3) ) {
    ob[code]=resetxy(ob[code], startx, starty, translation);
  }
}
void draw() { 
  background(0);
  if (j=='m' ) {
    mainButtons[0].drawPNG(color(255, 0, 0));
    mainButtons[2].drawPNG(color(169, 45, 167));
    if (mainButtons[0].seleccion()) {
      j='r';
    }
  }

  if (j=='r' ) {
    if (keyPressed)
      opc=key;
    sky.drawPNG();
    mapCreator(opc);
    textSize(40);
    for (int i=0; i<grass.length; i++) 
      grass[i].drawPNG();
    for (int i=0; i<spike.length; i++) 
      spike[i].drawPNG();
    for (int i=0; i<ground.length; i++) 
      ground[i].drawPNG();
    opc=creationMenu(runnerButtonsC, opc, 6);
    player.fall(grass);
    player.drawPNG();
    saveProblem(grass);
    moveMap(grass, ground, spike);
  }
}
char creationMenu(Button[] buttons, char opc_, int j) {
  fill(255, 255, 255);
  rect(250+5*j, 0, 150+j*3, 50+j*1);
  for (int i=0; i<buttons.length; i++) {
    buttons[i].drawPNG();
    text(char(i), 100, 100);
    String s=Integer.toString(i+1);
    if (buttons[i].pressed(s.charAt(0), opc_)!=opc_) {

      return buttons[i].pressed(s.charAt(0), opc_);
    }
  }
  return opc_;
}
void mapCreator(int opc) {
  if (j =='r' ) {
    switch(opc) {
    case '1':
      {
        verificationObject(grass, ground, spike, grassObjectID, -56, 0);
        grassObjectID=changeObject(grassObjectID, 100);
        break;
      }
    case '2':
      {
        verificationObject(spike, grass, ground, spikeObjectID, - 56, 0);
        spikeObjectID=changeObject(spikeObjectID, 99);
        break;
      }
    case '3':
      {
        verificationObject( ground, spike, grass, groundObjectID, -112, 0);
        groundObjectID=changeObject(groundObjectID, 99);
        break;
      }
    }
  }
  }
SimpleObject resetxy(SimpleObject object, int startx, int starty, int xTranslation) {
  if (mousePressed&&mouseButton==LEFT) {
    delay(60);
    object.setY(int(mouseY/56)*56);
    object.setx((int(mouseX/56)*56)+xTranslation);
  }
  if (mousePressed&&mouseButton==RIGHT) {
    if (grassObjectID>0) {
      delay(60);
      object.setxTranslate(0);
      object.setx(startx);
      object.setY(starty);
    }
  }

  return object;
}
int changeObject(int object, int final_) {
  if (mousePressed&&mouseButton==LEFT) {

    if (object<=final_) {
      object++;
      if (object>final_)
        object=final_;
    }
  }
  if (mousePressed&&mouseButton==RIGHT) {

    if (object>=1)
      object--;
    else 
    object=0;
  }
  delay(60);
  return object;
}

void moveMap(SimpleObject[] ob, SimpleObject[] ob1, SimpleObject[] ob2) {
  if (keyPressed) {
    delay(60);
    switch(keyCode) {
    case LEFT:
      {
        for (int i=0; i<ob.length; i++) {
          ob[i].xPlusTranslation();
          ob1[i].xPlusTranslation();
          ob2[i].xPlusTranslation();
        }
        translation+=56;
        break;
      }
    case RIGHT:
      {
        if (translation>0)
        {
          for (int i=0; i<ob.length; i++) {

            ob[i].xLessTranslation();
            ob1[i].xLessTranslation();
            ob2[i].xLessTranslation();
          }
          translation-=56;
          ;
        } else {
          translation=0;
        }

        break;
      }
    }
  }
}
void saveProblem(Object[] ob) {
  JSONObject problem=new JSONObject();
  JSONArray objects=new JSONArray();
  problem.setJSONArray("problem", objects);
  for (int i=0; i<ob.length; i++)
    objects.setJSONObject(i, ob[i].saveJSONobject());
  saveJSONObject(problem, "data/problem");
}
SimpleObject[] loadArray(String problemID, String array, int tam) {
  JSONObject problem=loadJSONObject(problemID);
  JSONArray objects=problem.getJSONArray(array);
  SimpleObject[] ob=new SimpleObject[tam];
  for (int i=0; i<tam; i++)
    ob[i]=loadObject(i, objects );
  return ob;
}
SimpleObject loadObject(int i, JSONArray objects ) {
  SimpleObject ob=new SimpleObject(objects.getJSONObject(i).getInt("x"), objects.getJSONObject(i).getInt("y"), 0, loadImage(objects.getJSONObject(i).getString("ID")), objects.getJSONObject(i).getString("ID"));
  return ob;
}
