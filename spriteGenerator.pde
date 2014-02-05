import java.io.*;

PGraphics canvas;
String folderPath; 




int max_width = 8192;
int max_height = 8192;

int image_width = 640;
int image_height = 960;

int startImage = 435;
int endImage = 481;
int totalImages = (endImage-startImage)/2;

int xPositions = max_width/image_width;
int yPositions = (totalImages/xPositions)+1;

int counter = startImage;

JSONArray coordinates = new JSONArray();

void setup() {
  
  selectFolder("Select a folder to process:", "folderSelected");
  canvas = createGraphics(xPositions*image_width, yPositions*image_height);
  //drawImage(canvas);
  //println(coordinates);
  //saveJSONArray(coordinates, "output/" +image_width+"x"+image_height + ".json");
  
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath();
    drawImage();
    //canvas.save(image_width+"_"+image_height+"Step_02 .png");
  }
}

void drawImage() {
  int xPosition = 0;
  int yPosition = 0;
  
  for (int i = 0; i <= totalImages; i++) {
   
    yPosition = (i/xPositions)*image_height;
    xPosition = (i%xPositions)*image_width;
    addImage(xPosition, yPosition);
    addJSON(xPosition, yPosition, i);
    counter+=2;
   
  }
 
  
}

void addImage(int xImage, int yImage) {
  
        PImage img;
        int numberImage = counter;
        if (counter < 10) {
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_0000"+numberImage+".png");
        
        println("Adding" + image_width+"x"+image_height+"_Full_Render_0000"+numberImage+".png"); 
        }
        else if (counter < 100) {
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_000"+numberImage+".png");
        println("Adding" + image_width+"x"+image_height+"_Full_Render_000"+numberImage+".png"); 
        }
        else {
         
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_00"+numberImage+".png");
        println(img.width);
        println("Adding" + image_width+"x"+image_height+"_Full_Render_00"+numberImage+".png"); 
        }
        canvas.beginDraw();
        canvas.pushMatrix();
        canvas.translate(xImage, yImage);
        canvas.image(img, 0, 0);
        canvas.popMatrix();
        canvas.endDraw();
}

void addJSON(int xJSON, int yJSON, int counter) {
  
    JSONArray tempCoordinates = new JSONArray();
    tempCoordinates = new JSONArray();
    tempCoordinates.setInt(0, xJSON);
    tempCoordinates.setInt(1, yJSON);
    coordinates.setJSONArray(counter, tempCoordinates);

}

void getImageSize() {
  
}


