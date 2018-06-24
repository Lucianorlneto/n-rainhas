 //package n.rainhas;

import static java.lang.Math.exp;
import static java.lang.Math.pow;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;

class SimulatedAnnealing{

  Boolean[][] tabuleiro;

  SimulatedAnnealing(){
     
  }

  int fitness(ArrayList<Integer> tab){
    //inicializa tabuleiro de a
    int colisoes = 0;
    tabuleiro= new Boolean[tab.size()][tab.size()];
    for(int i=0; i<tab.size(); i++){
        for(int j=0; j<tab.size(); j++){
            tabuleiro[i][j] = false;
        }
    }
    for(int i=0; i<tab.size(); i++){
      tabuleiro[i][tab.get(i)] = true;
    }

    //calcula o numero de colisões
    for(int i = 0; i<tab.size(); i++){
      for(int j=0; j<tab.size(); j++){
        if(tabuleiro[i][j] == true){
         
          //verifica linha
          for(int a = 0; a<tab.size(); a++){
            if(a != i){
              if((tabuleiro[a][j] == true)){
                colisoes = colisoes + 1;
              }
            }
          }
          
          //verifica diagonais superiores
          //superior esqueda
          for (int a = i, b = j; a >= 0 && b >= 0; a--, b--) {
          if(tabuleiro[a][b] == true && (a!=i && b!=j)){
            colisoes = colisoes+1;
          }
        }
        //superior direita
        for (int a = i, b = j; a < tab.size() && b >= 0; a++, b--) {
          if(tabuleiro[a][b] == true && (a!=i && b!=j)){
            colisoes = colisoes+1;
          }
        }
        //verifica diagonais inferiores
        //inferior a direita
        for (int a = i, b = j; a < tab.size() && b < tab.size(); a++, b++) {
          if(tabuleiro[a][b] == true && (a!=i && b!=j)){
            colisoes = colisoes+1;
          }
        }
        //inferior esquerda
        for (int a = i, b = j; a >= 0 && b < tab.size(); a--, b++) {
          if(tabuleiro[a][b] == true && (a!=i && b!=j)){
            colisoes = colisoes+1;
          }
        }

        }
      }
    }

    return colisoes;

  }

  ArrayList<Integer> novoVizinho(ArrayList<Integer> a){
    Random gerador = new Random();
    ArrayList<Integer> arrayNovo = new ArrayList<Integer>();
    for(int elemento : a){
        arrayNovo.add(elemento);
    }
    arrayNovo.set(gerador.nextInt(arrayNovo.size()), gerador.nextInt(arrayNovo.size()));
    return arrayNovo;
  }

  ArrayList<Integer> executaSA(int size){
    ArrayList<Integer> temp = new ArrayList<Integer>();
    Random gerador = new Random();
    for(int i=0;i< size;i++){
      temp.add(gerador.nextInt(size));
    }
    int f = fitness(temp);
    double a = 0.95;
    float temperatura_inicial = 10000;
    float temperatura = temperatura_inicial;
    float t = 1;
    while(temperatura>pow(10, -10) && f != 0){
       f=fitness(temp);
       temperatura =  temperatura_inicial*(float)pow((float)a, (float)t);
       ArrayList<Integer> novoVizinhoList = new ArrayList<Integer>();
       ArrayList<Integer> tempList = new ArrayList<Integer>();
       for(int i: novoVizinho(temp)){
           novoVizinhoList.add(i);
       }
       t = t + 1;
       int dE = fitness(temp) - fitness(novoVizinhoList)  ;

       if(fitness(novoVizinhoList) < fitness(temp)){
            temp.clear();
            for(int elemento : novoVizinhoList){
                temp.add(elemento);
            }
          }
       else{
        float prob = (float) exp(dE/temperatura);
        if(Math.random() < prob){
            temp.clear();
            for(int elemento : novoVizinhoList){
                temp.add(elemento);
            }
        }
      }
       f=fitness(temp);
       if(fitness(temp)==0){
           System.out.println("REIOSSSE ENCONTROU");
       }

    }
      System.out.println(f);
    return temp;  

  }  
}