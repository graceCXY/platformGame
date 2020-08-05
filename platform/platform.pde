import fisica.*;


FWorld world;
PImage map, background;
PImage explosive;
PImage lava, spring;

color black = color(0, 0, 0);
color white = color(255, 255, 255);

color purple = color(163, 73, 164);
color pink = color(255, 174, 201);
color indigo = color(200, 191, 231);

color lgreen = color(181, 230, 29);
color dgreen = color(34, 177, 76);

color brown = color(185, 122, 87);
color dbrown = color(136, 0, 21);

color red = color(237, 28, 36);
color blue = color(0, 162, 232);

color orange = color(255, 127, 39);
color yellow = color(255, 201, 14);
color gold = color(255, 242, 0);
color beige = color(239, 228, 176);

color grey = color(127, 127, 127);
color navyb = color(63, 72, 204);

color lightb = color(153, 217, 234);

int x;
int y;

ArrayList<FBox> terrain = new ArrayList<FBox>();
ArrayList<FBox> enemies = new ArrayList<FBox>();

int zoom = 3;
int gridsize = 30;

FBox player;
boolean up, left, right, down;
int vx, vy;


PImage[] megamanSprites;
PImage[] runleft;
PImage[] run;
PImage[] idle;
PImage[] jump;
PImage[] currentAction;
int costumeNum = 0;
int frame = 0;

FBox portal1, portal2;

FBomb bomb;
FCircle coin;

int intro = 1;
int playing = 2;
int pausing = 3;
int gameover = 4;
int mode;
int lives;

ArrayList<FBody> collectables = new ArrayList<FBody>();
int Ccloud = 0;
int Ctree = 0;
int Cpetal = 0;
int Cwall = 0;
int Cvine = 0;
int Cground = 0;
int Ccrate = 0;

int selected;
int cloud = 10;
int tree = 11;
int petal = 12;
int wall = 13;
int vine = 14;
int ground = 15;
int crate = 16;
boolean place = false;

void setup() {
  size(800, 600, FX2D);

  Fisica.init(this);
  

  map = loadImage("map14.png");
  background= loadImage("nightsky.jpg");

  setworld();
  mode = intro;

  up = false;
  down = false;
  right = false;
  left = false;

  vx = 0; 
  vy = 0;

  //makeplayer();

  megamanSprites = new PImage[70];
  runleft = new PImage[3];
  run = new PImage[3];
  idle = new PImage[1];
  jump = new PImage[1];

  //int i = 0;
  //for(int y = 0;y <500; y = y + 50){
  //  for(int x = 0; x<350; x = x+ 50){
  //  megamanSprites[i] = megamanSpriteSheet.get(x,y,50,50);

  //  i++;
  //  }
  //}

  run[0] = loadImage("megaman3.png");
  run[1] =loadImage("megaman4.png");
  run[2] =loadImage("megaman5.png");

  runleft[0] = loadImage("megaman5.png");
  runleft[1] = loadImage("megaman4.png");
  runleft[2] = loadImage("megaman3.png");

  idle[0] = loadImage("megaman0.png");
  jump[0] = loadImage("megaman6.png");
  currentAction = idle;

  explosive = loadImage("bomb.png");
  lava = loadImage("lava3.png");
  bomb = null;

  lives = 5;
}


void draw() {
  // image(background, 0, 0, 800, 600);
  if (mode == intro) {
    drawIntro();
  } else if ( mode == playing) {
    background(white);

    pushMatrix();
    translate(-player.getX()+width/2, -player.getY()+width/2);
    //fill(black);
    //ellipse(50,50,50,50);
    collision();

    if (bomb != null) {
      bomb.updateTimer();
      if (bomb.timer == 0) {
        bomb.kaboom();
        world.remove(bomb);
        bomb = null;
      }
    }

    updateplayer();
    updateTerrain();
    updateEnemies();

    world.step();
    world.draw();
    popMatrix();

    drawlives();
    //println(lives);
    drawinventory();
  } else if (mode == pausing) {
    world.draw();
  } else if (mode == gameover) {
    drawGameOver();
  }
}


