module ram(input clk,input [11:0] addr,output reg [7:0] data_out);
reg [7:0] data [4095:0] ;
initial begin
data[0]=8'd142;
data[1]=8'd53;
data[2]=8'd201;
data[3]=8'd18;
data[4]=8'd255;
data[5]=8'd97;
data[6]=8'd12;
data[7]=8'd188;

data[8]=8'd64;
data[9]=8'd230;
data[10]=8'd149;
data[11]=8'd87;
data[12]=8'd12;
data[13]=8'd204;
data[14]=8'd33;
data[15]=8'd175;

data[16]=8'd92;
data[17]=8'd11;
data[18]=8'd255;
data[19]=8'd133;
data[20]=8'd78;
data[21]=8'd6;
data[22]=8'd167;
data[23]=8'd44;

data[24]=8'd210;
data[25]=8'd58;
data[26]=8'd120;
data[27]=8'd199;
data[28]=8'd15;
data[29]=8'd33;
data[30]=8'd240;
data[31]=8'd89;

data[32]=8'd77;
data[33]=8'd9;
data[34]=8'd188;
data[35]=8'd134;
data[36]=8'd66;
data[37]=8'd212;
data[38]=8'd41;
data[39]=8'd254;

data[40]=8'd31;
data[41]=8'd144;
data[42]=8'd8;
data[43]=8'd199;
data[44]=8'd120;
data[45]=8'd47;
data[46]=8'd233;
data[47]=8'd95;

data[48]=8'd200;
data[49]=8'd35;
data[50]=8'd110;
data[51]=8'd4;
data[52]=8'd173;
data[53]=8'd88;
data[54]=8'd156;
data[55]=8'd49;

data[56]=8'd245;
data[57]=8'd103;
data[58]=8'd22;
data[59]=8'd71;
data[60]=8'd209;
data[61]=8'd57;
data[62]=8'd182;
data[63]=8'd14;
end
always @(posedge clk) begin
data_out<=data[addr];
end

endmodule