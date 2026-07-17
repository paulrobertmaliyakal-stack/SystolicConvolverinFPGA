`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2026 14:51:11
// Design Name: 
// Module Name: uart_con
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_con (
input rst ,
input clk,
input tx_done,
input [7:0] data_in,
input [15:0] addr_in,
output reg en_out_mem,
output reg [15:0] addr_out,
output reg tx_en
);
reg [2:0] state;
initial begin 
state=0;
addr_out<=0;
en_out_mem<=0;
end
always @(posedge clk) begin
case(state)
0:begin // rst state
addr_out<=0;
if(rst==0 && addr_in!=0) state<=1;
end
1: begin // fetch data at addr_out
en_out_mem<=1;
state<=4;
end
4 : begin
state<=2;
end
2:begin
en_out_mem<=0;
if(tx_done==1)begin
tx_en<=1;
addr_out<=addr_out+1;
state<=3;
end

end
3: begin //normal operation
tx_en<=0;
if(addr_out<addr_in)begin
state<=1;
end
end
endcase
end
endmodule

