# 1. Cria a biblioteca de trabalho
vlib work

# 2. Compila todos os arquivos com o novo nome do testbench
vlog -cover bcesf full_adder.sv adder_10bit.sv cama_inteligente.sv tb.sv

vsim -voptargs="+acc" -coverage tb

# 4. Adiciona as ondas
add wave -position insertpoint sim:/tb/uut/*

# 5. Roda a simulação
run -all

# 6. Gera o relatório de cobertura exigido (Parte 3)
coverage report -html -htmldir coverage_report -details