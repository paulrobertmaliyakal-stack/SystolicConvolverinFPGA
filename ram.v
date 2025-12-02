module ram(input clk,input [4:0] addr,output reg [7:0] data_out);
reg [7:0] data [24:0] ;
initial begin
data[0]=8'd1;
data[1]=8'd2;
data[2]=8'd3;
data[3]=8'd3;
data[4]=8'd4;

data[5]=8'd5;
data[6]=8'd6;
data[7]=8'd7;
data[8]=8'd8;
data[9]=8'd9;

data[10]=8'd10;
data[11]=8'd11;
data[12]=8'd12;
data[13]=8'd12;
data[14]=8'd11;

data[15]=8'd13;
data[16]=8'd14;
data[17]=8'd15;
data[18]=8'd16;
data[19]=8'd17;

data[20]=8'd18;
data[21]=8'd19;
data[22]=8'd20;
data[23]=8'd21;
data[24]=8'd22;
end
always @(posedge clk) begin
data_out<=data[addr];
end

endmodule
