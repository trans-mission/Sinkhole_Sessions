float zDist = 1, zmin = -600, zmax = 100, zstep = .1, rad = 600;
int nb = int((zmax - zmin) / zDist);
PVector[] circles = new PVector[nb];
color[] colors = new color[nb];
Boolean bnw = true, dots = false;

// IMAGE OF HEAD
PImage img;
PVector imgPos;
void setup() {
  //size(600, 400, P3D);
  fullScreen(P3D);
  noFill();
  strokeWeight(100);
  colorMode(HSB);
  for (int i = 0; i < nb; i++) {
    circles[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin));
    colors[i] = color(145,213,227);
    colors[i] = color(145,213,227);
  }
  
  img = loadImage("head_4.png");  // Load the image into the program  
  //img = loadImage("eyes.png");
  //img.resize(1800, 1800);
  imgPos = new PVector(width/2, height/2);
 
   noCursor();
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
      
      // Draw Head
      
      imgPos.x = pv.x;
      imgPos.y = pv.y;
      imgPos.z = pv.z;
      
    }
  }
  if (dots) endShape();
  
  //pushMatrix();
  //translate(imgPos.x, imgPos.y);
  //beginShape();
  //texture(imgHead);
  //int scl = 100;
  //vertex(-scl, -scl, 0, 0,   0);
  //vertex( scl, -scl, 0, scl, 0);
  //vertex( scl,  scl, 0, scl, scl);
  //vertex(-scl,  scl, 0, 0,   scl);
  //endShape();
  //popMatrix();
  pushMatrix();
  noStroke();
  //background(0);
  //translate(0, 0,0);
  translate(imgPos.x, imgPos.y, 100);
  //rotateY(map(mouseX, 0, width, -PI, PI));
  //rotateZ(PI/6);
  scale(8);
  beginShape();
  //tint(255, 100);
  texture(img);
  vertex(-100, -100, 0, 0, 0);
  vertex(100, -100, 0, img.width, 0);
  vertex(100, 100, 0, img.width, img.height);
  vertex(-100, 100, 0, 0, img.height);
  endShape();
  popMatrix();

}

void keyPressed(){dots = !dots;}
void mousePressed(){bnw = !bnw;}
