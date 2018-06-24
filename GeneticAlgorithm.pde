/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//package trabalho2IAA; //<>//

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;

/**
 *
 * @author eu e apenas minha própria pessoa
 */
public class GeneticAlgorithm {

    Boolean[][] tabuleiro;
    LinkedList<Integer> solucao = new LinkedList<Integer>();

    
    GeneticAlgorithm(){
      
    }
    
    int fitness(LinkedList<Integer> tab) {
        //inicializa tabuleiro de a
        int colisoes = 0;
        tabuleiro= new Boolean[tab.size()][tab.size()];
        for (int i = 0; i < tab.size(); i++) {
            for (int j = 0; j < tab.size(); j++) {
                tabuleiro[i][j] = false;
            }
        }
        //marca as rainhas
        for (int i = 0; i < tab.size(); i++) {
            tabuleiro[i][tab.get(i)] = true;
        }

        //calcula o numero de colisões
        for (int i = 0; i < tab.size(); i++) {
            for (int j = 0; j < tab.size(); j++) {
                if (tabuleiro[i][j] == true) {

                    //verifica linha
                    for (int a = 0; a < tab.size(); a++) {
                        if (a != i) {
                            if ((tabuleiro[a][j] == true)) {
                                colisoes = colisoes + 1;
                            }
                        }
                    }

                    //verifica diagonais superiores
                    //superior esqueda
                    for (int a = i, b = j; a >= 0 && b >= 0; a--, b--) {
                        if (tabuleiro[a][b] == true && (a != i && b != j)) {
                            colisoes = colisoes + 1;
                        }
                    }
                    //superior direita
                    for (int a = i, b = j; a < tab.size() && b >= 0; a++, b--) {
                        if (tabuleiro[a][b] == true && (a != i && b != j)) {
                            colisoes = colisoes + 1;
                        }
                    }
                    //verifica diagonais inferiores
                    //inferior a direita
                    for (int a = i, b = j; a < tab.size() && b < tab.size(); a++, b++) {
                        if (tabuleiro[a][b] == true && (a != i && b != j)) {
                            colisoes = colisoes + 1;
                        }
                    }
                    //inferior esquerda
                    for (int a = i, b = j; a >= 0 && b < tab.size(); a--, b++) {
                        if (tabuleiro[a][b] == true && (a != i && b != j)) {
                            colisoes = colisoes + 1;
                        }
                    }

                }
            }
        }

        return colisoes;

    }
    
    public LinkedList<LinkedList<Integer>> mutacao(LinkedList<LinkedList<Integer>> populacao, double prob){
    Random gerador = new Random();
    LinkedList<LinkedList<Integer>> arrayNovo = new LinkedList<LinkedList<Integer>>();
    for(LinkedList<Integer> elemento : populacao){
        arrayNovo.add(elemento);
    }
    for(int i=0; i<populacao.size(); i++){
      //tamanho da população
      for(int j=0; j<populacao.get(0).size(); j++){
        //tamanho do cromossomo
        if(Math.random() <= prob){
          //exemplo: if entrou pro cromossomo j=3 do individuo i=6; Então o cromossomo 2 do individuo 6 vai sofrer mutacao
          //essa mutação varia entre 0 e o tamanho máximo do cromossomo
          arrayNovo.get(i).set(gerador.nextInt(populacao.get(0).size()), gerador.nextInt(populacao.get(0).size()));
        }
      }
    }
    return arrayNovo;
    /*
    for(int elemento : populacao){
        arrayNovo.add(elemento);
    }
    arrayNovo.set(gerador.nextInt(arrayNovo.size()), gerador.nextInt(arrayNovo.size()));
    return arrayNovo;*/
  }
  
    private LinkedList<LinkedList<Integer>> criarPopulacao(int tamanhoCromossomo,int tamanhoPopulacao) {
        LinkedList<LinkedList<Integer>> listaPopulacao = new LinkedList<LinkedList<Integer>>();
        Random gerador = new Random();
        for(int i=0;i<tamanhoPopulacao;i++){
            LinkedList<Integer> listaCromossomo = new LinkedList<Integer>();
            listaCromossomo.clear();
            for(int j=0;j<tamanhoCromossomo;j++){
                listaCromossomo.add(gerador.nextInt(tamanhoCromossomo));
            }
            listaPopulacao.add(listaCromossomo);
        }
        return listaPopulacao;
    }
    
        public LinkedList<Integer> avaliar(LinkedList<LinkedList<Integer>> populacao){
        LinkedList<Integer> aptidao = new LinkedList<Integer>();
        for(LinkedList<Integer> crom : populacao){
            aptidao.add(fitness(crom));
        }
        return aptidao;
    }

