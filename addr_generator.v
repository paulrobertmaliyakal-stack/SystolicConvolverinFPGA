module addr_gen(
input rst,
input clk,
input en_in,
output reg [15:0] addr_out
);
initial begin
addr_out<=0;
end
always @(posedge clk) begin 
if(rst==1)addr_out<=0;
else if(en_in==1) addr_out<=addr_out+1;
end
endmodule