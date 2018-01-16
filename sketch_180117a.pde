import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import ddf.minim.*; 

Minim minim;
AudioPlayer player;
Capture cam;
OpenCV opencv;
Rectangle[] faces;

PImage img;
PImage man;
PImage bman;
PImage jun;
PImage nyanko;
int NUM =20;
int deg =0;
int t = 0;
int ms;
float locationX = 800;
float x = 0;
float y = 0;
PVector[] location = new PVector[100];
PVector[] velocity = new PVector[100];

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();

  for (int i=0; i<cameras.length; i++) {
    println("[" + i + "] " + cameras[i]);
  }
  cam = new Capture(this, cameras[3]);
  cam.start();
  minim = new Minim(this); 
  player = minim.loadFile("sakuranbo.mp3");
  player.play(); 
  img = loadImage("yukichi.png");
  man = loadImage("10000.jpg");
  bman = loadImage("10000b.jpg");
  jun = loadImage("jun.png");
  nyanko = loadImage("nyanko.png");
}

void draw() {
  ms=millis()/100;
  print (ms);
  if (cam.available() == true) {
    cam.read();
    scale(2);
    image(cam, 0, 0);

    opencv = new OpenCV(this, cam);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    faces = opencv.detect();
    if ((ms > 381 && ms < 607 ) || (ms > 855 && ms < 1077) || (ms >1294 && ms<1461)) {
      deg= deg +10;
      for (int i=0; i<faces.length; i++) {
        pushMatrix();
        translate( faces[i].x  + faces[i].width/2, faces[i].y + faces[i].height/2 );
        rotate(radians( deg ));
        imageMode(CENTER); 
        image(img, 0, 0, faces[i].width, faces[i].height);
        popMatrix();
        imageMode(CORNER);
      }
    } else if (ms >1150 && ms < 1294) {
      for (int i=0; i<faces.length; i++) {
        deg= deg +10;
        pushMatrix();
        translate( faces[i].x  + faces[i].width/2, faces[i].y + faces[i].height/2 );
        rotate(radians( deg ));
        imageMode(CENTER); 
        image(jun, 0, 0, faces[i].width, faces[i].height);
        popMatrix();
        imageMode(CORNER);
      }
    } else if (ms > 1480) {
      for (int i=0; i<faces.length; i++) {
        deg= deg +10;
        pushMatrix();
        translate( faces[i].x  + faces[i].width/2, faces[i].y + faces[i].height/2 );
        rotate(radians( 0));
        imageMode(CENTER); 
        image(nyanko, 0, 0, faces[i].width*1.5, faces[i].height*1.5 );
        image(img, 0, 0, faces[i].width, faces[i].height);
        popMatrix();
        imageMode(CORNER);
      }
    } else {
      for (int i=0; i<faces.length; i++) {
        pushMatrix();
        translate( faces[i].x  + faces[i].width/2, faces[i].y + faces[i].height/2 );
        rotate(radians( 0 ));
        imageMode(CENTER); 
        image(img, 0, 0, faces[i].width, faces[i].height);
        popMatrix();
        imageMode(CORNER);
      }
    }
    if (ms > 193 && ms < 305 || ms > 663 && ms <772) { 
      for (int m = 0; m < NUM; m++) { 
        if (location[m] == null||location[m].y > 400) {
          location[m] = new PVector(random(width), 0);
          velocity[m] = new PVector(0, random(5, 20));
        }
      }
      for (int m = 0; m < NUM; m++) {
        image(man, location[m].x, location[m].y);
        location[m].add(velocity[m]);
      }
    } else if ( ms > 305 && ms < 381 || ms > 772 && ms < 845) {
      for (int m = 0; m < 100; m++) { 
        if (location[m] == null||location[m].y > 400) {
          location[m] = new PVector(random(width), 0);
          velocity[m] = new PVector(0, random(50, 100));
        }
      }
      for (int m = 0; m < 100; m++) {
        image(man, location[m].x, location[m].y);
        location[m].add(velocity[m]);
      }
    } else if (ms > 1050 && ms < 1171) {
      image(bman, locationX, 0);
      locationX = locationX -20;
    }
  }
}