    public int menorValor(LinkedList<Integer> aptidao){
      int menor = aptidao.getFirst();
        for(int elemento : aptidao){
            if(elemento<menor){
                menor=elemento;
            }
        }
        return menor;
    }
    
    public LinkedList<Integer> criarTorneio(LinkedList<LinkedList<Integer>> populacao){
        Random gerador = new Random();
        LinkedList<Double> torneio = new LinkedList<Double>();
        int indexUm=1;
        int indexDois=1;
        LinkedList<LinkedList<Integer>> populacaoIntermediaria = new LinkedList<LinkedList<Integer>>();
        while(indexUm!=indexDois){
            indexUm = gerador.nextInt(populacao.size());
            indexDois = gerador.nextInt(populacao.size());
        }
        populacaoIntermediaria.add(populacao.get(indexUm));
        populacaoIntermediaria.add(populacao.get(indexDois));
        
        LinkedList<Integer> aptidaoList = avaliar(populacaoIntermediaria);
        if(aptidaoList.get(0)<aptidaoList.get(1)){
            return populacaoIntermediaria.getFirst();
        } else{
            return populacaoIntermediaria.getLast();
        }
        
    }
        
        

    private LinkedList<Integer> selecaoNatural(LinkedList<Double> probabilidades) {
      LinkedList<Integer> selecionados = new LinkedList<Integer>();
      for(int i=0; i<probabilidades.size(); i++){
        double agulha = Math.random();
        for(int j=0; j<probabilidades.size(); j++){
          if(agulha <= probabilidades.get(j)){
            selecionados.add(j);
            break;
            //Entendi... é o seguinte: seleção natural retorna um vetor entre 0 e o tamanho da populaçãi, se o vetor for, por exemplo:
            // (4, 3, 2, 2), quer dizer que, numa população de 4 individuos, foram selecionados o 4, depois o 3, depois o 2 duas vezes
          }
        }
      }
        return selecionados;
    }
    
     private LinkedList<LinkedList<Integer>> crossOver(LinkedList<LinkedList<Integer>> populacao, double prob) {
       Random gerador = new Random();
       for(int i = 0; i<populacao.size(); i++){
          int indexUm = gerador.nextInt(populacao.size());
            int indexDois = gerador.nextInt(populacao.size());
          if(Math.random() <= prob){
              int aux = populacao.get(indexUm).get(0);
              int aux2 = populacao.get(indexUm).get(1);
              int aux3 = populacao.get(indexUm).get(2);
              populacao.get(indexUm).set(0, populacao.get(indexDois).get(0));
              populacao.get(indexUm).set(1, populacao.get(indexDois).get(1));
              populacao.get(indexUm).set(2, populacao.get(indexDois).get(2));
              populacao.get(indexDois).set(0, aux);
              populacao.get(indexDois).set(1, aux2);
              populacao.get(indexDois).set(2, aux3);
          }
        }
         
         return populacao;
    }
     
    public boolean verificaFim(LinkedList<LinkedList<Integer>> populacao){
        for(LinkedList<Integer> crom : populacao){
            if(fitness(crom)==0){
                solucao = crom;
                return false;
            }
        }
        return true;
    }
    
    public LinkedList<Integer> verificamenor(LinkedList<LinkedList<Integer>> populacao){
      int a = 99999;
        for(LinkedList<Integer> crom : populacao){
            if(fitness(crom)<a){
              a = fitness(crom);
                solucao = crom;
            }
        }
        return solucao;
    }

    
   public LinkedList<Integer> executaG(int tamanhoCromossomo){
       LinkedList<LinkedList<Integer>> populacao = criarPopulacao(tamanhoCromossomo,20);
       int g =0;
       //int gMax = 10000;
       while(verificaFim(populacao)){
          // LinkedList<Integer> aptidao = avaliar(populacao);
           
           //realizar while com o tamanho da população
           LinkedList<LinkedList<Integer>> populacaoNova = new LinkedList<LinkedList<Integer>>();
           for(int i=0; i<populacao.size() ;i++){
               LinkedList<Integer> cromossomoSelecionado = criarTorneio(populacao);
               populacaoNova.add(cromossomoSelecionado);
           }
          populacaoNova = crossOver(populacaoNova,0.7);
          populacao = mutacao(populacaoNova,0.01);
          
          
          g++;
       }
       //if(g>=gMax){
       //   LinkedList solucaoAntesDoFim = avaliar(populacao);          
       //   solucao = populacao.get(solucaoAntesDoFim.indexOf(menorValor(solucaoAntesDoFim)));
       
       return solucao;
   }
}