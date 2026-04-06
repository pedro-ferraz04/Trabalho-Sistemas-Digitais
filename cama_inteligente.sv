module cama_inteligente (
    input  logic       clk,       
    input  logic       rst_n,     
    input  logic [7:0] peb,       // pressão esquerda-baixo 
    input  logic [7:0] pec,       // pressão esquerda-cima 
    input  logic [7:0] pdb,       // pressão direita-baixo 
    input  logic [7:0] pdc,       // pressão direita-cima 
    output logic [8:0] peso_total 
);

    logic [9:0] soma_esq, soma_dir, soma_completa, soma_tarada;
    logic       carry_esq, carry_dir, carry_final;

    
    


    adder_10bit soma_esquerda (
        .a({2'b00, peb}),
        .b({2'b00, pec}),
        .cin(1'b0),
        .sum(soma_esq),
        .cout(carry_esq)
    );

    adder_10bit soma_direita (
        .a({2'b00, pdb}),
        .b({2'b00, pdc}),
        .cin(1'b0),
        .sum(soma_dir),
        .cout(carry_dir)
    );

    adder_10bit soma_total (
        .a(soma_esq),
        .b(soma_dir),
        .cin(1'b0),
        .sum(soma_completa),
        .cout(carry_final)
    );

    assign soma_liquida = soma_completa - 10'd100;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            peso_total <= 9'h00; // Reset
        end else if(soma_completa < 10'd100) begin
        peso_total <= 9'd0;
        end else begin
            peso_total <= soma_liquida >> 1;
        end
    end

endmodule
