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


module uart_con #(parameter DATA_WIDTH = 8,
                  parameter INDEX = 8)
(
    input clk,rst,
    input [INDEX-1:0] idx,
    input [DATA_WIDTH-1:0] data_in,
    input tx_done,
    output reg [INDEX-1:0] cnt,
    output reg enable,
    output reg tx_start,
    output reg [DATA_WIDTH-1:0] out
);

// reg [INDEX-1:0] cnt;
reg [INDEX-1:0] diff;
reg [1:0] state;

localparam [1:0] IDLE = 2'b00, LOAD = 2'b01, WAIT = 2'b10, DONE = 2'b11;

always@(*)begin
    diff = idx - cnt;
end

always@(posedge clk)begin
    if(rst)begin
        out <= 0;
        cnt <= 0;
        // diff <= 0;
        tx_start <= 0;
        enable <= 0;
        state <= IDLE;
    end
    else begin

        tx_start <= 0;
        enable <= 0;

        case(state)
        IDLE:begin
            if(idx > 0)begin
                state <= LOAD;
                enable <= 1'b1;
                cnt <= cnt + 1;
            end
            state <= IDLE;
        end
        LOAD:begin
            enable <= 0;
            tx_start <= 1;
            out <= data_in;
            state <= WAIT;
        end
        WAIT:begin
            if(diff == 0)begin
                state <= DONE;
            end
            if(tx_done)begin
                state <= LOAD;
                enable <= 1'b1;
                cnt <= cnt + 1;
            end
        end
        DONE: begin
            state <= DONE;
        end
        default: state <= IDLE;
        endcase
    end
end
endmodule

