module accum (
input [7:0] data_1,
input [7:0] data_2,
input [7:0] data_3,
output [15:0] result
);
assign result =data_1+data_2+data_3;
endmodule