module result_addr_gen(
input clk,
input rst,
input  buffer_filled,
output reg w_en_buffer,
output reg [15:0] addr_out,
output reg mem_en
);
reg [3:0] state;
initial begin
state=0;
w_en_buffer=0;
end
always@(posedge clk) begin
case(state)
3'd0:begin // from reset
addr_out<=0;
w_en_buffer<=0;
state<=(rst==1)?0:4;
mem_en<=(rst==1)?0:1;
end
3'd4:begin //one cycle for en of mem
state<=1;
addr_out<=addr_out+1;
end
3'd1:begin  // once clock cycle latency of BRAM
if(rst==1)begin
state<=0;
addr_out<=0;
end
else begin
addr_out<=addr_out+1;
w_en_buffer<=1;
state<=2;
end
end
3'd2:begin  // normal operation
if(rst==1) begin
w_en_buffer<=0;
addr_out<=0;
state<=0;
end
else begin
if (buffer_filled==1)begin
addr_out<=addr_out-1;
w_en_buffer<=0;
mem_en<=0;
state<=3;
end
else begin
addr_out<=addr_out+1;
w_en_buffer<=1;
end
end
end
3'd3:begin  // halt 
if(buffer_filled==0) begin
mem_en<=1;
state<=4;
end
else begin
end

end
endcase
end
endmodule