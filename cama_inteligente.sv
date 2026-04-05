module cama_inteligente (
    input  logic       clk,       // clock do sistema
    input  logic       rst_n,     // reset ativo baixo
    input  logic [7:0] peb,       // pressão esquerda-baixo 
    input  logic [7:0] pec,       // pressão esquerda-cima 
    input  logic [7:0] pdb,       // pressão direita-baixo 
    input  logic [7:0] pdc,       // pressão direita-cima 
    output logic [7:0] peso_total // peso em kg
);

    // Sinais internos para armazenar as somas intermediárias
    // 9 bits para evitar overflow antes da divisão final
    logic [7:0] soma_esq, soma_dir;
    logic       carry_esq, carry_dir;
    
    logic [7:0] soma_completa;
    logic       carry_final;

    // 1. Soma os sensores da esquerda: peb + pec
    adder_8bit soma_esquerda (
        .a(peb),
        .b(pec),
        .cin(1'b0),
        .sum(soma_esq),
        .cout(carry_esq)
    );

    // 2. Soma os sensores da direita: pdb + pdc
    adder_8bit soma_direita (
        .a(pdb),
        .b(pdc),
        .cin(1'b0),
        .sum(soma_dir),
        .cout(carry_dir)
    );

    // 3. Soma os dois resultados: soma_esq + soma_dir
    //somamos as bases de 8 bits.
    adder_8bit soma_total (
        .a(soma_esq),
        .b(soma_dir),
        .cin(1'b0),
        .sum(soma_completa),
        .cout(carry_final)
    );

    // Lógica Síncrona: Atualiza a saída no pulso de clock 
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            peso_total <= 8'h00; // Reset limpa o peso
        end else begin
            peso_total <= {carry_final, soma_completa} >> 1;
        end
    end

endmodule


/* CÁLCULO FINAL:
Como 1 unidade = 0.5kg, precisamos de (Soma Total / 2).
Em binário, dividir por 2 é um deslocamento para a direita (>> 1).
Concatenamos o carry_final para não perder o bit mais significativo.
*/