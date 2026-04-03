module full_adder (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
    // Soma: A XOR B XOR Cin
    assign sum = a ^ b ^ cin; 
    
    // Carry-out: (A AND B) OR (Cin AND (A XOR B))
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

/*Recebe dois bits e um carry-in e calcula a soma e o novo carry-out com XOR, AND e OR */