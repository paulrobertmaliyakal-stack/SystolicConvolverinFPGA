module ram(input clk,input [11:0] addr,output reg [7:0] data_out);
reg [7:0] data [4095:0] ;
initial $readmemh("InputImage1.hex",data);
always @(posedge clk) begin
data_out<=data[addr];
end

endmodule