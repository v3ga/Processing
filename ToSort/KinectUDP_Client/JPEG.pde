import com.sun.image.codec.jpeg.*; 
import java.io.*;
import java.awt.*;
import java.awt.image.*;

// ----------------------------------------------------
// JPEGFromPImage
// ----------------------------------------------------
byte[] JPEGFromPImage(PImage srcimg)
{
  ByteArrayOutputStream out = new ByteArrayOutputStream(); 
  BufferedImage img = new BufferedImage(srcimg.width, srcimg.height, 2); 
  img = (BufferedImage)createImage(srcimg.width, srcimg.height); 
  
  try {  // make sure we can access the buffered image
    img.setRGB(0,0, 0);
  } catch (Exception e) {
    return null;
  }
  
  for(int i = 0; i < srcimg.width; i++) { 
    for(int j = 0; j < srcimg.height; j++) { 
	int id = j*srcimg.width+i; 
	try {
	  img.setRGB(i,j, srcimg.pixels[id]);
	}catch (Exception e) {}   
    }
  }
  
  try{ 
    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out); 
    JPEGEncodeParam encpar = encoder.getDefaultJPEGEncodeParam(img); 
    encpar.setQuality(0.5,false); // 0.0-1.0, force baseline 
    encoder.setJPEGEncodeParam(encpar); 
    encoder.encode(img); 
  }catch(FileNotFoundException e){ 
    System.out.println(e); 
  }catch(IOException ioe){ 
    System.out.println(ioe); 
  }
  
  return out.toByteArray(); 
}


// ----------------------------------------------------
// PImageFromJPEG
// ----------------------------------------------------
PImage PImageFromJPEG(byte[] bytes)
{
  if (bytes == null) 
  {
    return null;
  } 
  else 
  {
    Image awtImage = Toolkit.getDefaultToolkit().createImage(bytes);
    PImage image = loadImageMT(awtImage);
    if (image.width == -1)
    {
      System.err.println("impossible de décoder les données reçues...");
    }
    else
      return image;
  }
  return null;
}

