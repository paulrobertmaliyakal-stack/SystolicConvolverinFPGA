//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:44:12
// Design Name: 
// Module Name: WriteRam
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



module writeram(input [11:0] addr,input clk,input [7:0] data_in,input resultdone);
reg [7:0] data [10000:0];
always @(posedge clk) begin
    data[addr]<=data_in;
    if(resultdone==1) begin
    $writememh("output.hex",data);
    end
end


endmodule
