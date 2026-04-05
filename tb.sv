module tb;

    logic clk;
    logic rst_n;
    logic [7:0] peb, pec, pdb, pdc;
    logic [7:0] peso_total;

    // Instância da Unidade(UUT)
    cama_inteligente uut (
        .clk(clk),
        .rst_n(rst_n),
        .peb(peb),
        .pec(pec),
        .pdb(pdb),
        .pdc(pdc),
        .peso_total(peso_total)
    );

    // Gerador de Clock: Período de 10 unidades de tempo
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        rst_n = 0;
        peb = 0; pec = 0; pdb = 0; pdc = 0;

        // Reset do Sistema 
        #15 rst_n = 1;

        // TESTE 1: Todos os sensores com pressão zero [cite: 49]
        @(posedge clk); // Espera o clock para estabilizar
        peb=0; pec=0; pdb=0; pdc=0;
        @(posedge clk); // Espera o hardware processar
        $display("Teste 1: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 2: Pressão máxima (255 em todos) 
        @(posedge clk);
        peb=255; pec=255; pdb=255; pdc=255;
        @(posedge clk);
        // 1020 unidades / 2 = 510 kg
        $display("Teste 2: Peso=%d kg (Esperado: 510)", peso_total);

        // TESTE 3: Valores variados para precisão [cite: 52]
        @(posedge clk);
        peb=100; pec=50; pdb=25; pdc=25; // Soma = 200 unidades
        @(posedge clk);
        // 200 unidades / 2 = 100 kg
        $display("Teste 3: Peso=%d kg (Esperado: 100)", peso_total);

        #20;
        $display("\n--- Fim dos Testes de Cobertura ---");
        $stop; // Para a simulação no Questa [cite: 58]
    end

endmodule