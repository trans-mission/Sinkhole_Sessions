float zDist = 100, zmin = -650, zmax = 250, zstep = 3.8, rad = 400;
int nb = int((zmax - zmin) / zDist);
PVector[] circles = new PVector[nb];
color[] colors = new color[nb];
Boolean bnw = true, dots = false;

void setup() {
  //size(600, 400, P3D);
  fullScreen(P3D);
  noFill();
  strokeWeight(10);
  colorMode(HSB);
  for (int i = 0; i < nb; i++) {
    circles[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin));
    colors[i] = color(random(110, 255), 0, random(60, 150));
    colors[i] = color(random(220, 255), 255, 255);
  }
}

void draw() {
  background(0);
  //fill(237, 55, 120, 6.5);
  //rectMode(CORNER);
  //rect(0, 0, width, height);
  
  translate(width/2, height/2);
  PVector pv;
  float fc = (float)frameCount, a;
  if (dots) beginShape(POINTS); 

  for (int i = 0; i < nb; i++) {
    pv = circles[i];
    pv.z += zstep;
    pv.x = (noise((fc*2 + pv.z) / 550) - .5) * height * map(pv.z, zmin, zmax, 6, 0);
    pv.y = (noise((fc*2 - 3000 - pv.z) / 550) - .5) * height * map(pv.z, zmin, zmax, 6, 0);

    a = map(pv.z, zmin, zmax, 0, 255);
    if (!bnw)stroke(colors[i], a);
    else stroke(map(pv.z, zmin, zmax, 0, 255), a);
    float r = map(pv.z, zmin, zmax, rad*.1, rad);

    if (dots) {
      float jmax = r;
      for (int j  = 0; j < jmax; j++)
      {
        vertex(pv.x + r*cos(j*TWO_PI/jmax + fc/40)/2, pv.y + r*sin(j*TWO_PI/jmax + fc/40)/2, pv.z);
      }
    } else {
      pushMatrix();
      translate(pv.x, pv.y, pv.z);
      ellipse(0, 0, r, r);
      popMatrix();
    }

    if (pv.z > zmax) {
      circles[i].z = zmin;
    }
  }
  if (dots) endShape();
}

void keyPressed(){dots = !dots;}
void mousePressed(){bnw = !bnw;}
