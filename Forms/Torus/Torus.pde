// ----------------------------------------------------------------
import processing.opengl.*;
import javax.media.opengl.*;
import codeanticode.glgraphics.*;
import toxi.geom.*;
import toxi.geom.mesh.*;

TorusKnot modelKnot;
GLModel modelMesh;

// ----------------------------------------------------------------
void setup()
{
  size(1000, 1000, GLConstants.GLGRAPHICS);
  modelKnot = new TorusKnot(190, 90, 4,5, 700, 50, 3); // global radius, inner radius, P,Q, res, res2 (around), render mode
  modelMesh = convertGLModel(modelKnot.mesh);
}

// ----------------------------------------------------------------
void draw()
{
  background(0);

  // Black 3D Model
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL();
  tranform();
  modelMesh.render();
  renderer.endGL();

  // White lines
  tranform();
  scale(1.003);
  strokeWeight(2);
  stroke(255);
  modelKnot.renderLines();
}

// ----------------------------------------------------------------
void tranform()
{
  translate(width/2, height/2);
  rotateX( map(mouseY, 0, height, -PI, PI) );
  rotateY( map(mouseX, 0, width, -PI, PI) );
}

// ----------------------------------------------------------------
GLModel convertGLModel(TriangleMesh mesh)
{
  float[] vertices=mesh.getMeshAsVertexArray();
  float[] normals=mesh.getVertexNormalsAsArray();
  int nbVertices = vertices.length/4;

  GLModel m = new GLModel(this, nbVertices, TRIANGLES, GLModel.STATIC);

  m.beginUpdateVertices();
  for (int i = 0; i < nbVertices; i++) m.updateVertex(i, vertices[4*i], vertices[4*i+1], vertices[4*i+2]);
  m.endUpdateVertices(); 

  m.initNormals();
  m.beginUpdateNormals();
  for (int i = 0; i < nbVertices; i++) m.updateNormal(i, normals[4 * i], normals[4 * i + 1], normals[4 * i + 2]);
  m.endUpdateNormals();  

  m.initColors();
  m.setColors(0);

  return m;
}

// ----------------------------------------------------------------
void keyPressed()
{
  if (key == ' ')
  {
    saveFrame("export_"+timestamp()+".png"); 
  }
}

