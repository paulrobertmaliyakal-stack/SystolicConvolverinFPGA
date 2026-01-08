//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:41:14
// Design Name: 
// Module Name: RamRead
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


module RamRead(input [7:0] data_in,input clk,output reg [7:0] data_out1,data_out2,data_out3,output reg [11:0] addr,output reg enable_out);

reg [5:0] counter_x ; //2^n >= rowlength (no of rows)
reg [1:0] counter_y ;//2^n >= rowlength of kernel
reg enable;
reg first_read,first_read1;
reg init;
reg [7:0] temp;
parameter rowlength=64; 
reg [7:0] linebuffer2[rowlength-1:0];
reg [7:0] linebuffer3[rowlength-1:0];
integer i;

initial begin
//    linebuffer2[0]=0;
//    linebuffer2[1]=0;
//    linebuffer2[2]=0;
//    linebuffer2[3]=0;
//    linebuffer2[4]=0; 
//    linebuffer3[0]=0;
//    linebuffer3[1]=0;
//    linebuffer3[2]=0;
//    linebuffer3[3]=0;
//    linebuffer3[4]=0;  
    temp=0;   
    first_read1=0;  
    first_read=0;
    addr=4'b0;
    counter_x=0;
    counter_y=0;
    init=1;
    enable=0;
end

always @(posedge clk) begin
if(first_read==0) begin
first_read<=1;
addr<=counter_x+rowlength;
end
else begin
    if(init==1) begin
        case (counter_y)
        2'b00:
        begin
            data_out1<=data_in;
            addr<=counter_x+rowlength*2;
            counter_y<=1;
        end

        2'b01:begin
            data_out2<=data_in;
            if(counter_x!=rowlength-1)begin
            addr<=counter_x+1;
            end
            else addr<=rowlength*3;//number of elements in a row * 3
            counter_y<=2;
        end
        2'b10:begin
            enable<=1;
            data_out3<=data_in;
            enable_out<=1;
            counter_y=0;
            counter_x<=counter_x+1;
            if(counter_x==rowlength-1) begin
            init<=0;
            addr<=addr+1;
            end
            else addr<=counter_x+1+rowlength;
        end
        endcase
    end
    else begin
        enable<=1;
        addr<=addr+1;
        data_out3<=data_in;
        data_out2<=linebuffer3[rowlength-2];
        data_out1<=linebuffer2[rowlength-2];
        enable_out<=1;
    end

end
end
always @(posedge clk)begin //for line buffers
    if(enable==1) begin
        
        temp=linebuffer3[rowlength-1];
        for(i=1;i<rowlength;i=i+1) begin
            linebuffer2[i]<=linebuffer2[i-1];
            linebuffer3[i]<=linebuffer3[i-1];

        end
        if(init==1)begin
        enable<=0;   
        linebuffer2[0]<=data_out2;
        linebuffer3[0]<=data_out3;
        end
        else if(init==0 && first_read1==0)begin
            first_read1<=1;
        linebuffer2[0]<=data_out2;
        linebuffer3[0]<=data_out3;
        end            
        else begin
            linebuffer2[0]<=temp;
            linebuffer3[0]<=data_out3;
        end
    end
end

always @(posedge clk) begin
    if(enable_out==1 && init==1)begin
        enable_out<=0;
    end
end
   

endmodule