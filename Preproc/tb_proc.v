`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 20:33:41
// Design Name: 
// Module Name: tb_proc
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

module tb_image_proc;

    parameter IMG_WIDTH  = 1280;
    parameter IMG_HEIGHT = 720;
    parameter IMG_SIZE   = IMG_WIDTH * IMG_HEIGHT;

    reg clk;
    reg rst;
    
    wire [19:0] rd_addr;
    reg  [23:0] rd_data; 
    wire [19:0] wr_addr;
    wire [7:0]  wr_data;
    wire        wr_en;
    wire        done_tick;

    reg [23:0] input_ram [0:IMG_SIZE-1]; 
    reg [7:0]  output_ram [0:IMG_SIZE-1];
    
    image_proc_top #(
        .IMG_WIDTH(IMG_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    ) uut (
        .clk(clk),
        .rst(rst),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .wr_en(wr_en),
        .done_tick(done_tick)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    integer f;
    integer i;
    
    initial begin
        $readmemh("C:/Users/Hirthick/Desktop/Preprocessing/image.hex", input_ram); 
        #10;
        if (input_ram[0] === 24'bx) begin
            $display("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            $display("CRITICAL FAILURE: Memory index 0 is XX (Undefined).");
            $display("The file path is WRONG or the file is EMPTY.");
            $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
            $stop;
        end else begin
            $display("\nSUCCESS: Memory loaded! First pixel is: %h", input_ram[0]);
        end
        
        rst = 1;
        #100;
        rst = 0;
        
        wait(done_tick == 1);
        #100;
        
        f = $fopen("C:/Users/Hirthick/Desktop/Preprocessing/processed_image.txt", "w");
        for (i = 0; i < IMG_SIZE; i = i + 1) begin
            $fwrite(f, "%h\n", output_ram[i]);
        end
        $fclose(f);
        
        $finish;
    end

    always @(posedge clk) begin
        rd_data <= input_ram[rd_addr];
    end

    always @(posedge clk) begin
        if (wr_en) begin
            output_ram[wr_addr] <= wr_data;
        end
    end

endmodule