void setworld() {
  print("? ");
  world = new FWorld(0, 0, 10000, 10000);
  world.setGravity(0, 900);
  
  x = 0;
  y = 0;
  
  while (y < map.height) {
    color c = map.get(x, y);
    if (c == orange ) {
      Goomba b = new Goomba();
      b.setFillColor(orange);
      b.setPosition(x*gridsize, y*gridsize);
      b.setName("goomba");
      world.add(b);
      enemies.add(b);
    } else 
    if (c ==  yellow ) {
      FBox d = new FBox(gridsize, gridsize);
      d.setStatic(true);
      d.setFillColor(yellow);
      d.setStrokeColor(yellow);
      d.setPosition(x*gridsize, y*gridsize);
      d.setName("cloud");
      world.add(d);
      terrain.add(d);
    } else if (c == pink ) {
      Thwomp m = new Thwomp();
      m.setStatic(true);
      m.setFillColor(pink);
      m.setPosition(x*gridsize, y*gridsize);
      m.setName("thwomp");
      world.add(m);
      enemies.add(m);
    } else if (c == black ) {
      HammerThrower e= new HammerThrower();
      e.setStatic(true);
      e.setFillColor(black);
      e.setPosition(x*gridsize, y*gridsize);
      e.setName("ht");
      world.add(e);
      enemies.add(e);
    } else if (c == gold ) {
      player = new FBox(gridsize*0.9, gridsize*0.9);
      player.setName("player");
      player.setPosition(200, 200);
      player.setFillColor(white);
      player.setStatic(false);
      player.setGrabbable(false);
      player.setDensity(1);
      player.setAngularVelocity(0);
      player.setRotatable(false);
      world.add(player);
    } else if (c == grey ) {
      FBox f = new FBox(gridsize, gridsize);
      f.setStatic(true);
      f.setFillColor(grey);
      f.setStrokeColor(grey);
      f.setPosition(x*gridsize, y*gridsize);
      f.setName("bridge");
      world.add(f);
      terrain.add(f);
    } else if (c == beige ) {
      FBox g = new FBox(gridsize, gridsize);
      g.setStatic(true);
      g.setFillColor(beige);
      g.setStrokeColor(beige);
      g.setPosition(x*gridsize, y*gridsize);
      g.setName("spring");
      world.add(g);
      terrain.add(g);
    } else if (c == navyb ) {
      portal1 = new FBox(gridsize, gridsize);
      portal1.setStatic(true);
      portal1.setFillColor(navyb);
      portal1.setPosition(x*gridsize, y*gridsize);
      portal1.setName("portal1");
      world.add(portal1);
      terrain.add(portal1);
    } else if (c == red ) {
      FBox i = new FBox(gridsize, gridsize);
      i.setStatic(true);
      i.setFillColor(red);
      i.setStrokeColor(red);
      i.setPosition(x*gridsize, y*gridsize);
      i.setName("lava");

      world.add(i);
      terrain.add(i);
    } else if (c == brown ) {
      FBox k = new FBox(gridsize, gridsize);
      k.setStatic(true);
      k.setFillColor(brown);
      k.setStrokeColor(brown);
      k.setPosition(x*gridsize, y*gridsize);
      k.setName("tree");
      world.add(k);
      terrain.add(k);
    } else if (c == blue ) {
      portal2 = new FBox(gridsize, gridsize);
      portal2.setStatic(true);
      portal2.setFillColor(blue);
      portal2.setPosition(x*gridsize, y*gridsize);
      portal2.setName("portal2");
      world.add(portal2);
      terrain.add(portal2);
    } else if (c == dbrown ) {
      FBox n = new FBox(gridsize, gridsize);
      n.setStatic(true);
      n.setFillColor(brown);
      n.setPosition(x*gridsize, y*gridsize);
      n.setName("tree");
      world.add(n);
      terrain.add(n);
    } else if ( c == indigo ) {
      FBox l = new FBox(gridsize, gridsize);
      l.setStatic(true);
      l.setFillColor(indigo);
      l.setPosition(x*gridsize, y*gridsize);
      l.setStrokeColor(indigo);
      l.setName("petals");
      world.add(l);
      terrain.add(l);
    } else if (c == purple ) {
      FBox n = new FBox(gridsize, gridsize);
      n.setStatic(true);
      n.setFillColor(purple);
      n.setStrokeColor(purple);
      n.setName("wall");
      n.setPosition(x*gridsize, y*gridsize);
      world.add(n);
      terrain.add(n);
    } else if (c == dgreen ) {
      FBox o = new FBox(gridsize, gridsize);
      o.setStatic(true);
      o.setFillColor(dgreen);
      o.setStrokeColor(dgreen);
      o.setPosition(x*gridsize, y*gridsize);
      o.setName("vine");
      world.add(o);
      terrain.add(o);
    } else if (c == lgreen ) {
      FBox p = new FBox(gridsize, gridsize);
      p.setStatic(true);
      p.setFillColor(lgreen);
      p.setStrokeColor(lgreen);
      p.setPosition(x*gridsize, y*gridsize);
      p.setName("ground");
      world.add(p);
      terrain.add(p);
    } else if (c == lightb ) {
      FBox q = new FBox(gridsize, gridsize);
      q.setStatic(false);
      q.setFillColor(lightb);
      q.setStrokeColor(lightb);
      q.setPosition(x*gridsize, y*gridsize);
      q.setName("crate");
      world.add(q);
      terrain.add(q);
    }
    x++;

    if (x >= map.width) {
      x = 0;
      y++;
    }
  }
}

void drawlives() {
  textSize(28);

  text("Lives: ", 20, 20);
  for (int i = 0; i<lives; i++) {
    fill(black);
    ellipse(120+40*i, 20, 20, 20);
  }
}

void drawinventory() {
  fill(0, 0, 0, 50);
  rect(0, 200, 80, 400);

  for (int i = 250; i< 600; i = i+ 50) {
    stroke(black);
    strokeWeight(5);
    line(5, i, 75, i);
  }

  textSize(24);
  fill(yellow);
  rect(30, 210, 40, 40);
  fill(white);
  text(Ccloud/2, 10, 230);

  fill(purple);
  rect(30, 260, 40, 40);
  fill(white);
  text(Cpetal/2, 10, 280);

  fill(indigo);
  rect(30, 310, 40, 40);
  fill(white);
  text(Cwall/2, 10, 330);

  fill(lightb);
  rect(30, 360, 40, 40);
  fill(white);
  text(Ccrate/2, 10, 380);

  fill(brown);
  rect(30, 410, 40, 40);
  fill(white);
  text(Ctree/2, 10, 430);

  fill(dgreen);
  rect(30, 460, 40, 40);
  fill(white);
  text(Cvine/2, 10, 480);

  fill(lgreen);
  rect(30, 510, 40, 40);
  fill(white);
  text(Cground/2, 10, 530);
}