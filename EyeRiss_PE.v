module PE(input [7:0] in1,in2,in3,output  reg signed [16:0] out1,out2,out3);
reg signed [7:0] kernel [8:0];
initial begin
kernel[0]=1;
kernel[1]=2;
kernel[2]=1;
kernel[3]=2;
kernel[4]=4;
kernel[5]=2; 
kernel[6]=1;
kernel[7]=2;
kernel[8]=1;
end
always @(*) begin
out1=(in1 * kernel[0]) + (in2 * kernel[3]) + (in3 * kernel[6]);
out2=(in1 * kernel[1]) + (in2 * kernel[4]) + (in3 * kernel[7]);
out3=(in1 * kernel[2]) + (in2 * kernel[5]) + (in3 * kernel[8]);
end

endmodule