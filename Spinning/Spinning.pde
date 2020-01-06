// SINKHOLE SESSIONS (2020.01.05

// OSC RECEIVE


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


// CONTROLLER PARAMS
float xOff = 0;
float rectSize = 0;


PVector imgPos;

// IMAGES
PImage img1;  // Declare variable "a" of type PImage
PImage imgFall;
PVector fallPos;
float dropSpeed;

int t = 0;

int w  = 800;
int h  = 450;
int bg = 255;

PVector bzCtlPt1, bzCtlPt2, bzPt1, bzPt2;

// BUBBLES --------------------------------------------------------------
float zDist = 5, zmin = -650, zmax = 800, zstep = 1.8, rad = 200;
int nb = int((zmax - zmin) / zDist);
PVector[] circles = new PVector[nb];
color[] bubbleColors = new color[nb];
Boolean bnw = true, dots = false;
// ----------------------------------------------------------------------

color[] colors = {
  color(0, 0, 0), // #000000 (black)
  color(232, 10, 137), // #e90e8b (pink)
  color(90, 193, 169), // No.2 - #00E7BA (green)
  color(238, 63, 34), // No.3 - (red)
  color(34, 86, 162) // no.4 (blue)
};

void settings() {

  //size(w, h);
  fullScreen(P3D);
}
float a1 = 0;
float inc1 = 0;
float r1 = 100;

float a2 = PI;
float inc2 = PI/2;
float r2 = 50;



void setup() {

  frameRate(30);
  
  bzPt1 = new PVector(0, height/2);
  bzPt2 = new PVector(width, height/2);
  bzCtlPt1 = new PVector(width/2 - 100, height/2);
  bzCtlPt2 = new PVector(width/2 + 100, height/2);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,7879 );
  
  
  img1 = loadImage("images/devils_den.jpg");  // Load the image into the program  
  imgPos = new PVector(width/2, height/2);
  
  imgFall = loadImage("images/falling.jpg");
  fallPos = new PVector(0,0);
  
  rectMode(CENTER);
 
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
}
Boolean falling = false;
Boolean hasOscEvent = false;

void draw() {
  
  background(0);
  
  ////smooth();
  ////background(255,.3);
  colorMode(RGB, 100);
  fill(237, 55, 120, 6.5);
  rectMode(CORNER);
  rect(0, 0, width, height);
  
  ////image(img1, 0, 0);
  inc1+=0.1;
  inc2+=0.1;
  
  //int line_y = (int)random(height);
  //stroke(146, 215,229);
  //strokeWeight(1);
  //noFill();
  //line(0,line_y, width,line_y);
  
 
  // </END MASK IMAGE>
  
  // MASK IMAGE
  // --------------------------
  PGraphics maskImage;
  maskImage = createGraphics(img1.width, img1.height, JAVA2D);
  maskImage.beginDraw();
  maskImage.pushMatrix();
  maskImage.rectMode(CENTER);
  maskImage.translate(img1.width/2, img1.height/2); //start at center point
  
  maskImage.rotate(inc1);  
  maskImage.fill(255);
  maskImage.noStroke();
  maskImage.ellipse(0, 0, rectSize*2*noise(t*2), rectSize*2 * noise(t*2));
  t++;
  maskImage.popMatrix();
  maskImage.endDraw(); 
  
  
  //PImage imgCopy = img1; // if the mask changes every frame, we need to use a copy of it, keeping the original intact
  //imgCopy.mask(maskImage);// apply the mask to  image
  //image(imgCopy, 0, 0);
  pushMatrix();
  PImage imgCopy = img1;
  imgCopy.mask(maskImage);// apply the mask to  image
  image(imgCopy,imgPos.x, height/2 - imgCopy.height/2, imgCopy.width, imgCopy.height);
  popMatrix();

  
  pushMatrix();
  translate(xOff, height/2); //start at center point
  rectMode(CENTER);
  rotate(inc2);  
  rotate(90);
  
  
 
  
  
  stroke(colors[2]);
  strokeWeight(10);
  noFill();
  
  // DRAW LINES
  //rect(0, 0, r1 * 2, rectSize);
  //ellipse(0,0,rectSize, rectSize);
  
  
  ////ellipse(0, 0, 100, 100);
  int amt = 2;
  float lastX = 0;
  float lastY = 0;
  for (int i = 0; i < amt; i++) {
    float x1 = lastX + cos(a1 + inc1) * (r1-60);
    float y1 = lastY + sin(a1 + inc1) * (r1-60);
    float x2 = lastX + sin(a2 + inc1) * (r1-10);
    float y2 = lastY + sin(a2 + inc1) * (r1-10);

    pushMatrix();

    if (i % 2 == 0) { // even
      stroke(255);
      //ellipse(-x1, -y1, height/2, height/2);
     
    } else { // if odd
      translate(x1, y1);
      lastX = y1;
      lastY = x1;
    }

    popMatrix();
  }

  float orbit_x1 = cos(a1 + inc2) * r1 * 2;
  float orbit_y1 = sin(a1 + inc2) * r1 * 2;
  float orbit_x2 = cos(a2 + inc2) * r1 * 2;
  float orbit_y2 = sin(a2 + inc2) * r1 * 2;
  
  fill(255);
  noStroke();
  //ellipse(orbit_x1, orbit_y1, 20, 20);
  //ellipse(orbit_x2, orbit_y2, 20, 20);
  //ellipse(orbit_y1, orbit_x1, 20, 20);
  //ellipse(orbit_y2, orbit_x2, 20, 20);
  
  popMatrix();
  
  


  //pushMatrix();
  ////drawColorSwatches();
  //noFill();
  //stroke(colors[2]);
  //strokeWeight(bzCtlPt2.y*.02);
  //strokeCap(SQUARE);
  ////translate(width/2, height/2);
  //bezier(
  //bzPt1.x, 
  //bzPt1.y, 
  //bzCtlPt1.x, 
  //bzCtlPt1.y,
  //bzCtlPt2.x,
  //bzCtlPt2.y,
  //bzPt2.x,
  //bzPt2.y
  //);
  //bezier(
  //bzPt1.x, 
  //bzPt1.y, 
  //bzCtlPt1.x, 
  //height - bzCtlPt1.y * 2,
  //bzCtlPt2.x,
  //height - bzCtlPt2.y * 2,
  //bzPt2.x,
  //bzPt2.y
  //);
  //popMatrix();
  
  // FALLING LEMMING
  if(falling) {
    rectMode(CENTER);
    image(imgFall, fallPos.x, fallPos.y);
    fallPos.y+=dropSpeed;
  }
  
  // DRAW BUBBLE TUNNEL
  drawBubbles();
  
  
}

