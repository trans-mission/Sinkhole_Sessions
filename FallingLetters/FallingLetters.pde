import controlP5.*;
PFont f;
ControlP5 cp5;

ArrayList<String> numbers = new ArrayList<String>();

class Word {
  String txt;
  PVector pos;
  
  void Word(PVector p, String s) {
    pos = p.copy();
    txt = String.valueOf(s);
  }
}

int spacing = 10;
char[] word_abc = {'A', 'B', 'C'};

PVector v = new PVector(10.0, 20.0, 30.0);
float[] f = v.array();

void setup() {
  //size(960, 580);
    
  fullScreen();
  background(0);
  
  // Spacing
  cp5.addSlider("spacing")
     .setPosition(100,50)
     .setRange(0,255)
     ;

  // Create the font
  printArray(PFont.list());
  f = createFont("SourceCodePro-Regular.ttf", 58);
  textFont(f);
  textAlign(CENTER, CENTER);
  
  
  //
  int sliderValue = 100;
} 

void draw() {
    
  background(0);

  // Set the left and top margin
  int margin = 10;
  translate(margin*4, margin*4);

  int gap = 10;
  int counter = 35;
  
  for (int y = 0; y < height-gap; y += gap) {
    for (int x = 0; x < width-gap; x += gap) {

      char letter = char(counter);
      
      if (letter == 'A' || letter == 'E' || letter == 'I' || letter == 'O' || letter == 'U') {
        fill(255, 204, 0);
      } 
      else {
        fill(255);
      }

      // Draw the letter to the screen
      text(letter, x, y);

      // Increment the counter
      counter++;
    }
  }
}
