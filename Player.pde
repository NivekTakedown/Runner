abstract class Player{
  protected int x;
  protected int y;
  Player(int x, int y){
  this.x=x;
  this.y=y;
  }
  abstract void drawPNG();
  abstract void move();
}
