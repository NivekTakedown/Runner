class PlayerR extends Player {
  protected PImage sprite;
  protected float fallSpeed;
  protected boolean floor;
  PlayerR(int x, int y, PImage sprite) {
    super(x, y);
    this.sprite=sprite;
    fallSpeed=1;
    floor=false;
  }
  void move() {
  }
  void fall(Object[] ob) {
    groundCollision(ob);
    if (floor==false)
      y++;
  }
  void drawPNG() {

    push();
    translate(x, y);
    image(sprite, 0, 0);
    pop();
  }
  void groundCollision(Object[] ob) {
    int i=0;
    for (Object p : ob) {
      if (p.getx()==(int(this.x/56)*56)&&p.gety()==(int(this.y/56)*56)+56) {
        i++;
      }
    }
    if (i>=1)
      floor= true;
    else
      floor= false;
  }
}
