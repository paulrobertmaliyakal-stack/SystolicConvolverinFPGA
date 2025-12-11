//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:43:33
// Design Name: 
// Module Name: ReadRam
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


module ram(input clk,input [5:0] addr,output reg [7:0] data_out);
reg [7:0] data [63:0] ;
initial begin
data[0]=8'd2;
data[1]=8'd5;
data[2]=8'd1;
data[3]=8'd3;
data[4]=8'd0;
data[5]=8'd4;
data[6]=8'd2;
data[7]=8'd6;

data[8]=8'd1;
data[9]=8'd7;
data[10]=8'd3;
data[11]=8'd0;
data[12]=8'd2;
data[13]=8'd5;
data[14]=8'd1;
data[15]=8'd4;

data[16]=8'd6;
data[17]=8'd2;
data[18]=8'd8;
data[19]=8'd1;
data[20]=8'd3;
data[21]=8'd0;
data[22]=8'd4;
data[23]=8'd2;

data[24]=8'd5;
data[25]=8'd1;
data[26]=8'd3;
data[27]=8'd6;
data[28]=8'd0;
data[29]=8'd2;
data[30]=8'd7;
data[31]=8'd1;

data[32]=8'd4;
data[33]=8'd0;
data[34]=8'd5;
data[35]=8'd3;
data[36]=8'd2;
data[37]=8'd6;
data[38]=8'd1;
data[39]=8'd8;

data[40]=8'd2;
data[41]=8'd4;
data[42]=8'd0;
data[43]=8'd5;
data[44]=8'd3;
data[45]=8'd1;
data[46]=8'd7;
data[47]=8'd2;

data[48]=8'd6;
data[49]=8'd1;
data[50]=8'd3;
data[51]=8'd0;
data[52]=8'd4;
data[53]=8'd2;
data[54]=8'd5;
data[55]=8'd1;

data[56]=8'd7;
data[57]=8'd3;
data[58]=8'd0;
data[59]=8'd2;
data[60]=8'd6;
data[61]=8'd1;
data[62]=8'd4;
data[63]=8'd0;
end
always @(posedge clk) begin
data_out<=data[addr];
end

endmodule
