void updateTerrain() {
  int i = 0; 
  while (i< terrain.size() ) {
    FBox b = terrain.get(i);
    if ("collapse".equals(b.getName())) {
      b.setStatic(false);
      //b.setName("petal");
    }
    i++;
  }
}



//void contactStarted(FContact contacts){
//  FBody other = contacts.getBody1();
  
//  if(other == player){
//    other = contacts.getBody2();
//  }
  
//  if(contacts.contains("player", "bridge") ){
//    other.setName("collapse");
//  }
  
//}