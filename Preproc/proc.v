`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 20:33:27
// Design Name: 
// Module Name: proc
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


`timescale 1ns / 1ps

module image_proc_top #(
    parameter IMG_WIDTH  = 1280,
    parameter IMG_HEIGHT = 720,
    parameter DATA_WIDTH = 24,
    parameter ADDR_WIDTH = 20
)(
    input  wire clk,
    input  wire rst,
    output reg [ADDR_WIDTH-1:0] rd_addr,
    input  wire [DATA_WIDTH-1:0] rd_data,
    output reg [ADDR_WIDTH-1:0] wr_addr,
    output reg [7:0]            wr_data,
    output reg                  wr_en,
    output reg                  done_tick
);

    localparam IMG_SIZE = IMG_WIDTH * IMG_HEIGHT;
    
    reg [ADDR_WIDTH-1:0] pixel_counter;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_addr <= 0;
            wr_addr <= 0;
            pixel_counter <= 0;
            wr_en <= 0;
            done_tick <= 0;
        end else begin
            if (rd_addr < IMG_SIZE)
                rd_addr <= rd_addr + 1;
                
            if (pixel_counter < IMG_SIZE + 2*IMG_WIDTH + 10) 
                pixel_counter <= pixel_counter + 1;
                
            if (pixel_counter > (2 * IMG_WIDTH + 2)) begin
                if (wr_addr < IMG_SIZE) begin
                    wr_en <= 1;
                    wr_addr <= wr_addr + 1;
                end else begin
                    wr_en <= 0;
                    done_tick <= 1;
                end
            end
        end
    end

    reg [7:0] gray_pixel;
    wire [7:0] r, g, b;
    assign r = rd_data[23:16];
    assign g = rd_data[15:8];
    assign b = rd_data[7:0];
    
    always @(posedge clk) begin
        gray_pixel <= (r * 77 + g * 150 + b * 29) >> 8;
    end

    reg [7:0] lb0 [0:IMG_WIDTH-1];
    reg [7:0] lb1 [0:IMG_WIDTH-1];
    reg [10:0] col_ptr;
    
    reg [7:0] lb0_out, lb1_out;
    
    always @(posedge clk) begin
        if (rst) col_ptr <= 0;
        else begin
            if (col_ptr == IMG_WIDTH - 1) col_ptr <= 0;
            else col_ptr <= col_ptr + 1;
        end
    end
    
    always @(posedge clk) begin
        lb0_out <= lb0[col_ptr];
        lb1_out <= lb1[col_ptr];
        
        lb0[col_ptr] <= gray_pixel;
        lb1[col_ptr] <= lb0_out;
    end

    reg [7:0] w0_0, w0_1, w0_2;
    reg [7:0] w1_0, w1_1, w1_2;
    reg [7:0] w2_0, w2_1, w2_2;
    
    always @(posedge clk) begin
        w0_0 <= w0_1; w0_1 <= w0_2; w0_2 <= lb1_out;
        w1_0 <= w1_1; w1_1 <= w1_2; w1_2 <= lb0_out;
        w2_0 <= w2_1; w2_1 <= w2_2; w2_2 <= gray_pixel;
    end

    reg [11:0] sum;
    
    always @(posedge clk) begin
        sum <= (1*w0_0 + 2*w0_1 + 1*w0_2 +
                2*w1_0 + 4*w1_1 + 2*w1_2 +
                1*w2_0 + 2*w2_1 + 1*w2_2);
    end
    
    always @(posedge clk) begin
        wr_data <= sum[11:4]; 
    end

endmodule
