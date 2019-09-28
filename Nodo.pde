public class Nodo<T> {
  private T date;
  private Nodo next;
  public Nodo(T date,Nodo next){
    this.date=date;
    this.next=next;
  }
  public Nodo(T date){
    this.date=date;
    this.next=null;
  }
  public T getDate() {
    return date;
  }
  public void setDate(T date) {
    this.date = date;
  }
  public Nodo getNext() {
    return next;
  }
  public void setNext(Nodo next) {
    this.next = next;
  }
}
