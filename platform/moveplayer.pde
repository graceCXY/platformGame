void updateplayer() {
  if (mode == playing) {
    ArrayList<FContact> contacts = player.getContacts();

    if (up == true && contacts.size() > 0 ) {
      player.setVelocity(player.getVelocityX(), -500);
      currentAction = jump;
    }

    if (left == true) {
      vx = -275;
      currentAction = runleft;
      //costumeNum = 0;
    } else
      if (right == true) {
        vx = 275;
        currentAction = run;
        //costumeNum = 0;
      } else {
        vx = 0;
        //currentAction = idle;
        costumeNum = 0;
      }
    if (up == false && down == false && left == false && right == false) {
      currentAction = idle;
    }
    player.setVelocity(vx, player.getVelocityY());

    player.attachImage(currentAction[costumeNum]);
    if (frameCount%10 == 0) {
      costumeNum++;
      if (costumeNum >= currentAction.length) {
        costumeNum = 0;
      }
    }
  }
  if (lives <=0) {
    player.setVelocity(0,0);
    lives = 5;
    mode = gameover;
  }
  
  
}
void collision() {
  ArrayList<FContact> contacts = player.getContacts();
  int zz = 0;
  //println("***" + contacts.size() + "***");
  for (FContact c : contacts) {
    zz++;
    //println(zz);
    if(c.contains("collectable", "player") ){
      FBody b1 = c.getBody1();
      FBody b2 = c.getBody2();
      //println("BRIDGE!");
      
      if(b1 == player){
        //world.remove(b2);
        
        if(b2.getFillColor() == brown){
          Ctree = Ctree+1;
        }
        if(b2.getFillColor() == purple ){
          Cpetal= Cpetal+1;
        }
        if(b2.getFillColor() == lightb ){
          Ccrate= Ccrate+1;
        }
        if(b2.getFillColor() == indigo ){
          Cwall= Cwall+1;
        }
        if(b2.getFillColor() == lgreen ){
          Cground= Cground+1;
        }
        if(b2.getFillColor() == dgreen ){
          Cvine= Cvine+1;
        }
        if(b2.getFillColor() == yellow ){
          Ccloud= Ccloud+1;
          //Ccloud = Ccloud/2;
        }
        
        b2.setPosition(0,0);
        collectables.add(b2);
        
        
      }else{
        //world.remove(b1);
        if(b1.getFillColor() == brown){
          Ctree = Ctree+1;
        }
        if(b1.getFillColor() == purple ){
          Cpetal= Cpetal+1;
        }
        if(b1.getFillColor() == lightb ){
          Ccrate= Ccrate+1;
        }
        if(b1.getFillColor() == indigo ){
          Cwall= Cwall+1;
        }
        if(b1.getFillColor() == lgreen ){
          Cground= Cground+1;
        }
        if(b1.getFillColor() == dgreen ){
          Cvine= Cvine+1;
        }
        if(b1.getFillColor() == yellow ){
          Ccloud= Ccloud+1;
          //Ccloud = Ccloud/2;
        }
        
        b1.setPosition(0,0);
        collectables.add(b1);
      }
    }
    if (c.contains("lava")) {
      player.setPosition(200, 200);
      lives --;
    }
    //if(c.contains("hammer", ) ){
      
    //}
    if (c.contains("hammer", "player")) {
      player.setPosition(200, 200);
      lives --;
      //println("OUCH!");
      return;
      //FBody b1 = c.getBody1();
      //FBody b2 = c.getBody2();
      
      //if(b1 == player){
      //  println(b1.getY());
      //println(b2.getY());
      //  println("working");
      //  if(b1.getY()+gridsize <= b2.getY()){
      //    b2.setPosition(0,0);
      //  }else {
      //    b1.setPosition(200, 200);
      //    lives --;
      //  }
      //}else{
      //   if(b2.getY()+gridsize == b1.getY() ){
      //    b1.setPosition(0,0);
      //  }else {
      //    b2.setPosition(200, 200);
      //    lives --;
      //  }
      //}
      
    }
    if (c.contains("spring")) {
      player.setVelocity(player.getVelocityX(), -700);
    }
    if (c.contains("player","bridge")) {
      FBody b3 = c.getBody1();
      FBody b4 = c.getBody2();
      //println("BRIDGE!");
      
      if(b3 == player){
        b4.setStatic(false);
      }else{
        b3.setStatic(false);
      }
    }

    if (c.contains("portal1")) {
      player.setPosition(portal2.getX()+70, portal2.getY());
    }
    if ( c.contains("portal2")) {
      player.setPosition(portal1.getX()+70, portal1.getY());
    }
  }
}
//void makeplayer() {
//  player = new FBox(20, 20);
//  player.setPosition(200, 200);
//  player.setFillColor(white);
//  player.setStatic(false);
//  player.setGrabbable(false);
//  player.setDensity(1);
//  player.setAngularVelocity(0);
//  player.setRotatable(false);
//  world.add(player);
//}

void keyPressed() {
  if (mode == playing) {
    if (keyCode == UP) {
      up = true;
    }  
    if (keyCode == DOWN) {
      down = true;
    }
    if (keyCode == LEFT) {
      left = true;
    }
    if (keyCode == RIGHT) {
      right = true;
    }
  }
}

void keyReleased() {
  if (mode == playing) {
    if (keyCode == UP) {
      up = false;
    }  
    if (keyCode == DOWN) {
      down = false;
    }
    if (keyCode == LEFT) {
      left = false;
    }
    if (keyCode == RIGHT) {
      right = false;
    }
    if (key == 'B') {
      bomb = new FBomb();
    }
    if(keyCode == SHIFT){
      mode = pausing;
    }
    
    if(key == '1'){
      selected = cloud;
      Ccloud--;
    }
    if(key == '2'){
      selected = tree;
      Ctree--;
    }
    if(key == '3'){
      selected = petal;
      Cpetal--;
    }
    if(key == '4'){
      selected = wall;
      Cwall--;
    }
    if(key == '5'){
      selected = vine;
      Cvine--;
    }
    if(key == '6'){
      selected = ground;
      Cground--;
    }
    if(key == '7'){
      selected = crate;
      Ccrate--;
    }
  }
  if(keyCode == SHIFT && mode == pausing){
      mode = playing;
  }
}