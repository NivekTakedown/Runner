public class LinkedStack<T>{
  int size;
  private Nodo top;
  public LinkedStack(Nodo top){
    this.top= top;
  }
  public LinkedStack(){
    this.top=null;
  }
  public void push(Nodo nodo){
    if(nodo!=null){
      if(top!=null){
        nodo.setNext(top);
        top=nodo;
      }
      else{
        top=nodo;
        top.setNext(null);
      }
    }
  }
  public Nodo pop(){
    Nodo n=top;
    if(top!=null){
      top=top.getNext();
      n.setNext(null);
    }
    return n;
  }
  Nodo getTop(){
    return this.top;
  } 
  void makeEmpty(){
    this.top=null;
  }
}
