`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 13:33:23
// Design Name: 
// Module Name: line_buffer
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


module linebuffer(
    input rst,
    input clk,
    input w_en,
    input busy,
    input [7:0] datain,
    output reg en_out,
    output reg [7:0] out_1,
    output reg [7:0] out_2,
    output reg [7:0] out_3,
    output reg buffer_fill
);

parameter rowlength=16;
parameter buffersize=6;
reg [7:0] linebuffer_1[rowlength-1:0];
reg [7:0] linebuffer_2[rowlength-1:0];
reg [7:0] linebuffer_3[2:0];
reg [3:0] rowindex;
reg [2:0] state;
integer i;
initial begin
    en_out=0;
    buffer_fill=0;
    rowindex=rowlength-1;
    state=0;
end
always@(*) begin
out_1=linebuffer_1[rowlength-1];
out_2=linebuffer_2[rowlength-1];
out_3=linebuffer_3[0];
end
always@(posedge clk) begin
    case(state)
    0: begin //rst state
    if(rst==1) begin
        rowindex<=rowlength-1;  
    end
    else if(w_en==1)begin
        state<=1;
        linebuffer_1[rowindex]<=datain;
        rowindex<=rowindex-1;
    end
    end
    1: begin // filling row 1
    if(rst==1)state<=0;
    else if(w_en==1) begin
    linebuffer_1[rowindex]<=datain;
    if(rowindex==0) begin
    rowindex<=rowlength-1;
    state<=2;
    end
    else rowindex<=rowindex-1;
    end
    end
    2:begin //filling row 2
        if(rst==1)state<=0;
        else if(w_en==1) begin
        linebuffer_2[rowindex]<=datain;
        rowindex<=rowindex-1;
        if(rowindex==0) begin
            state<=3;
        end
        end
    end
    3: begin //filling 0th elemant in the line buffer3
        if(w_en==1 && busy==0)begin
            linebuffer_3[0]<=datain;
            state<=4;
            rowindex<=1;
            en_out<=1;
        end
    end
    4: begin  //normal operation
        if(w_en==1 && busy==0) begin
            en_out<=1;
            for(i=1;i<rowlength;i=i+1)begin
                linebuffer_1[i]<=linebuffer_1[i-1];
                linebuffer_2[i]<=linebuffer_2[i-1];
            end
            linebuffer_1[0]<=linebuffer_2[rowlength-1];
            linebuffer_2[0]<=linebuffer_3[0];
            case(rowindex)
            1:begin
                linebuffer_3[0]<=datain;
            end
            endcase
        end

        if(w_en==1 && busy==1) begin
            case(rowindex)
            1:begin
                linebuffer_3[rowindex]<=datain;
                rowindex<=rowindex+1;
            end
            2:begin
                linebuffer_3[rowindex]<=datain;
                rowindex<=rowindex+1;
                buffer_fill<=1;
            end
            endcase
        end
        if(w_en==0 && busy==0) begin
            en_out<=1;
            for(i=1;i<rowlength;i=i+1)begin
                linebuffer_1[i]<=linebuffer_1[i-1];
                linebuffer_2[i]<=linebuffer_2[i-1];
            end
            linebuffer_1[0]<=linebuffer_2[rowlength-1];
            linebuffer_2[0]<=linebuffer_3[0];
            rowindex<=0;
            case(rowindex)
            1:begin
            state<=3;
            rowindex<=0;
            end
            2:begin
                linebuffer_3[1]<=linebuffer_3[2];
                linebuffer_2[0]<=linebuffer_3[1];
                buffer_fill<=0;
            end
            endcase
        end
    end
    endcase
end
always@(posedge clk) begin
    if(en_out==1 && busy==0 && w_en==0) begin
        en_out<=0;
    end
end
endmodule
