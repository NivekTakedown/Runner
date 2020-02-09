char opc;
char j;
int translation;
LinkedList<SimpleObject> list=new LinkedList<SimpleObject>();
HashTable listH=new HashTable();
LinkedStack<SimpleObject> ctrlz=new LinkedStack<SimpleObject>();
LinkedStack<String> ctrlzCase=new LinkedStack<String>();
LinkedStack<String> ctrlYCase=new LinkedStack<String>();
LinkedStack<SimpleObject> ctrlY=new LinkedStack<SimpleObject>();
Button[] mainButtons=new Button[3];
Button[] runnerButtonsC=new Button[3];
Object sky;
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
  size(800, 600);
}
void DrawObjects(HashTable list) {

  Nodo<SimpleObject> nodo;
  for (int i=0; i<list.getTable().length; i++) {
    if (list.getTable()[i].getHead()!=null) {
      nodo=list.getTable()[i].getHead();
      while (nodo!=null) {
        nodo.getDate().drawPNG();
        nodo=nodo.getNext();
      }
    }
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
    textSize(60);
    DrawObjects(listH);
    if (key=='s'||key=='S') {
      saveProblem(listH.createList());
      key='}';
    }
    if (key=='l'||key=='L') {
      list=LoadProblem("data/problem", "problem");
      listH=new HashTable();
      while (list.getHead()!=null) {
        Nodo<SimpleObject> n=list.Delete();
        if (listH.SearchNodo(n.getDate().getx(), n.getDate().gety())==null) {
          listH.Insert(n.getDate());
          ctrlz.push(n);
          n= new Nodo("INSERT");
          ctrlzCase.push(n);
        }
      }
      key='}';
    }
    opc=creationMenu(runnerButtonsC, opc, 6);
    mapCreator(opc);
  }
}
char creationMenu(Button[] buttons, char opc_, int j) {
  fill(255, 255, 255);
  rect(250+5*j, 0, 150+j*3, 50+j*1);
  for (int i=0; i<buttons.length; i++) {
    buttons[i].drawPNG();
    String s=Integer.toString(i+1);
    if (buttons[i].pressed(s.charAt(0), opc_)!=opc_) {
      return buttons[i].pressed(s.charAt(0), opc_);
    }
  }
  return opc_;
}
boolean verificationHash(HashTable list) {
  if (list.SearchNodo(int(mouseX/56)*56, int(mouseY/56)*56)!=null) {
    return true;
  }
  return false;
}
void mapCreator(int opc) {
  if (j =='r' ) {
    switch(opc) {
    case '1':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if (verificationHash(listH)==false) {
            Nodo<SimpleObject> nodo= new Nodo<SimpleObject>(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Floor_Runner.png"), "Floor_Runner.png"));
            listH.Insert(nodo.getDate());
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
            ctrlY.makeEmpty();
          }
        }
        break;
      }
    case '2':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if (verificationHash(listH)==false) {
            Nodo<SimpleObject> nodo= new Nodo<SimpleObject>(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Ground_Runner.png"), "Ground_Runner.png"));
            listH.Insert(nodo.getDate());
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
            ctrlY.makeEmpty();
          }
        }
        break;
      }
    case '3':
      {
        if (mousePressed&&mouseButton==LEFT) {
          if (verificationHash(listH)==false) {
            Nodo<SimpleObject> nodo= new Nodo<SimpleObject>(new SimpleObject(int(mouseX/56)*56, int(mouseY/56)*56, translation, loadImage("Spike_Runner.png"), "Spike_Runner.png"));
            listH.Insert(nodo.getDate());
            nodo= new Nodo(nodo.date);
            ctrlz.push(nodo);
            nodo= new Nodo("INSERT");
            ctrlzCase.push(nodo);
            ctrlY.makeEmpty();
          }
        }
        break;
      }
    }
    if (mousePressed&&mouseButton==RIGHT) {
      Nodo nodo=listH.Delete(int(mouseX/56)*56, int(mouseY/56)*56);          
      if (nodo!=null) {
        ctrlY.makeEmpty();
        ctrlzCase.push(new Nodo("DELETE"));
        ctrlz.push(nodo);
      }
    }
    ctrlz();
    ctrlY();
  }
}
void ctrlz() {
  if (ctrlz.getTop()==null)
    return;
  if (key=='z'&&keyPressed) {
    if (ctrlzCase.getTop().getDate().equals("DELETE")) {
      Nodo<SimpleObject> n=ctrlz.pop();
      ctrlzCase.pop();
      if (n!=null) {
        listH.Insert(n.getDate());
        ctrlY.push(new Nodo(n.date));
        ctrlYCase.push(new Nodo("INSERT"));
      }
      delay(120);
      return;
    }
    if (ctrlzCase.getTop().getDate().equals("INSERT")) {
      Nodo<SimpleObject> n=ctrlz.pop();
      ctrlzCase.pop();
      if (n!=null) {
        listH.Delete(n.getDate().getx(), n.getDate().gety());
        ctrlY.push(n);
        ctrlYCase.push(new Nodo("DELETE"));
        delay(120);
      }
      return;
    }
  }
}
void ctrlY() {
  if (ctrlY.getTop()==null)
    return;
  if (key=='y'&&keyPressed) {
    if (ctrlYCase.getTop().getDate().equals("DELETE")) {
      Nodo<SimpleObject> n=ctrlY.pop();
      ctrlYCase.pop();
      if (n!=null) {
        listH.Insert(n.getDate());
        ctrlz.push(new Nodo(n.date));
        ctrlzCase.push(new Nodo("INSERT"));
      }
      delay(120);
      return;
    }
    if (ctrlYCase.getTop().getDate().equals("INSERT")) {
      Nodo<SimpleObject> n=ctrlY.pop();
      ctrlYCase.pop();
      if (n!=null) {
        listH.Delete(n.getDate().getx(), n.getDate().gety());
        ctrlz.push(n);
        ctrlzCase.push(new Nodo("DELETE"));
      }
      delay(120);
      return;
    }
  }
}
void saveProblem(LinkedList<SimpleObject> ob) {
  Nodo<SimpleObject> nodo=ob.getHead();
  JSONObject problem=new JSONObject();
  JSONArray objects=new JSONArray();
  problem.setJSONArray("problem", objects);
  int i=0;
  while (nodo!=null) {
    objects.setJSONObject(i, nodo.getDate().saveJSONobject());
    nodo=nodo.getNext();
    i++;
  }
  saveJSONObject(problem, "data/problem");
}
LinkedList<SimpleObject> LoadProblem(String problemID, String array) {
  JSONObject problem=loadJSONObject(problemID);
  JSONArray objects=problem.getJSONArray(array);
  LinkedList<SimpleObject> ob=new LinkedList<SimpleObject>();
  for (int i=0; i<objects.size(); i++)
    ob.Insert(new Nodo(loadObject(i, objects )));
  return ob;
}
SimpleObject loadObject(int i, JSONArray objects ) {
  SimpleObject ob=new SimpleObject(objects.getJSONObject(i).getInt("x"), objects.getJSONObject(i).getInt("y"), 0, loadImage(objects.getJSONObject(i).getString("ID")), objects.getJSONObject(i).getString("ID"));
  return ob;
}
