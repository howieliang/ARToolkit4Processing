import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
PImage img;

color colors[] = {
  color(155, 89, 182), color(63, 195, 128), color(214, 69, 65), 
  color(82, 179, 217), color(244, 208, 63), color(242, 121, 53), 
  color(0, 121, 53), color(128, 128, 0), color(52, 0, 128), 
  color(128, 52, 0), color(52, 128, 0), color(128, 52, 0)
};


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
    
    fill(colors[0], 100);
    rect(-120, -120, 80, 80);
    fill(colors[1], 100);
    rect(-40, -120, 80, 80);
    fill(colors[2], 100);
    rect(40, -120, 80, 80);
    
    fill(colors[3], 100);
    rect(-120, -40, 80, 80);
    fill(colors[4], 100);
    rect(-40, -40, 80, 80);
    fill(colors[5], 100);
    rect(40, -40, 80, 80);
    
    fill(colors[6], 100);
    rect(-120, 40, 80, 80);
    fill(colors[7], 100);
    rect(-40, 40, 80, 80);
    fill(colors[8], 100);
    rect(40, 40, 80, 80);
    
    stroke(255, 255, 0);
    noFill();
    ellipse((int)p.x, (int)p.y, 20-c%20, 20-c%20);
    
    nya.endTransform();
    
    float x = p.x/80.+1;
    float y = p.y/80.+1;
    println(p.x,p.y, x, y);
    if(x<=2.5 && x>=-0.5 && y<=2.5 && y>=-0.5){
      fill(colors[round(x)+round(y)*3]);
      rect(500,20,120,120);
    }
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