# Documentação

## Índice 

1. **Identificação dos arquivos**
   * Estrutura de dados
   * Extração
   * Imagens
   * Plots
   * Programas base
   * Teste
2. **Funcionamento do programa**
3. **Bibliotecas utilizadas**


## 1. Identificação dos arquivos
### Estrutura de dados
   A pasta estrutura de dados contém o arquivo **EsDados.jl** este programa garante a integridade dos outros programas.
### Extração 
   A pasta extração contém os programas de extração que são reponsáveis pela organização da execução do programa.
### Imagens
   A pasta imagens contém os plots de execuções anteriores.
### Plots
   A pasta plots contém dois tipos de arquivos. O primeiro tipo é o arquivo **plotter.jl** que é responsável por guardar as funções que geram as imagens, já o segundo tipo são os arquivos **GP.jl** que são os arquivos geradores de plot, estes programas são os programas principais do trabalho são neles de definimos os valores das variáveis, tanto as variáveis relacionadas à amostra, tanto as variáveis relacionadas aos plots.
### Programas base
   A pasta programas base contém códigos que guardam as funções básicas para a execução. Por exemplo o **P1** gera a nuvem da amostra.
### Teste 
   A pasta teste contém códigos em fase de teste.


## 2. Funcionamento do programa
   Para utilizarmos o programa devemos ir nos arquivos geradores de plot, após isso devemos colocar os parâmetros que queremos para nossa simulação e por fim rodamos o código.
   

## 3. Bibliotecas utilizadas
### Plots
### SpecialFunctions
### LinearAlgebra
### Distances
### Statistics
### ColorSchemes
### Trapz
### QuadGK
### LatexStrings
