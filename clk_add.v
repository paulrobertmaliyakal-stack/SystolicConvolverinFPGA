`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:55:15
// Design Name: 
// Module Name: clk_add
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


module clk_add( );
    reg clk;
    reg resultdone=0;
    integer i;
    initial begin
    i=0;
    clk=0;
    for(i=0;i<100000;i=i+1)begin
    #1
    clk=~clk;
    end
    resultdone=1;
    clk=~clk;
    #1
    clk=~clk;
    #1
    clk=~clk;
    #1
    clk=~clk;
    end
    wire [7:0] data_ram,data_out1,data_out2,data_out3;
wire [11:0] ram_write_addr;
wire [11:0] addr;
wire enable_out,ram_write_enable;
wire [7:0] ram_write_data;
wire [16:0] data_out_pe1,data_out_pe2,data_out_pe3;
RamRead inst1( .data_in(data_ram),.clk(clk),.data_out1(data_out1),.data_out2(data_out2),.data_out3(data_out3),.addr(addr),.enable_out(enable_out));
ram inst2(.clk(clk),.addr(addr),.data_out(data_ram));
PE inst3(.in1(data_out1),.in2(data_out2),.in3(data_out3),.out1(data_out_pe1),.out2(data_out_pe2),.out3(data_out_pe3));
ram_write inst4(.in1(data_out_pe1),.in2(data_out_pe2),.in3(data_out_pe3) ,.enable(enable_out),.clk(clk),. ram_addr(ram_write_addr),.ram_write_data(ram_write_data));
writeram inst5(.addr(ram_write_addr),.clk(clk),.data_in(ram_write_data),.resultdone(resultdone));
endmodule