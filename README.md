# CAMA INTELIGENTE 
**Integrantes:** Pedro Ferraz, Maurício Paliosa, Maria Eduarda da Luz, Lucas Machado;

# SOBRE O PROJETO:
* Este sistema calcula o peso de um usuário em uma cama através de quatro sensores de pressão. 
* O sistema realiza a soma das pressões, subtrai a tara (peso da cama) e faz um deslocamento para converter o valor final para Kg.


# COMO EXECUTAR E VISUALIZAR O PROJETO
1. Para rodar, baixe os arquivos que estão em anexo, e coloque-os na mesma pasta;
2. Abra o Questa ou Modelsim e mude o caminho para a pasta criada anteriormente ao unzipar os arquivos do trabalho;
3. Dê o comando do sim.do no console;
4. A pasta de cobertura de código é gerada automaticamente com o nome "coverage_report", ao abrir, procure pelo arquivo index.html, abra no navegador.
5. Nas Waves(ondas), o resultado do peso total está deslocado um ciclo de clock para frente, ou seja, o peso total que estiver alinhado com os dados de entrada dos sensores, corresponde ao resultado da soma anterior. Ex.: <img width="545" height="223" alt="Untitled design(1)" src="https://github.com/user-attachments/assets/c7125934-ebf2-4024-84d2-bac3d70a368c" />

* Neste caso do print, o 460 corresponde ao valor de (255) * 4 - tara.