void drawFrame() {
  rectMode(CENTER);
  fill(255);
  noStroke();
  rect(w/2, 0, w, 10); //top
  rect(w/2, h, w, 10); //bottom
  rect(0, h/2, 10, h);
  rect(w, h/2, 10, h);
}

void drawColorSwatches() {
  for (int i = 0; i < colors.length; i++) {
    noStroke();
    fill(colors[i]);
    rect(i * 61.55 + (61.55/2), height-10, 61.55, 20);
  }
}

void drawBubbles() {
 
  noFill();
  strokeWeight(1);
  colorMode(HSB);
  for (int i = 0; i < nb; i++) {
    circles[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin));
    bubbleColors[i] = color(random(110, 255), 0, random(60, 150));
    bubbleColors[i] = color(random(220, 255), 255, 255);
  }
  
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
  
 

void oscEvent(OscMessage msg) {
  
  float value;
  
  // FLOAT VALUES
  if(msg.checkTypetag("f")) {
    
    value = msg.get(0).floatValue();
    switch(msg.addrPattern()) {
      
     case "/osc1":
       value -= .5; // offset by .5 (range -0.5 to 0.5)
       value *= 2;  // scale by 2 (range -1 to 1)
       xOff = width/2 + (value * 1000);
       break;
     case "/osc2":
       rectSize = value * 1000;
       break; 
       
     case "/osc7":
       bzCtlPt1.y = height/2 + (value * 1000);
       bzCtlPt2.y = height/2 + (value * 1000);
       
       value -= .5; // offset by .5 (range -0.5 to 0.5)
       value *= 2;  // scale by 2 (range -1 to 1)
       bzPt1.x = width/2 - (value * 1000);
       bzPt2.x = width/2 + (value * 1000);
       break; 
       
     case "/osc8":
       imgPos.x = map(value,0,1,-width/2,width/2);
       
       break;
    }
    
  } else {
    
    value = msg.get(0).intValue();
    
    switch(msg.addrPattern()) {
      
     case "/btn1":
       println("BUTTON PRESSED");
       falling = true;
       fallPos.y = -500;
       fallPos.x = random(100 + (width-500) );
       dropSpeed = random(10, 50);
       break;
       
     case "/btn2":
       break;
    }
    
  }
      

   //float OSCvalue = theOscMessage.get(0).floatValue(); 
}
