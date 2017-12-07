import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
PImage img;

int markerSize = 40;

color colors[] = {
  color(155, 89, 182), color(63, 195, 128), color(214, 69, 65), 
  color(82, 179, 217), color(244, 208, 63), color(242, 121, 53), 
  color(0, 121, 53), color(128, 128, 0), color(52, 0, 128), 
  color(128, 52, 0), color(52, 128, 0), color(128, 52, 0)
};

void setup() {
  size(640,480,P3D);
  println(MultiMarker.VERSION);
  cam=new Capture(this,640,480);
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  //nya.addARMarker("patt.hiro",80);//id=0
  //nya.addARMarker("patt.kanji",80);//id=1
  nya.addNyIdMarker(0,markerSize);
  nya.addNyIdMarker(1,markerSize);
  nya.addNyIdMarker(2,markerSize);
  nya.addNyIdMarker(3,markerSize);
  nya.addNyIdMarker(4,markerSize);
  nya.addNyIdMarker(5,markerSize);
  nya.addNyIdMarker(6,markerSize);
  nya.addNyIdMarker(7,markerSize);
  nya.addNyIdMarker(8,markerSize);
  nya.addNyIdMarker(9,markerSize);
  cam.start();
}

void draw()
{
  background(0);
  img=vFlipImage(cam.copy());
  nya.detect(img);
  pushMatrix();
  image(img, 0, 0);
  popMatrix();
  for(int i=0;i<10;i++){
    if((!nya.isExistMarker(i))){
      continue;
    }
    nya.beginTransform(i);
    fill(colors[i]);
    stroke(255);
    translate(0,0,20);
    box(40);
    nya.endTransform();
  }
}
void captureEvent(Capture cam) {
  cam.read();
}

PImage vFlipImage(PImage img){
  PImage flipped = createImage(img.width, img.height, RGB);//create a new image with the same dimensions
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      flipped.set(img.width-x-1, y, img.get(x, y));
    }
  }
  return flipped;
}