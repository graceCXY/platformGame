void updateEnemies(){
  
  int i = 0; 
  while (i< enemies.size() ) {
    FBox enemy = enemies.get(i);
    
    if (enemy.getName().equals("goomba")) {
      ((Goomba) enemy).move();
    }
    if(enemy.getName().equals("thwomp") ){
      ((Thwomp) enemy).move();
      ((Thwomp) enemy).updateTimer();
      if( ((Thwomp) enemy).timer <= 0){
        //println("life is hard");
         ((Thwomp) enemy).resetT(); 
      }
    }
    //if (enemy.getName().equals("ht")) {
      
    //  ((HammerThrower) enemy).move();
    //}
    i++;
  }
}