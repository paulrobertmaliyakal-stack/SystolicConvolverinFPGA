module ram(input clk,input [4:0] addr,output reg [7:0] data_out);
reg [7:0] data [24:0] ;
initial begin
data[0]=8'd1;
data[1]=8'd2;
data[2]=8'd3;
data[3]=8'd2;
data[4]=8'd1;

data[5]=8'd3;
data[6]=8'd4;
data[7]=8'd3;
data[8]=8'd2;
data[9]=8'd0;

data[10]=8'd1;
data[11]=8'd0;
data[12]=8'd1;
data[13]=8'd0;
data[14]=8'd1;

data[15]=8'd4;
data[16]=8'd3;
data[17]=8'd1;
data[18]=8'd2;
data[19]=8'd1;

data[20]=8'd6;
data[21]=8'd1;
data[22]=8'd0;
data[23]=8'd0;
data[24]=8'd1;
end
always @(posedge clk) begin
data_out<=data[addr];
end

endmodule
