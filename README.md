# Trabalho T1: Cama Inteligente – Sistemas Digitais 🛏️

Este é um projeto desenvolvido em **SystemVerilog** para a disciplina de Sistemas Digitais que automatiza o cálculo de peso através de sensores de pressão.

## 📋 Regras de Cálculo

O sistema aplica o processamento sobre os valores dos **sensores de 8 bits** seguindo estes critérios:

### 1. Soma dos Sensores
* **Hardware:** Quatro sensores de pressão: peb, pec, pdb e pdc.
* **ALU Customizada:** Soma realizada através de módulos `full_adder` e `adder_8bit`.

### 2. Conversão para Quilogramas (kg)
A regra de peso varia conforme a unidade de pressão:
* **Relação:** 1 unidade de pressão corresponde a 0.5 kg.
* **Processamento:** O peso total deve ser a soma dos pesos calculados a partir dos quatro sensores.

### 3. Ajuste de Escala
* **Divisão Binária:** Realizada via deslocamento para a direita (`>> 1`) para otimização de hardware.
* **Precisão:** O bit de carry final é concatenado para garantir que não haja perda de dados no cálculo.

## 🛠️ Tecnologias
* **Linguagem:** SystemVerilog
* **Compilador sugerido:** Questa / ModelSim

## 🚀 Como Executar

### 1. Compilação e Simulação
Para rodar o projeto e os testes de cobertura, utilize o script fornecido no console do Questa:
```tcl
do sim.do

Integrantes:
Lucas Machado
Maria Eduarda da Luz
Maurício Duarte Paliosa
Pedro Henrique Duarte Ferraz
