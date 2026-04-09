# Projeto Cama Inteligente

Este projeto calcula o peso de uma pessoa em uma cama usando 4 sensores. [cite_start]Ele soma os valores, tira o peso da cama e mostra o resultado em quilos [cite: 24-33].

## Arquivos Necessarios

Para tudo funcionar, coloque estes arquivos na mesma pasta:
* full_adder.sv
* adder_10bit.sv
* cama_inteligente.sv
* tb.sv
* sim.do

## Como rodar (Passo a Passo)

1. Abra o programa QuestaSim ou ModelSim.
2. Clique em File > Change Directory e escolha a pasta onde estao os arquivos.
3. Na parte de baixo do programa (janela Transcript), escreva o comando abaixo e aperte Enter:
   do sim.do

## Como ver os resultados

* Ondas Verdes: Vai abrir uma janela mostrando os desenhos das ondas. [cite_start]Elas mostram o peso sendo calculado [cite: 1-2].
* Relatorio: O programa cria uma pasta chamada coverage_report. Entre nela e abra o arquivo index.html no seu navegador. Se estiver tudo verde, o trabalho esta certo.
