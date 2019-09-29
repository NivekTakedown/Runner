char opc;
char j;
int translation;
LinkedStack<SimpleObject> list=new LinkedStack<SimpleObject>();
Button[] mainButtons=new Button[3];
Button[] runnerButtonsC=new Button[3];
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
  Nodo nodo= new Nodo(new SimpleObject(-56, 0, translation, loadImage("Floor_Runner.png"), "Floor_Runner.png"));
  list.push(nodo);
  nodo=new Nodo(new SimpleObject(-56, 0, translation, loadImage("Spike_Runner.png"), "Spike_Runner.png"));
  list.push(nodo);
  nodo=new Nodo(new SimpleObject(-56, 0, translation, loadImage("Ground_Runner.png"), "Ground_Runner.png"));
  list.push(nodo);
  sky=new SimpleObject(-25, -25, translation, loadImage("Sky.png"), "sky");
  player=new PlayerR(0, 0, loadImage("PROYECT_YUI.png"));


  size(800, 600);
}

void DrawObjects(LinkedStack<SimpleObject> list) {
  Nodo<SimpleObject> nodo=list.getTop();
  while (nodo!=null) {
    nodo.getDate().drawPNG();
    nodo=nodo.getNext();
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
    text(frameCount,100,100);
    opc=creationMenu(runnerButtonsC, opc, 6);
    //player.fall(grass);
    player.drawPNG();
    //saveProblem(grass);
    //moveMap(grass, ground, spike);
    DrawObjects(list);
    if(key=='s'||key=='S')
      saveProblem(list);
    //if(key=='l'||key=='L')
    //  list=LoadArray("problem","problem");
      
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
boolean verificationStack(LinkedStack<SimpleObject> list) {
  int x=int(mouseX/56)*56;
  int y=int(mouseY/56)*56;
  Nodo<SimpleObject> nodo=list.getTop();
  while (nodo.getNext()!=null) {
    if (nodo.getDate().getx()==x&&nodo.getDate().gety()==y) {
      return true;
    }
    nodo=nodo.getNext();
  }
  return false;
}
void mapCreator(int opc) {
  if (j =='r' ) {
    switch(opc) {
    case '1':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationStack(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Floor_Runner.png"), "Floor_Runner.png"));
            list.push(nodo);
          }
        }
        if (mousePressed&&mouseButton==RIGHT) {
          list.pop();
        }
        delay(120);
        break;
      }
    case '2':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationStack(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Spike_Runner.png"), "Spike_Runner.png"));
            list.push(nodo);
          }
        }
        if (mousePressed&&mouseButton==RIGHT) {
          list.pop();
        }
        delay(120);
        break;
      }
    case '3':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationStack(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56,translation, loadImage("Ground_Runner.png"), "Ground_Runner.png"));
            list.push(nodo);
          }
        }
        if (mousePressed&&mouseButton==RIGHT) {
          list.pop();
        }
        delay(120);
        break;
      }
    }
  }
}
//toca mejorarlo
//void moveMap(SimpleObject[] ob, SimpleObject[] ob1, SimpleObject[] ob2) {
//  if (keyPressed) {
//    delay(60);
//    switch(keyCode) {
//    case LEFT:
//      {
//        for (int i=0; i<ob.length; i++) {
//          ob[i].xPlusTranslation();
//          ob1[i].xPlusTranslation();
//          ob2[i].xPlusTranslation();
//        }
//        translation+=56;
//        break;
//      }
//    case RIGHT:
//      {
//        if (translation>0)
//        {
//          for (int i=0; i<ob.length; i++) {

//            ob[i].xLessTranslation();
//            ob1[i].xLessTranslation();
//            ob2[i].xLessTranslation();
//          }
//          translation-=56;
//          ;
//        } else {
//          translation=0;
//        }

//        break;
//      }
//    }
//  }
//}
void saveProblem(LinkedStack<SimpleObject> ob) {
  Nodo<SimpleObject> nodo=ob.getTop();
  JSONObject problem=new JSONObject();
  JSONArray objects=new JSONArray();
  problem.setJSONArray("problem", objects);
  int i=0;
  while(nodo!=null){
    objects.setJSONObject(i, nodo.getDate().saveJSONobject());
    nodo=nodo.getNext();
    i++;
  }
  saveJSONObject(problem, "data/problem");
}
//LinkedStack<SimpleObject> loadArray(String problemID, String array) {
//  JSONObject problem=loadJSONObject(problemID);
//  JSONArray objects=problem.getJSONArray(array);
  
//  LinkedStack ob=new LinkedStack<SimpleObject>();
//  Nodo<SimpleObject> nodo=ob.getTop();
//  int i=0;
//  do{
//    nodo.setDate(loadObject(i, objects ));
//    list.push(nodo);
//    i++;
//  }
//  while(nodo!=null);
//  return ob;
//}
//SimpleObject loadObject(int i, JSONArray objects ) {
//  SimpleObject ob=new SimpleObject(objects.getJSONObject(i).getInt("x"), objects.getJSONObject(i).getInt("y"), 0, loadImage(objects.getJSONObject(i).getString("ID")), objects.getJSONObject(i).getString("ID"));
//  return ob;
//}
