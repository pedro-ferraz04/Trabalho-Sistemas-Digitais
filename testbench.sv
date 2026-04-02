module tb;

logic clk;
logic rst_n;
logic [7:0] peb, pec, pdb, pdc;
logic [31:0] peso_total;

// Instância
cama_inteligente uut (
    .clk(clk),
    .rst_n(rst_n),
    .peb(peb),
    .pec(pec),
    .pdb(pdb),
    .pdc(pdc),
    .peso_total(peso_total)
);
//A TARA AINDA DEVE SER SELECIONADA "O PESO DA CAMA EM SI".
//O CALCULO DOS PESOS AINDA DEVE SER FEITO PARA FINALIZAR ESSE TESTBENCH.

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst_n = 0;

    // Reset
    #10 rst_n = 1;

    // TESTE 1: tudo zero
    peb=0; pec=0; pdb=0; pdc=0;
    #10;
    $display("Teste 1: %d (esperado 0)", peso_total);

    // TESTE 2: máximo
    peb=255; pec=255; pdb=255; pdc=255;
    #10;
    $display("Teste 2: %d (esperado 1020 ou 920 com tara)", peso_total);

    // TESTE 3
    peb=100; pec=50; pdb=25; pdc=25;
    #10;
    $display("Teste 3: %d (esperado 200)", peso_total);

    // TESTE 4
    peb=200; pec=100; pdb=50; pdc=10;
    #10;
    $display("Teste 4: %d (esperado 360)", peso_total);

    // TESTE 5
    peb=255; pec=0; pdb=0; pdc=0;
    #10;
    $display("Teste 5: %d (esperado 255)", peso_total);

    $stop;
end

endmodule

