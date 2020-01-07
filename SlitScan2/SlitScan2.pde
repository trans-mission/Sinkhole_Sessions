  
import processing.video.*;

Capture cam;

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

boolean b_newFrame  = false;  // fresh-frame flag

void draw() {
  if (cam.available() == true) {
    cam.read();

    loadPixels(); 
    
    int slice_mask = (width*height/2)-width; //Subtracts everything above the middle row of pixels from the selection
    for (int i = slice_mask; i < (width*height)/2; i++) { //For each individual pixel in the middle row of pixels in the video
      int sliceDestination = i - slice_mask; //Pixels  will copied to the top row of the canvas
      int sliceSource = i; //Pixels will be copied from the center row of the video
      pixels[sliceDestination] = cam.pixels[sliceSource]; //Copy the center row of the video to the top of the canvas
    }
    arrayCopy(pixels, 0, pixels, width, (height - 1) * width); //Move everything down one row to make room for new frames of video
    updatePixels();
  }
  //image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
