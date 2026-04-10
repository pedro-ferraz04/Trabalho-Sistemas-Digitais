module tb;

    logic clk;
    logic rst_n;
    logic [7:0] peb, pec, pdb, pdc;
    logic [8:0] peso_total;

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
        //peb = 0; pec = 0; pdb = 0; pdc = 0;

        #15 rst_n = 1;

        // TESTE 1:
        @(posedge clk); 
        peb=0; pec=0; pdb=0; pdc=0;
        //@(posedge clk); 
        $display("Teste 1: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 2:  
        @(posedge clk); 
        peb=255; pec=255; pdb=255; pdc=255;
        //@(posedge clk);
        // 1020 unidades / 2 = 510 - tara(50kg) = 460 kg
        $display("Teste 2: Peso=%d kg (Esperado: 460)", peso_total);

        // TESTE 3
        @(posedge clk); 
        peb=100; pec=50; pdb=25; pdc=25; // Soma = 200 unidades
        //@(posedge clk);

        // 200 unidades / 2 = 100 - tara kg
        $display("Teste 3: Peso=%d kg (Esperado: 50)", peso_total);

        //TESTE 4: Cobertura do erro para caso tara > peso total
        @(posedge clk); 
        peb=20; pec=20; pdb=20; pdc=20; // Soma = 80 unidades
        //@(posedge clk);
        $display("Teste 4 Abaixo da Tara): Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 5: Valores ímpares e baixos (Testa bits menos significativos e carry inicial)
        @(posedge clk);
        peb=1; pec=1; pdb=1; pdc=1; 
        // Soma = 4. (4/2) = 2. 2 - 50 = -48. Esperado: 0 (Proteção de tara)
        $display("Teste 5: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 6: Apenas um sensor alto (Testa o caminho de apenas um somador)
        @(posedge clk);
        peb=200; pec=0; pdb=0; pdc=0;
        // Soma = 200. (200/2) = 100. 100 - 50 = 50. Esperado: 50
        $display("Teste 6: Peso=%d kg (Esperado: 50)", peso_total);

        // TESTE 7: 
        @(posedge clk);
        peb=50; pec=50; pdb=0; pdc=0;
        // Soma = 100. (100/2) = 50. 50 - 50 = 0. Esperado: 0
        $display("Teste 7: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 8:
        @(posedge clk);
        peb=85; pec=170; pdb=85; pdc=170;
        // Soma = 510. (510/2) = 255. 255 - 50 = 205. Esperado: 205
        $display("Teste 8: Peso=%d kg (Esperado: 205)", peso_total);

        //TESTE 9:
        @(posedge clk);
        peb=175; pec=85; pdb=170; pdc=90;
        // Soma = 520. (520/2) = 260. 260 - 50 = 210. Esperado: 210
        $display("Teste 9: Peso=%d kg (Esperado: 210)", peso_total);

        //TESTE 10:
        @(posedge clk);
        peb=260; pec=260; pdb=260; pdc=260;
        // Soma = 1040. (1040/2) = 520. 520 - 50 = 470. Esperado: 470
        $display("Teste 10: Peso=%d kg (Esperado: 470)", peso_total);
        
        //TESTE 11:
        @(posedge clk);
        peb=255; pec=11; pdb=17; pdc=13;
        // Soma = 296/2 = 148 - 50. Esperado:98 
        $display("Teste 11: Peso=%d kg (Esperado: 205)", peso_total);

        // TESTE 12: Valores ímpares para testar o bit 0 e carry-in
        @(posedge clk);
        peb=1; pec=3; pdb=5; pdc=7;
        // Soma = 16. (16/2) = 8. 8 < 50. Esperado: 0 (Proteção de tara)
        $display("Teste 12: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 13: Quase no limite da divisão por 2 (Soma ímpar)
        @(posedge clk);
        peb=50; pec=51; pdb=50; pdc=50;
        // Soma = 201. (201/2) = 100. 100 - 50 = 50. Esperado: 50
        $display("Teste 13: Peso=%d kg (Esperado: 50)", peso_total);

        // TESTE 14: Valor alto em apenas um sensor (Testa carries de um lado só)
        @(posedge clk);
        peb=255; pec=0; pdb=0; pdc=0;
        // Soma = 255. (255/2) = 127. 127 - 50 = 77. Esperado: 77
        $display("Teste 14: Peso=%d kg (Esperado: 77)", peso_total);

        // TESTE 15: Sensores com valores "Xadrez" (01010101)
        @(posedge clk);
        peb=85; pec=85; pdb=85; pdc=85;
        // Soma = 340. (340/2) = 170. 170 - 50 = 120. Esperado: 120
        $display("Teste 15: Peso=%d kg (Esperado: 120)", peso_total);

        // TESTE 16: Sensores com valores "Xadrez" Invertidos (10101010)
        @(posedge clk);
        peb=170; pec=170; pdb=170; pdc=170;
        // Soma = 680. (680/2) = 340. 340 - 50 = 290. Esperado: 290
        $display("Teste 16: Peso=%d kg (Esperado: 290)", peso_total);
        
        // TESTE 17: "Quase estouro" de 8 bits (254)
        @(posedge clk);
        peb=127; pec=127; pdb=0; pdc=0;
        // Soma = 254. (254/2) = 127. 127 - 50 = 77. Esperado: 77
        $display("Teste 17: Peso=%d kg (Esperado: 77)", peso_total);

        // TESTE 18: Soma resultando em 101 (Limite da tara)
        @(posedge clk);
        peb=25; pec=26; pdb=25; pdc=25;
        // Soma = 101. (101/2) = 50. 50sim:/tb/#INITIAL#22 - 50 = 0. Esperado: 0
        $display("Teste 18: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 19: Testando o bit 7 (MSB dos sensores) isoladamente
        @(posedge clk);
        peb=128; pec=0; pdb=128; pdc=0;
        // Soma = 256. (256/2) = 128. 128 - 50 = 78. Esperado: 78
        $display("Teste 19: Peso=%d kg (Esperado: 78)", peso_total);

        // TESTE 20: Alternância de bits baixos (00000011 e 00001100)
        @(posedge clk);
        peb=3; pec=12; pdb=3; pdc=12;
        // Soma = 30. (30/2) = 15. 15 < 50. Esperado: 0
        $display("Teste 20: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 21: Valores que forçam carry no meio do somador (00001111 + 00000001)
        @(posedge clk);
        peb=15; pec=1; pdb=15; pdc=1;
        // Soma = 32. (32/2) = 16. 16 < 50. Esperado: 0
        $display("Teste 21: Peso=%d kg (Esperado: 0)", peso_total);

        // TESTE 22: Estresse de bits altos (240 = 11110000)
        @(posedge clk);
        peb=240; pec=240; pdb=240; pdc=240;
        // Soma = 960. (960/2) = 480. 480 - 50 = 430. Esperado: 430
        $display("Teste 22: Peso=%d kg (Esperado: 430)", peso_total);

        // TESTE 23: Transição de bits do meio (127 + 1)
@(posedge clk);
peb=127; pec=1; pdb=127; pdc=1;
// Soma = 256. (256/2) = 128. 128 - 50 = 78. Esperado: 78
$display("Teste 23: Peso=%d kg (Esperado: 78)", peso_total);

// TESTE 24: Alternância rápida de bits (1010 vs 0101 em escala menor)
@(posedge clk);
peb=10; pec=5; pdb=10; pdc=5;
// Soma = 30. (30/2) = 15. Esperado: 0 (Tara)
$display("Teste 24: Peso=%d kg (Esperado: 0)", peso_total);

// TESTE 25: Forçando carry nos bits 4 e 5
@(posedge clk);
peb=31; pec=1; pdb=31; pdc=1;
// Soma = 64. (64/2) = 32. Esperado: 0 (Tara)
$display("Teste 25: Peso=%d kg (Esperado: 0)", peso_total);

// TESTE 26: Quase estouro total dos sensores (254 em todos)
@(posedge clk);
peb=254; pec=254; pdb=254; pdc=254;
// Soma = 1016. (1016/2) = 508. 508 - 50 = 458. Esperado: 458
$display("Teste 26: Peso=%d kg (Esperado: 458)", peso_total);

// TESTE 27: Um sensor no máximo e outros no mínimo (Assimetria)
@(posedge clk);
peb=255; pec=1; pdb=0; pdc=0;
// Soma = 256. (256/2) = 128. 128 - 50 = 78. Esperado: 78
$display("Teste 27: Peso=%d kg (Esperado: 78)", peso_total);

// TESTE 28: Soma resultando em número ímpar alto
@(posedge clk);
peb=255; pec=255; pdb=255; pdc=254;
// Soma = 1019. (1019/2) = 509. 509 - 50 = 459. Esperado: 459
$display("Teste 28: Peso=%d kg (Esperado: 459)", peso_total);

// TESTE 29: Testando o bit 6 (64)
@(posedge clk);
peb=64; pec=64; pdb=64; pdc=64;
// Soma = 256. (256/2) = 128. 128 - 50 = 78. Esperado: 78
$display("Teste 29: Peso=%d kg (Esperado: 78)", peso_total);

// TESTE 30: Valores de "escada" (Power of 2)
@(posedge clk);
peb=2; pec=4; pdb=8; pdc=16;
// Soma = 30. (30/2) = 15. Esperado: 0
$display("Teste 30: Peso=%d kg (Esperado: 0)", peso_total);

// TESTE 31: Forçando carry no bit mais alto (MSB) do somador de 10 bits
@(posedge clk);
peb=255; pec=255; pdb=100; pdc=100;
// Soma = 710. (710/2) = 355. 355 - 50 = 305. Esperado: 305
$display("Teste 31: Peso=%d kg (Esperado: 305)", peso_total);

// TESTE 32: O último esforço para os bits baixos
@(posedge clk);
peb=1; pec=0; pdb=1; pdc=0;
// Soma = 2. (2/2) = 1. Esperado: 0
$display("Teste 32: Peso=%d kg (Esperado: 0)", peso_total);


        #20;
        $display("\n--- Fim dos Testes de Cobertura ---");
        $stop; 
    end

endmodule
