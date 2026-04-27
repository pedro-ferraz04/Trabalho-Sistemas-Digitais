module adder4(
input logic SW[0],
input logic SW[1],

output logic LED[0],
output logic LED[1],
output logic LED[2]
);

assign LED[0] = SW[0];
assign LED[1] = SW[1];
assign LED[2] = SW[0] | SW[1];

endmodule