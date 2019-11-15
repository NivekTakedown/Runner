char opc;
char j;
int translation;
LinkedList<SimpleObject> list=new LinkedList<SimpleObject>();
LinkedStack<SimpleObject> ctrlz=new LinkedStack<SimpleObject>();
LinkedStack<String> ctrlzCase=new LinkedStack<String>();
LinkedStack<SimpleObject> ctrlY=new LinkedStack<SimpleObject>();
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
  sky=new SimpleObject(-25, -25, translation, loadImage("Sky.png"), "sky");
  player=new PlayerR(0, 0, loadImage("PROYECT_YUI.png"));
  size(800, 600);
}

void DrawObjects(LinkedList<SimpleObject> list) {
  Nodo<SimpleObject> nodo=list.getHead();
  while (nodo!=null) {
    nodo.getDate().drawPNG();
    nodo=nodo.getNext();
  }
}
void DrawObjects(LinkedStack<SimpleObject> list) {
  Nodo<SimpleObject> nodo=list.getTop();
  while (nodo!=null) {
    nodo.getDate().drawPNG();
    nodo=nodo.getNext();
  }
}
void DrawObjectsLinkedTree(TreeNode<SimpleObject> nodo) {
  if(nodo!=null){
    DrawObjectsLinkedTree(nodo.getleft()) ;
    nodo.getDate().drawPNG();
    DrawObjectsLinkedTree(nodo.getright()) ;
  }
}
void ShowList(LinkedList<SimpleObject> list){
  Nodo<SimpleObject> nodo=list.getHead();
  int i=0;
  while (nodo!=null) {
        
        i++;
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
    textSize(20);
    ShowList(list);
    opc=creationMenu(runnerButtonsC, opc, 6);
    //player.fall(grass);
    player.drawPNG();
    //saveProblem(grass);
    //moveMap(grass, ground, spike);
    DrawObjects(list);
    //if(key=='s'||key=='S')
      //saveProblem(list);
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
boolean verificationList(LinkedList<SimpleObject> list) {
    if (SearchNodo(list)!=null) {
      return true;
    }
  return false;
}
Nodo SearchNodo(LinkedList<SimpleObject> list) {
  int x=int(mouseX/56)*56;
  int y=int(mouseY/56)*56;
  Nodo<SimpleObject> nodo=list.getHead();
  while (nodo!=null) {
    if (nodo.getDate().getx()==x&&nodo.getDate().gety()==y) {
      return nodo;
    }
    nodo=nodo.getNext();
  }
  return null;
}
Nodo SearchNodo(Nodo<SimpleObject> nodo, Nodo<SimpleObject> Head) {
  if(nodo==null)
    return null;
  while (Head!=null) {
    if (Head.getDate().getx()==nodo.getDate().getx()&&Head.getDate().gety()==nodo.getDate().gety()) {
      return Head;
    }
    Head=Head.getNext();
  }
  return null;
}
//boolean verificationTree(LinkedTree<SimpleObject> tree) {
//  int x=int(mouseX/56)*56;
//  int y=int(mouseY/56)*56;
//  //Nodo<SimpleObject> nodo=list.getTop();
//  while (nodo.getNext()!=null) {
//    if (nodo.getDate().getx()==x&&nodo.getDate().gety()==y) {
//      return true;
//    }
//    nodo=nodo.getNext();
//  }
//  return false;
//}
void mapCreator(int opc) {
  if (j =='r' ) {
    switch(opc) {
    case '1':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationList(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Floor_Runner.png"), "Floor_Runner.png"));
            list.Insert(nodo);
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
          }
        }
        delay(120);
        break;
      }
    case '2':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationList(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Spike_Runner.png"), "Spike_Runner.png"));
            list.Insert(nodo);
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
          }
        }
        delay(120);
        break;
      }
    case '3':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if(verificationList(list)==false){
            Nodo nodo= new Nodo(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56,translation, loadImage("Ground_Runner.png"), "Ground_Runner.png"));
            list.Insert(nodo);
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
          }
        }
        delay(120);
        break;
      }

    }
      if (mousePressed&&mouseButton==RIGHT) {
        Nodo nodo=list.Delete(SearchNodo(list));
            ctrlz.push(nodo);
            if(nodo!=null){
              nodo= new Nodo("DELETE");
              ctrlzCase.push(nodo);
            }
           delay(120);
      }
      if(key=='s'){
          DrawObjects(ctrlz);
      }
      
      ctrlz();
  }
}
void ctrlz(){
  if(ctrlz.getTop()==null)
    return;
  if(key=='z'&&keyPressed){
    textSize(500);
        if(ctrlzCase.getTop().getDate().equals("DELETE")){
            text("INSERT", 300, 200);
            list.Insert(ctrlz.pop());
            ctrlzCase.pop();
            delay(120);
            return;
        }
        if(ctrlzCase.getTop().getDate().equals("INSERT")){
            text("DELETE", 300, 200);
            list.Delete(SearchNodo(ctrlz.pop(),list.getHead()));
            text("Borrado", 500, 200);
            ctrlzCase.pop();
            delay(120);
            return;
        }
  }
}
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
