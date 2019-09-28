public class LinkedStack<T>{
  
  Nodo top;
  public LinkedStack(Nodo top){
    this.top= top;
  }
  public LinkedStack(){
    this.top=null;
  }
  public void push(Nodo nodo){
    if(top!=null){
      nodo.setNext(top);
      top=nodo;
    }
    else{
      top=nodo;
      top.setNext(null);
    }
  }
  public void pop(){
    if(top.getNext()!=null){
      top=top.getNext();
    }
  }
  
  
}
