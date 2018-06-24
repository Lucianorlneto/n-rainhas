import controlP5.*; //<>//
import java.util.Comparator;
import java.util.PriorityQueue;
import static javax.swing.JOptionPane.*;

//Alunos: Luciano Rodrigues Lucio Neto, Daniel Augusto Moura Cunha e Emerson Vilar de Oliveira

Box[][] campo;
ControlP5 cp5;
int option, metodo = 0;
CheckBox checkbox;
int n = 4;
String textValue = "";
int tamcrom;
GeneticAlgorithm g;
SimulatedAnnealing s;
boolean[][] matriz;
boolean primeira = false;
PImage img;
//int coiso = 0;

//int[] dx = {1, 1, 0, -1, -1, -1, 0, 1};
//int[] dy = {0, 1, 1, 1, 0, -1, -1, -1};

//int[] dx = {1, 0, -1, 0};
//int[] dy = {0, 1, 0, -1};

void setup() {
  size(800, 600);
  background(230);
  cp5 = new ControlP5(this);
  g = new GeneticAlgorithm();
  s = new SimulatedAnnealing();
  criarCampo();
  criarMenu();
  matriz = new boolean[n][n];
 
  primeira = true;
  
 // loop = new int[20][20];
}

void draw() {
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
     
        campo[i][j].draw(); 
       
      
    }
  }
}

void setMatriz(){
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
        matriz[i][j] = false;
    }
  }
}

void criarCampo() {
  campo = new Box[n][n];
  int x = 0, y = 0, w = 600/n, h = 600/n;
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      campo[i][j] = new Box(i*w, j*h, w, h);
      if((i%2 == 0 && j%2 == 0) || (i%2 != 0 && j%2 != 0)){
        campo[i][j].changeColor(255, 255, 255);
       } else{
        campo[i][j].changeColor(0, 0, 0);
       }
    }
  }
}

void clearCampo(){
  fill(230);
  noStroke();
  rect(0,0,630,630);
  //stroke(153);
  
}

void mouseClicked() {
  if(mouseX >= 0 && mouseX <= 600 && mouseY >= 0 && mouseY <= 600) {
    float[] c = checarCaixa(mouseX, mouseY);
    int i = (int)c[0], j = (int)c[1];
    if(option == 0){
        n = n + 1;
        draw();
        criarCampo();
      } else if(option == 1){
        campo[i][j].changeColor(0, 191, 255);
      } else if(option == 2){
        campo[i][j].changeColor(61, 145, 64);
      } else if(option == 5){
        campo[i][j].changeColor(255, 255, 255);
      } else if(option == 6){
        
      }
  }
}

float[] checarCaixa(float x, float y) {
  float[] coordenadas = new float[2];
  coordenadas[0] = map(x, 0, 600, 0, 20);
  println(x + " -> " + coordenadas[0]);
  coordenadas[1] = map(y, 0, 600, 0, 20);
  println(y + " -> " + coordenadas[1]);
  return coordenadas;
}

void criarMenu() {
  cp5.addButton("up")
     .setValue(0)
     .setPosition(650, 100)
     .setSize(100, 30)
     ;
     
  cp5.addButton("down")
     .setValue(1)
     .setPosition(650, 135)
     .setSize(100, 30)
     ;
     
  cp5.addButton("Simulated Annealing")
     .setValue(3)
     .setPosition(650, 400)
     .setSize(100, 50)
     ;
     
  cp5.addButton("Algoritmo Genético")
     .setValue(2)
     .setPosition(650, 500)
     .setSize(100, 50)
     ;

}

public void controlEvent(ControlEvent theEvent) {
  if(primeira == true){
  if(theEvent.isFrom(checkbox)) {
    println("Teste"); 
    if(metodo == 1){
    } else{
    }
  }
  
  if(theEvent.isAssignableFrom(Textfield.class)) {
    tamcrom = Integer.parseInt(theEvent.getStringValue());
  }
  
  Button b = (Button) theEvent.getController();
  
  int v = (int) theEvent.getController().getValue();
  if(v == 0) {
    option = 0;
    n = n+1;
    criarCampo();
    clearCampo();
  } else if(v == 1) {
    option = 1;
    n = n-1;
    criarCampo();
    clearCampo();
  } else if(v == 2) {
    criarCampo();
    //option = 2;
    metodo = 1;

    
    println(g.executaG(n));
    LinkedList<Integer> temp = new LinkedList<Integer>();
    temp = g.executaG(n);
    for(int i=0; i<temp.size(); i++){
      //println(temp.get(i));
      //campo[i][temp.get(i)].changeColor(123, 123, 67);
      //image(img, i*(600/n), temp.get(i)*(600/n), 600/n, 600/n);
      campo[i][temp.get(i)].coiso = 1;
      if(g.fitness(temp) == 0){
         println(g.fitness(temp));
         campo[i][temp.get(i)].coiso2 = 0;
      }else{
         campo[i][temp.get(i)].coiso2 = 1;
      }
    }
    //pause();
  } else if(v == 3) {
    //gulosa

    criarCampo();
    println(s.executaSA(n));
    ArrayList<Integer> temp = new ArrayList<Integer>();
    temp = s.executaSA(n);
    for(int i=0; i<temp.size(); i++){
      println(temp.get(i));
      //campo[i][temp.get(i)].changeColor(123, 123, 67);
      //image(img, i*(600/n), temp.get(i)*(600/n), 600/n, 600/n);
      campo[i][temp.get(i)].coiso = 1;
      if(s.fitness(temp) == 0){
         //println(s.fitness(temp));
         campo[i][temp.get(i)].coiso2 = 0;
      }else{
         campo[i][temp.get(i)].coiso2 = 1;
      }
    }
    metodo = 2;
  } else if(v == 4) {
    //Aestrela

    //metodo = 2;
  } else if(v == 5){
    option = 5;
  } else if(v == 6){
    option = 6;

  } else if(v == 7){

  }
  }
  
}

/*void soma(int a){
  int soma = 3 + a;
  println(soma);
}*/
  
 //<>//




  