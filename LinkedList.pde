public class LinkedList<T>{
  private Nodo Head;
  public LinkedList(Nodo top){
    this.Head= top;
  }
  public Nodo getHead(){
    return this.Head;
  }
  public LinkedList(){
    this.Head=null;
  }
  public void Insert(Nodo nodo){
    if(nodo==null)
      return;
    if(Head!=null){
      nodo.setNext(Head);
      Head=nodo;
    }
    else{
      Head=nodo;
      Head.setNext(null);
    }
  }
  public Nodo Delete(Nodo N){
    Nodo nodo=this.Head;
    if(nodo!=null&&N!=null){
      if(nodo==N){
        this.Head=N.getNext();
        N.setNext(null);
        return N;
      }
      while(nodo!=null){
        if(nodo.getNext()==N){
          nodo.setNext(N.getNext());
          N.setNext(null);
          return N;
        }
        nodo=nodo.getNext();
      }
    }
    return null;
    
  }
  
}
