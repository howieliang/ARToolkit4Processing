import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya_r;
MultiMarker nya_l;
PImage img;

void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this,640,480);
  nya_l=new MultiMarker(this,width,height,"camera_para.dat",new NyAR4PsgConfig(NyAR4PsgConfig.CS_LEFT_HAND,NyAR4PsgConfig.TM_NYARTK));
  nya_l.addARMarker("patt.hiro",80);
  
  nya_r=new MultiMarker(this,width,height,"camera_para.dat",new NyAR4PsgConfig(NyAR4PsgConfig.CS_LEFT_HAND,NyAR4PsgConfig.TM_NYARTK));
  //nya_r=new MultiMarker(this,width,height,"camera_para.dat",new NyAR4PsgConfig(NyAR4PsgConfig.CS_RIGHT_HAND,NyAR4PsgConfig.TM_NYARTK));
  nya_r.addARMarker("patt.kanji",80);
  cam.start();
}

int c=0;

void draw()
{
  background(0);
  c++;
  img=vFlipImage(cam.copy());
  nya_r.detect(img);
  nya_l.detect(img);
  
  pushMatrix();
  image(img, 0, 0);
  popMatrix();
  
  //right
  if((nya_r.isExistMarker(0))){
    nya_r.beginTransform(0);
    fill(0,0,255);
    drawgrid();
    translate(0,0,20);
    rotate((float)c/100);
    box(40);
    nya_r.endTransform();
  }
  //left
  if((nya_l.isExistMarker(0))){
    nya_l.beginTransform(0);
    fill(0,255,0);
    drawgrid();
    translate(0,0,20);
    rotate((float)c/100);
    box(40);
    nya_l.endTransform();
  }
}

void captureEvent(Capture cam) {
  cam.read();
}

void drawgrid()
{
  pushMatrix();
  stroke(0);
  strokeWeight(2);
  line(0,0,0,100,0,0); 
  text("X",100,0,0);
  line(0,0,0,0,100,0); 
  text("Y",0,100,0);
  line(0,0,0,0,0,100);
  text("Z",0,0,100);
  popMatrix();
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