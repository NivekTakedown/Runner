char opc;
char j;
int translation;
LinkedList<SimpleObject> list=new LinkedList<SimpleObject>();
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
    opc=creationMenu(runnerButtonsC, opc, 6);
    //moveMap(grass, ground, spike);
    DrawObjects(list);
    if(key=='s'||key=='S')
      saveProblem(list);
    if(key=='l'||key=='L')
      list=LoadProblem("data/problem","problem");
      
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
            ctrlY.makeEmpty();
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
            ctrlY.makeEmpty();
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
            ctrlY.makeEmpty();
          }
        }
        delay(120);
        break;
      }

    }
      if (mousePressed&&mouseButton==RIGHT) {
        Nodo nodo=list.Delete(SearchNodo(list));          
            if(nodo!=null){
              ctrlY.makeEmpty();
              ctrlzCase.push(new Nodo("DELETE"));
              ctrlz.push(nodo);
            }
           delay(120);
      }
      if(key=='v'){
          DrawObjects(ctrlz);
      }  
      ctrlz();
      ctrlY();
  }
}
void ctrlz(){
  if(ctrlz.getTop()==null)
    return;
  if(key=='z'&&keyPressed){
        if(ctrlzCase.getTop().getDate().equals("DELETE")){
          Nodo n=ctrlz.pop();
          ctrlzCase.pop();
          if(n!=null){
            list.Insert(n);
            ctrlY.push(new Nodo(n.date));
            ctrlYCase.push(new Nodo("INSERT"));
            delay(240);
          }
          return;
        }
        if(ctrlzCase.getTop().getDate().equals("INSERT")){
          Nodo n=ctrlz.pop();
          ctrlzCase.pop();
          if(n!=null){
            list.Delete(SearchNodo(n,list.getHead()));
            ctrlY.push(n);
            ctrlYCase.push(new Nodo("DELETE"));
            delay(240);
          }
          return;
        }
  }
}
void ctrlY(){
  if(ctrlY.getTop()==null)
    return;
  if(key=='y'&&keyPressed){
        if(ctrlYCase.getTop().getDate().equals("DELETE")){
          Nodo n=ctrlY.pop();
          ctrlYCase.pop();
          if(n!=null){
            list.Insert(n);
            ctrlz.push(new Nodo(n.date));
            ctrlzCase.push(new Nodo("INSERT"));
          }
          delay(240);
          return;
        }
        if(ctrlYCase.getTop().getDate().equals("INSERT")){
          Nodo n=ctrlY.pop();
          ctrlYCase.pop();
          if(n!=null){
            list.Delete(SearchNodo(n,list.getHead()));
            ctrlz.push(n);
            ctrlzCase.push(new Nodo("DELETE"));
          }
          delay(240);
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
  while(nodo!=null){
    objects.setJSONObject(i, nodo.getDate().saveJSONobject());
    nodo=nodo.getNext();
    i++;
  }
  saveJSONObject(problem, "data/problem");
}
LinkedList<SimpleObject> LoadProblem(String problemID,String array) {
  JSONObject problem=loadJSONObject(problemID);
  JSONArray objects=problem.getJSONArray(array);
  LinkedList<SimpleObject> ob=new LinkedList<SimpleObject>();
        System.out.println(array+ objects.size());
        for (int i=0; i<objects.size(); i++)
          ob.Insert(new Nodo(loadObject(i, objects )));
  return ob;    
}
SimpleObject loadObject(int i, JSONArray objects ) {
  SimpleObject ob=new SimpleObject(objects.getJSONObject(i).getInt("x"), objects.getJSONObject(i).getInt("y"), 0, loadImage(objects.getJSONObject(i).getString("ID")), objects.getJSONObject(i).getString("ID"));
  return ob;
}
