module top_module(input clk);
wire [7:0] data_ram,data_out1,data_out2,data_out3;
wire [5:0] ram_write_addr;
wire [5:0] addr;
wire enable_out,ram_write_enable;
wire [7:0] ram_write_data;
wire [16:0] data_out_pe1,data_out_pe2,data_out_pe3;
RamRead inst1( .data_in(data_ram),.clk(clk),.data_out1(data_out1),.data_out2(data_out2),.data_out3(data_out3),.addr(addr),.enable_out(enable_out));
ram inst2(.clk(clk),.addr(addr),.data_out(data_ram));
PE inst3(.in1(data_out1),.in2(data_out2),.in3(data_out3),.out1(data_out_pe1),.out2(data_out_pe2),.out3(data_out_pe3));
ram_write inst4(.in1(data_out_pe1),.in2(data_out_pe2),.in3(data_out_pe3) ,.enable(enable_out),.clk(clk),. ram_addr(ram_write_addr),.ram_write_data(ram_write_data));
writeram inst5(.addr(ram_write_addr),.clk(clk),.data_in(ram_write_data));
endmodule
