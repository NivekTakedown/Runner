class SimpleObject extends Object {
  protected int xTranslate;
  protected PImage texture; 
  SimpleObject(int x, int y, int xTranslate, PImage i, String ID) {
    super(x, y, ID);
    this.texture=i;
    this.xTranslate= xTranslate;
  }
  void drawPNG() {
    push();
    translate(x-xTranslate, y);
    image(texture, 0, 0);
    pop();
  }
  void setxTranslate(int xTranslate) {
    this.xTranslate= xTranslate;
  }
  void xPlusTranslation() {
    xTranslate+=56;
  }
  void xLessTranslation() {
    xTranslate-=56;
  }
}
