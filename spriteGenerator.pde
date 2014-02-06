import java.io.*;

ArrayList<PGraphics> canvas = new ArrayList<PGraphics>();
String folderPath; 

ArrayList<File> subDirectories;    //List of sub directories

String[] images;

int max_width = 8192;
int max_height = 8192;

int image_width = 0;
int image_height = 0;

int numSequences = 8;
int sequence;

int startImage, endImage, totalImages;

int xPositions, yPositions;

int counter = startImage;

JSONArray coordinates = new JSONArray();

void setup() {
  
  selectFolder("Select a folder to process:", "folderSelected");
  //saveJSONArray(coordinates, "output/" +image_width+"x"+image_height + ".json");
  
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());    
    drawCanvases(selection);

  }
}

//Generate list of sub-directories
ArrayList<File> findSubDirectories(File dir)
{
   File[] files=dir.listFiles();
  ArrayList<File> directories = new ArrayList<File>();
  for (int x=0;x<files.length;++x)
  {
    if (files[x].isDirectory()) {
      directories.add(files[x]);
    }
  }

    return directories;
  
}

//For loop that generates all the canvases
void drawCanvases(File selection) {
    int canvasCounter = 0;
    subDirectories = findSubDirectories(selection);
    for (int i = 0; i < subDirectories.size(); i++) {   
      images=getWidthHeight(subDirectories.get(i));
      for (int j = 0; j < numSequences; j++) {
      sequence = j+1;
      selectSequence(sequence);
      totalImages = (endImage-startImage)/2;
      xPositions = max_width/image_width;
      yPositions = (totalImages/xPositions)+1;
      canvas.add(createGraphics(xPositions*image_width, yPositions*image_height));
      println("Rendering sprite for " + folderPath);
      drawImage(canvas.get(0));
      canvas.remove(0);
      canvasCounter++;
      float totalRenders = subDirectories.size()*numSequences;
      float sequencesRenderedPercentage = (float(canvasCounter)/(subDirectories.size()*(float(numSequences))))*100;
      println(canvasCounter + " of " + totalRenders + " (" + sequencesRenderedPercentage + "%) sprites have been rendered");

    }
  }
  println("DONE");
   
}

//Find width & height of images in a directory
String[] getWidthHeight(File selection) {
  // set target folder
  String path = selection.getAbsolutePath();
  folderPath = path;
  java.io.File folder = new java.io.File(path);
 
  // set filter (which returns true if file's extension is .png)
  java.io.FilenameFilter pngFilter = new java.io.FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".png");
    }
  };
  
  // list files in target folder, passing the filter as parameter
  String[] filenames = folder.list(pngFilter);
  
  PImage resolution = loadImage(path+"/"+filenames[0]);
  image_height = resolution.height;
  image_width = resolution.width;
  return filenames;
  
}

void drawImage(PGraphics spriteCanvas) {
  int xPosition = 0;
  int yPosition = 0;
  
  counter = startImage;
  for (int i = 0; i <= totalImages; i++) {
    yPosition = (i/xPositions)*image_height;
    xPosition = (i%xPositions)*image_width;
    addImage(xPosition, yPosition, spriteCanvas);
    addJSON(xPosition, yPosition, i);
    
    counter+=2;
  }
      println("Saving " + image_width+"_"+image_height+"_Sequence_"+sequence+".png");
      //spriteCanvas.save("output/"+ image_width+"_"+image_height+"_Sequence_"+sequence+".png");
      println("Saved");
  
}

void addImage(int xImage, int yImage, PGraphics canvas) {
  
        PImage img;
        int numberImage = counter;
        if (counter < 10) {
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_0000"+numberImage+".png");
        
        println("Adding " + image_width+"x"+image_height+"_Full_Render_0000"+numberImage+".png"); 
        }
        else if (counter < 100) {
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_000"+numberImage+".png");
        println("Adding " + image_width+"x"+image_height+"_Full_Render_000"+numberImage+".png"); 
        }
        else {
         
        img = loadImage(folderPath+"/"+image_width+"x"+image_height+"_Full_Render_00"+numberImage+".png");
        println("Adding " + image_width+"x"+image_height+"_Full_Render_00"+numberImage+".png"); 
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

void selectSequence(int sequence) {
 
   switch(sequence) {
    
     case 1: 
             startImage = 0;
             endImage = 114;
             break;
     case 2: 
             startImage = 123;
             endImage =  209;
             break;
     case 3: 
             startImage = 218;
             endImage = 250;
             break;
     case 4: 
             startImage = 260;
             endImage = 308;
             break;
    case 5: 
             startImage = 319;
             endImage = 369;
             break;
    case 6: 
             startImage = 378;
             endImage = 426;
             break;
    case 7: 
             startImage = 435;
             endImage = 481;
             break;
     case 8: 
             startImage = 490;
             endImage = 588;
             break;

   } 
  
}




