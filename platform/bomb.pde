class FBomb extends FBox {


  int timer;
  FBomb() {
    super(10, 10);
    timer = 100;
    this.setPosition(player.getX()+50, player.getY());
    this.setFillColor(white);
    this.attachImage(explosive);
    world.add(this);
  }
  void updateTimer() {
    timer--;
  }
  void kaboom() {
    for (FBox box : terrain) {
      if (dist(bomb.getX(), bomb.getY(), box.getX(), box.getY())<120) {

        if (box.getName().equals("petals")|| box.getName().equals("cloud")||box.getName().equals("tree")||box.getName().equals("crate")||box.getName().equals("wall")) {
          box.setStatic(false);
          box.setVelocity(random(-999, 999), random(-999, 999) );
          FBox abc = new FBox(gridsize*0.5, gridsize*0.5);
          abc.setPosition(box.getX(), box.getY() );
          world.add(abc);
          abc.setName("collectable");
          abc.setFillColor(box.getFillColor());
          world.remove(box);
        }
        if(box.getName().equals("lava")){
          world.remove(box);
        }
      }
      if (dist(bomb.getX(), bomb.getY(), player.getX(), player.getY())<100) {
        player.setPosition(200, 200);
        lives--;
      }
    }
    for (FBox enemy : enemies) {
      if (dist(bomb.getX(), bomb.getY(), enemy.getX(), enemy.getY())<120) {
        world.remove(enemy);
      }
    }
  }
}