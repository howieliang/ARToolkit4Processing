import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
PImage img;

void setup() {
  size(640, 480, P3D);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro", 80);//id=0
  cam.start();
}

int c=0;
void draw()
{
  c++;
  background(0);
  img=vFlipImage(cam.copy());
  nya.detect(img);
  pushMatrix();
  image(img, 0, 0);
  popMatrix();

  if ((!nya.isExistMarker(0))) {
    //do nothing
  } else {
    PVector p=nya.screen2MarkerCoordSystem(0, mouseX, mouseY);
    nya.beginTransform(0);
    
    fill(255, 0, 0, 100);
    rect(-40, -40, 80, 80);
    stroke(255, 255, 0);
    ellipse((int)p.x, (int)p.y, 20-c%20, 20-c%20);
    println(p.x,p.y);
    nya.endTransform();
  }
}

void captureEvent(Capture cam) {
  cam.read();
}

PImage vFlipImage(PImage img) {
  PImage flipped = createImage(img.width, img.height, RGB);//create a new image with the same dimensions
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      flipped.set(img.width-x-1, y, img.get(x, y));
    }
  }
  return flipped;
}