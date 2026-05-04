module adder4(
input logic sw_a,
input logic sw_b,

output logic led_a,
  output logic led_b,
output logic led_c
);

assign led_a = sw_a;
assign led_b = sw_b;
assign led_c = sw_a | sw_b;

endmodule
