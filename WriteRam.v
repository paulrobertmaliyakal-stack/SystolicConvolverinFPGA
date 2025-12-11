module writeram(input [5:0] addr,input clk,input [11:0] data_in);
reg [7:0] data [63:0];
always @(posedge clk) begin
    data[addr]<=data_in;
end
endmodule