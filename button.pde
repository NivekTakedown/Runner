class Button extends Object {
  PImage texture;
  float  b, h; //  base, high,
  String t; 
  Button(int x, int y, PImage i, String ID) {
    super(x, y, ID);
    texture=i;
  }
  Button ( int x, int y, float ba, float hi, String te, String ID) {
    super(x, y, ID);
    t=te;
    b=ba;
    h=hi;
  }
  void drawPNG() {
    push();
    translate(x, y);
    image(texture, 0, 0);
    pop();
  }
  void drawPNG(color c) {
    noFill();
    stroke(c);
    rect(x, y, b, h);
    fill(c);
    textSize(h*.6);
    textAlign(CENTER, CENTER);
    text(t, x, y, b, h);
  }
  char pressed(char function, char function0) {
    if ((mouseX>=x&&mouseX<=x+56)&&(mouseY>=y&&mouseY<=y+56)&&mousePressed) {
      return function;
    } else
      return function0;
  }
 boolean seleccion() {
  if (mousePressed && mouseButton == LEFT ) {
    int a = mouseX;
    int c = mouseY;
    if ( ( a > x && a < (x+b) )&&(c > y  && c < (y+h))  ) {
      return true;
    } else 
    return false;
  }
  return false;
}
}
