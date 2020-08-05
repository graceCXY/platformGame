
class Goomba extends FBox {
  int costumeNum, direction, speed;

  Goomba() {
    super(gridsize, gridsize);
    setStaticBody(false);
    setFillColor(orange);
    setFriction(0);
    setName("Goomba");
    direction = 1;
    speed = 50;
  }

  void move() {
    setVelocity(speed * direction, getVelocityY() );
    if (touching("wall") || touching("goomba") ) {
      direction *= -1;
      setPosition(getX()+ direction, getY());
    }
    if (touching("player") ) {
      if (player.getY()<this.getY()) {
        setPosition(0, 0);
        world.remove(this);
        enemies.remove(this);
      } else {
        player.setPosition(200, 200);
        lives--;
      }
    }
  }

  boolean touching(String thing) {
    ArrayList<FContact> contacts = getContacts();
    for ( FContact c : contacts) {
      if (c.contains("goomba", thing)) {
        return true;
      }
    }
    return false;
  }
}