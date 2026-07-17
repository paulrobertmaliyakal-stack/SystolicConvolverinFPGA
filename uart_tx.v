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
        output reg tx_done
    );
    reg baud_clk;
    reg [31:0] clk_count;
    reg trig;
    reg [2:0] state;
    reg [7:0] buffer;
    reg [3:0] index;
    initial begin
    baud_clk=0;
    clk_count=0;
    state=0;
    tx=1;
    end
    
    always@(posedge clk) begin // input clk will be 100Mhz 
    if(clk_count==104169)begin
     clk_count<=clk_count+1;
     trig<=1;
     end 
     else if(clk_count==104170)begin
     clk_count<=0;
     trig<=0;
     end
    else clk_count<=clk_count+1;
    end
    
    always@(posedge clk) begin
    case(state)
    0:begin //waiting for any input
    if(tx_start==1) begin
    buffer<=tx_in;
    state<=1;
    tx_done<=0;
    index<=0;
    tx<=1;
    end
    end
    1:begin  //transmission -send start bit
    if(trig==1)begin
    tx<=0;
    state<=2;
    end
    end
    2:begin //transmission -data
    if(trig==1)begin
    if(index==8) begin
    state<=3;
    tx<=1;
    end
    else 
    begin
    tx<=buffer[index];
    index<=index+1;
    end
    end
    end
    3:begin // transmission done pull tx pin up and set tx_done high
    if(trig==1)begin
    state<=0;
    tx_done<=1;
    tx<=1;
    end
    end
    endcase
    end
    
    endmodule
    
