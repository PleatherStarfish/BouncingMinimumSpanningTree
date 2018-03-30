// Modified from tutorial by Daniel Shiffman
// Code for https://www.youtube.com/watch?v=BxabnKrOjT0

// "Bouncing" vertices effect added by Daniel Miller

ArrayList<PVector> vertices = new ArrayList<PVector>();

ArrayList<PVector> keepList1 = new ArrayList<PVector>();
ArrayList<PVector> keepList2 = new ArrayList<PVector>();

ArrayList<PVector> xspeed = new ArrayList<PVector>();
ArrayList<PVector> yspeed = new ArrayList<PVector>();
ArrayList<PVector> xdirection = new ArrayList<PVector>();
ArrayList<PVector> ydirection = new ArrayList<PVector>();

void setup() {
  size(1000, 600);
  
    
  PVector v;
  PVector x1;
  PVector y1;
  PVector x2;
  PVector y2;
  PVector xc;
  
  for (int i = 0; i < 200; i++) {
    v = new PVector(random(width/2)+random(-50, 100), random(height/2)+random(-50, 100));
    vertices.add(v);
  }
  for (int i = 200; i < 350; i++) {
    v = new PVector(random((width/2)+(width/2)), random((height/2)+(height/2)));
    vertices.add(v);
  }
  
  
  for (int i = 0; i < 350; i++) {
  x1 = new PVector(random(.01, .3), 0);
  xspeed.add(x1);
  }
  for (int i = 0; i < 350; i++) {
    y1 = new PVector(random(.01, .3), 0);
    yspeed.add(y1);
  }
  for (int i = 0; i < 350; i++) {
    x2 = new PVector(random(-1, 1), 0);
    xdirection.add(x2);
  }
  for (int i = 0; i < 350; i++) {
    y2 = new PVector(random(-1, 1), 0);
    ydirection.add(y2);
  }
  

}

void draw() {

  background(255);

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();
  
  ArrayList<PVector> reachedKeep = new ArrayList<PVector>();

  for (PVector v : vertices) {
    unreached.add(v);
  }

  reached.add(unreached.get(0));
  unreached.remove(0);
  
if (random(0, 1000) < 2) {
  keepList1.clear();
  keepList2.clear();
  while (unreached.size() > 0) {
    float record = 100000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      for (int j = 0; j < unreached.size(); j++) {
        PVector v1 = reached.get(i);
        PVector v2 = unreached.get(j);
        float d = dist(v1.x, v1.y, v2.x, v2.y);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }
    stroke(0);
    strokeWeight(1);
    PVector p1 = reached.get(rIndex);
    PVector p2 = unreached.get(uIndex);
    line(p1.x, p1.y, p2.x, p2.y);
    reached.add(p2);
    unreached.remove(uIndex);
    keepList1.add(p1);
    keepList2.add(p2);
    }
  }
else {
    for (int i = 0; i < keepList1.size(); i++) {
        stroke(0);
        strokeWeight(1);
        line(keepList1.get(i).x, keepList1.get(i).y, keepList2.get(i).x, keepList2.get(i).y);
    }
  }


  for (PVector v : vertices) {
    fill(0);
    stroke(10);
    ellipse(v.x, v.y, 4, 4);
  }
  
  
  for (int i = 0; i < keepList1.size(); i++) {
      keepList1.get(i).x = keepList1.get(i).x + (xdirection.get(i).x * (xspeed.get(i).x));
      keepList1.get(i).y = keepList1.get(i).y + (ydirection.get(i).x * (yspeed.get(i).x));
  }
    
  for (int i = 0; i < keepList1.size(); i++) {
      for (int j = 0; j < keepList1.size(); j++) {
          if (i!=j) {
              if (
                 (round(dist(keepList1.get(j).x, keepList1.get(j).y, keepList1.get(i).x, keepList1.get(i).y)))
                 + (round(dist(keepList2.get(j).x, keepList2.get(j).y, keepList1.get(i).x, keepList1.get(i).y))) 
                 == (round(dist(keepList1.get(j).x, keepList1.get(j).y, keepList2.get(j).x, keepList2.get(j).y)))
                 ) 
              {
                   xdirection.get(i).x *= -1;
                   ydirection.get(i).x *= -1;
              }
           }
        }
    }
}
