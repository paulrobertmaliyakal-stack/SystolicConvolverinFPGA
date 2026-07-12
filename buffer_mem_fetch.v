`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 19:00:43
// Design Name: 
// Module Name: buffer_mem_fetch
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


module buffer_mem_fetch(
input clk ,
input w_en,
input rst,
input [7:0] data_in,
input busy,
output reg buffer_fill,
output [7:0] data_out_1,
output [7:0] data_out_2,
output [7:0] data_out_3,
output reg en_out
    );
    reg [7:0] temp_buffer [7:0];
    reg [2:0] temp_buffer_index;
    initial begin
    temp_buffer_index=0;
    en_out=0;
    buffer_fill=0;
    end
    assign data_out_1=temp_buffer[0];
    assign data_out_2=temp_buffer[1];
    assign data_out_3=temp_buffer[2];
    always@(posedge clk) begin
    if(rst==1) begin
    temp_buffer_index<=0;
    end
    else begin
    if(temp_buffer_index<2) begin
    if(w_en==1) begin
    temp_buffer_index<=temp_buffer_index+1;
    temp_buffer[temp_buffer_index]<=data_in;
    end
    end
    else if(temp_buffer_index==2)begin
    if(w_en==1)begin
    en_out<=1;
    temp_buffer_index<=temp_buffer_index+1;
    temp_buffer[temp_buffer_index]<=data_in;
    end
    end
    else if(w_en==1 && en_out==0) begin
    case(temp_buffer_index)
    3: begin
    temp_buffer_index<=1;
    temp_buffer[0]<=data_in;
    end
    4: begin
    temp_buffer_index<=2;
    temp_buffer[0]<=temp_buffer[3];
    temp_buffer[1]<=data_in;
    end
    5: begin
    temp_buffer_index<=3;
    temp_buffer[0]<=temp_buffer[3];
    temp_buffer[1]<=temp_buffer[4];
    temp_buffer[2]<=data_in;
    en_out<=1;
    end
    endcase
    end
    else if(w_en==1 && en_out==1) begin
    temp_buffer[temp_buffer_index]<=data_in;
    temp_buffer_index<=temp_buffer_index+1;
    if(temp_buffer_index==4) buffer_fill<=1;
    end
    else if(w_en==0 && en_out==0) begin
    case(temp_buffer_index) 
    3: begin
    temp_buffer_index<=0;
    end
    4: begin
    temp_buffer_index<=1;
    temp_buffer[0]<=temp_buffer[3];
    end
    5:begin 
    temp_buffer_index<=2;
    temp_buffer[0]<=temp_buffer[3];
    temp_buffer[1]<=temp_buffer[4];
    end
    6: begin
    temp_buffer_index<=3;
    temp_buffer[0]<=temp_buffer[3];
    temp_buffer[1]<=temp_buffer[4];
    temp_buffer[2]<=temp_buffer[5];
    buffer_fill<=0;
    en_out<=1;
    end
    endcase
    end
    end
    end
    always @(posedge clk) begin
    if(en_out==1 && busy ==0) en_out<=0;
    end
endmodule
