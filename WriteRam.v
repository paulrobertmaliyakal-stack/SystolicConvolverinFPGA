
module writeram(input [4:0] addr,input clk,enable_ram,input [11:0] data_in);
reg [11:0] data [24:0];
always @(posedge clk) begin
    if(enable_ram==1)begin
    data[addr]<=data_in;
    end
end
endmodule