class HammerThrower extends FBox {

  //int myhammer;
  HammerThrower() {
    super(gridsize, gridsize);
    setStaticBody(true);
    setFillColor(black);
    setFriction(0);
    setRotatable(false);
    setName("ht");
  }

  void move() {
    setVelocity(10, 0);
    if ( frameCount % 180 == 0) {
      //println("H ");
      FBox h = new FBox(gridsize*0.5, gridsize*0.5);
      h.setPosition(this.getX(), this.getY()-gridsize);
      h.setStatic(false);
      h.setFillColor(grey);
      h.setName("hammer");
      h.setVelocity(random(-100, 100), -500 );
      h.setSensor(true);

      world.add(h);
      if (touching("cloud")||touching("bridge")||touching("tree")||touching("petals")|| touching("ground") || touching("wall") ) {
        world.remove(h);
      }
      println(this);
      if (h.getY()>=this.getY()+100) {
        //println("cindy");
        h.setVelocity(0, 0);
        world.remove(h);
      }
      //ArrayList<FContact> contacts = h.getContacts();
      //for ( FContact c : contacts) {
      //  if (c.contains("player")) {
      //    lives--;
      //  }else{
      //    h.setSensor(true);
      //  }
      //}
    }
  }
  boolean touching(String thing) {
    ArrayList<FContact> contacts = getContacts();
    for ( FContact c : contacts) {
      if (c.contains("hammer", thing)) {
        return true;
      }
    }
    return false;
  }
}