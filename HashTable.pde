public  class HashTable {
  private LinkedList[] table;
  private int prNumber;
  private int NumberNodes;
  public HashTable() {
    prNumber=7;
    NumberNodes=0;
    table=new LinkedList[prNumber];
    for (int i=0; i<prNumber; i++)
      table[i]=new LinkedList<SimpleObject>();
  }
  public LinkedList[] getTable() {
    return this.table;
  }
  public void Insert(SimpleObject object) {
    String s=Integer.toString(object.getx())+Integer.toString(object.gety());
    Nodo n =table[hash(s)].Insert(new Nodo(object));
    if (n!=null)
      NumberNodes++;
    if (NumberNodes*1.0/prNumber>0.5)
      reHashing();
    System.out.println(NumberNodes+" "+prNumber);
  }
  Nodo SearchNodo(int x, int y) {
    String s=Integer.toString(x)+Integer.toString(y);
    return table[hash(s)].SearchNodo(x, y);
  }
  public LinkedList createList(){
    LinkedList[] table_=new LinkedList[prNumber];
    LinkedList list=new LinkedList();
    for (int i=0; i<table_.length; i++)
      table_[i]=table[i];
    table=new LinkedList[prNumber];
    for (int i=0; i<table.length; i++)
      table[i]=new LinkedList<SimpleObject>();
      NumberNodes=0;
    for (int i=0; i<table_.length; i++) {
      while (table_[i].getHead()!=null) {
        Nodo<SimpleObject> n=table_[i].Delete();
        Insert(n.getDate());
        list.Insert(n);
      }
    }
    return list;
  }
  public void reHashing() {
    LinkedList[] table_=new LinkedList[prNumber];
    prNumber=nextPrimeNumber(prNumber*2);
    for (int i=0; i<table_.length; i++)
      table_[i]=table[i];
    table=new LinkedList[prNumber];
    for (int i=0; i<table.length; i++)
      table[i]=new LinkedList<SimpleObject>();
      NumberNodes=0;
    for (int i=0; i<table_.length; i++) {
      while (table_[i].getHead()!=null) {
        Nodo<SimpleObject> n=table_[i].Delete();
        Insert(n.getDate());
      }
    }
  }
  public Nodo Delete(int x, int y) {
    String s=Integer.toString(x)+Integer.toString(y);
    Nodo n=table[hash(s)].Delete(table[hash(s)].SearchNodo(x, y));
    if (n!=null)
      NumberNodes++;
    return n;
  }
  public int hash(String Key) {
    int hashVal=0;
    for (int i=0; i<Key.length(); i++)
      hashVal+=Key.charAt(i)*i;
    return hashVal%prNumber;
  }
  public int nextPrimeNumber(int number) {
    boolean b=false;
    int i;
    while (b==false) {
      i=2;
      while (number%i!=0&&i<number) {
        if (i+1==number)
          b=true;
        i++;
      }
      if (b==false)
        number++;
    }
    return number;
  }
}
