`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2026 14:50:05
// Design Name: 
// Module Name: uart_tx
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


module uart_tx
(
    input clk,
    input tx_start,
    input [7:0] tx_in,
    output reg tx,
    output tx_done
);

localparam [1:0] idle = 2'b00, send = 2'b01, check = 2'b10;

parameter clk_value = 100_000;
parameter baud = 9600;
parameter wait_count = clk_value/baud;

reg bit_done=0;
integer count = 0;
reg [9:0] tx_data;

reg [1:0]state = idle;

always@(posedge clk)begin
    if(state == idle)begin
        count <= 0;
    end
    else begin
        if(count == wait_count)begin
            bit_done <= 1;
            count <= 0;
        end
        else begin
            bit_done <= 0;
            count <= count + 1;
        end
    end
end

//////////// Transmitter
integer bit_index = 0;

always@(posedge clk)begin
    case(state)
    idle:begin
        bit_index <= 0;
        tx <= 1;
        // tx_done <= 0;
        tx_data <= 0;
        if(tx_start == 1)begin
            tx_data <= {1'b1,tx_in,1'b0};
            state <= send;
        end
        else state <= idle;
    end
    send:begin
            tx <= tx_data[bit_index];
            state <= check;
    end
    check:begin
        if(bit_index == 10)begin
            // tx_done <= 1;
            state <= idle;
        end
        else begin
            if(bit_done == 1)begin
                bit_index <= bit_index + 1;
                state <= send;
            end
        end 
    end
    default: state <= idle;
    endcase
end

assign tx_done = (bit_index == 9 && bit_done == 1)? 1'b1: 1'b0;


endmodule

