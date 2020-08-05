class Thwomp extends FBox{
  int costumeNum;
  boolean ismoving;
  float tx, ty;

  int timer;
  
  Thwomp(){
    super(gridsize*2,gridsize*2);
    setStaticBody(true);
    setFillColor(pink);
    setFriction(0);
    setRotatable(false);
    setName("thwomp");

    timer = 30;
    tx = this.getX();
    ty = this.getY();
    
  }
  void move(){
    
    if(dist(player.getX(), player.getY(),this.getX(),this.getY()) <100){
      this.setStatic(false);
    }
    if(touching("player") ){
      lives--;
      player.setPosition(200,200);
    }
    
  }
  void updateTimer(){
    timer--;

  }
  
  void resetT(){
    if(touching("cloud")||touching("bridge")||touching("tree")||touching("petals")|| touching("ground") || touching("wall") ){
      setStatic(true);
      setPosition(this.getX(), this.getY() - 100);
      
      
    }
  }
  
  boolean touching(String thing) {
    ArrayList<FContact> contacts = getContacts();
    for ( FContact c : contacts) {
      if (c.contains("thwomp", thing)) {
        return true;
      }
    }
    return false;
  }
  
}