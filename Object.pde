abstract class Object {
  protected int x;
  protected int y;
  protected String ID;
  Object(int x, int y, String ID) {
    this.x=x;
    this.ID=ID;
    this.y=y;
    this.ID=ID;
  }
  abstract void drawPNG();
  void setx(int x) {
    this.x=x;
  }
  void setY(int y) {
    this.y=y;
  }
  int getx() {
    return x;
  }
  int gety() {
    return y;
  }

  JSONObject saveJSONobject() {
    JSONObject object=new JSONObject();
    object.setString("ID", ID);
    object.setInt("x", x);
    object.setFloat("y", y);
    return object;
  }
}
