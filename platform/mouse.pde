void mouseReleased() {
  if (mode == intro) {
    mode = playing;
    setworld();
  }
  if (mode == playing) {
    //if (place == false) {
      //if (dist(mouseX, mouseY, 30, 230)< 30) {
      //  selected = cloud;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 280)< 30) {
      //  selected = tree;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 330)< 30) {
      //  selected = petal;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 380)< 30) {
      //  selected = wall;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 430)< 30) {
      //  selected = vine;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 480)< 30) {
      //  selected = ground;
      //  place = true;
      //}
      //if (dist(mouseX, mouseY, 30, 530)< 30) {
      //  selected = crate;
      //  place = true;
      //}
    //} else {
      
      
      
      int ax = mouseX/gridsize;
      int ay = mouseY/gridsize;
      FBox b = new FBox(gridsize, gridsize);
      b.setPosition(ax*gridsize+player.getX()-width/2, ay*gridsize+player.getY()-width/2);
      if (selected == cloud && Ccloud>0) {

        b.setStatic(true);
        b.setFillColor(yellow);
        b.setStrokeColor(yellow);
        b.setName("cloud");
        //world.add(b);
      } 
      else if (selected == tree && Ctree> 0) {

        b.setStatic(true);
        b.setFillColor(brown);
        b.setStrokeColor(brown);
        b.setName("tree");
        //world.add(b);
      } 
      //else {
      //  b.setStatic(true);
      //  b.setFillColor(lightb);
      //  b.setStrokeColor(lightb);
      //  b.setName("crate");
      //}
      //println(b.getY());
      //println(mouseY);
      
      
      
      //else if (selected == petal) {

      //  b.setStatic(true);
      //  b.setFillColor(indigo);
      //  b.setStrokeColor(indigo);
      //  b.setName("petals");
      //} else if (selected == wall) {

      //  b.setStatic(true);
      //  b.setFillColor(purple);
      //  b.setStrokeColor(purple);
      //  b.setName("wall");
      //} else if (selected == vine) {

      //  b.setStatic(true);
      //  b.setFillColor(dgreen);
      //  b.setStrokeColor(dgreen);
      //  b.setName("vine");
      //} else if (selected == ground) {

      //  b.setStatic(true);
      //  b.setFillColor(lgreen);
      //  b.setStrokeColor(lgreen);
      //  b.setName("ground");
      //} else if (selected == crate) {

      //  b.setStatic(true);
      //  b.setFillColor(lightb);
      //  b.setStrokeColor(lightb);
      //  b.setName("crate");
      //}

      world.add(b);
      terrain.add(b);
      
      //place = false;
    //}
  }

  //if(mode == playing && dist(mouseX, mouseY, 50,50) < 50){
  //  mode = pausing;
  //}

  //if(mode == pausing && dist(mouseX, mouseY,50,50) < 50){
  //  mode = playing;
  //}

  if (mode == gameover) {
    mode = intro;
    setworld();
  }
}