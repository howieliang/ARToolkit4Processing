import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
PImage img;

void setup() {
  size(640,480,P3D);
  println(MultiMarker.VERSION);  
  cam=new Capture(this,640,480);
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);//id=0
  nya.addARMarker("patt.kanji",80);//id=1
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
  
  for(int i=0;i<2;i++){
    if((!nya.isExistMarker(i))){
      continue;
    }
    nya.beginTransform(i);
    fill(0,255*(i%2),255*((i+1)%2));
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