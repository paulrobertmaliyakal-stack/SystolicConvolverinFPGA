`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 20:11:54
// Design Name: 
// Module Name: tb
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


module tb(
    );
    reg clk;
    reg rst;
    reg busy;
    convolver_v_1_wrapper dut(
    .clk(clk),
    .rst(rst)
    );
initial begin 
clk=0;
rst=1;
end
always #5 clk=~clk;

initial begin
#100
rst=0;


end


endmodule
