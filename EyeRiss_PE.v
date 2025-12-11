
module PE(input [7:0] in1,in2,in3,output [7:0] out1,out2,out3);
reg [7:0] kernel [8:0];
reg [15:0] temp_out1,temp_out2,temp_out3;
initial begin
kernel[0]=1;
kernel[1]=2;
kernel[2]=3;
kernel[3]=4;
kernel[4]=5;
kernel[5]=6; 
kernel[6]=7;
kernel[7]=8;
kernel[8]=9;
end
always @(*) begin
temp_out1=(in1 * kernel[0]) + (in2 * kernel[3]) + (in3 * kernel[6]);
temp_out2=(in1 * kernel[1]) + (in2 * kernel[4]) + (in3 * kernel[7]);
temp_out3=(in1 * kernel[2]) + (in2 * kernel[5]) + (in3 * kernel[8]);
end

assign out1=(temp_out1>255)?8'd255:temp_out1;
assign out2=(temp_out2>255)?8'd255:temp_out2;
assign out3=(temp_out3>255)?8'd255:temp_out3;

endmodule