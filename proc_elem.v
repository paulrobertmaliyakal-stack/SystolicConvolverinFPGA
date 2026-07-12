module proc_elem (
input [7:0] data,
output [7:0] result
);
parameter weight=1;
assign result=weight*data;
endmodule