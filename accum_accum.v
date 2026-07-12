`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 23:20:51
// Design Name: 
// Module Name: accum_accum
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


module accum_accum(
input rst,
input clk,
input w_en,
input [15:0] data_1,
input [15:0] data_2,
input [15:0] data_3,
output reg [7:0] result,
output reg busy,
output reg en_out
    );
    parameter output_rowlength=14;
    reg [8:0] rowcount;
    reg [16:0] accum1;
    reg [16:0] accum2;
    reg [16:0] accum3;
    reg [1:0] counter_1;
    reg [1:0] counter_2;
    reg [1:0] counter_3;
    reg [1:0] state;
    initial begin 
    state=0;
    busy=0;
    en_out=0;
    end
    always @(posedge clk) begin
    case (state)
    0: begin  //rst state
    if(w_en==1 && rst==0) begin
    accum1<=data_1;
    state<=1;
    rowcount<=0;
    end
    end
    1: begin
    if(rst==1) state<=0;
    else if(w_en==1) begin
    en_out<=0;
    accum2<=data_1;
    accum1<=accum1+data_2;
    counter_1<=2;
    counter_2<=1;
    counter_3<=0;
    state<=2;
    end
    end
    2: begin 
    if(rst==1) state<=0;
    else if(w_en==1) begin
    if(rowcount==output_rowlength-1)begin
    rowcount<=0;
     state<=1;
     accum1<=data_1;
     if(counter_1==0)result<=accum1;
     else if(counter_2==0) result<=accum2;
     else result<=accum3;
     end
     else begin
    case (counter_1) 
    0: begin
    accum1<=data_1;
    counter_1<=counter_1+1;
    result<=accum1;
    rowcount<=rowcount+1;
    en_out<=1;
    end
    1:begin 
    accum1<=accum1+data_2;
    counter_1<=counter_1+1;
    end
    2: begin 
    accum1<=accum1+data_3;
    counter_1<=0;
    end
    endcase
    case (counter_2) 
    0: begin
    accum2<=data_1;
    counter_2<=counter_2+1;
    result<=accum2;
    en_out<=1;
    rowcount<=rowcount+1;
    end
    1:begin 
    accum2<=accum2+data_2;
    counter_2<=counter_2+1;
    end
    2: begin 
    accum2<=accum2+data_3;
    counter_2<=0;
    end
    endcase
    case (counter_3) 
    0: begin
    accum3<=data_1;
    counter_3<=counter_3+1;
    result<=accum3;
    if(rowcount!=0) begin
    en_out<=1;
    rowcount<=rowcount+1;
    end
    end
    1:begin 
    accum3<=accum3+data_2;
    counter_3<=counter_3+1;
    end
    2: begin 
    accum3<=accum3+data_3;
    counter_3<=0;
    end
    endcase
    end
    end
    end
    endcase
    if( en_out==1 && w_en==0) en_out<=0;
    end
endmodule
