`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:42:11
// Design Name: 
// Module Name: RamWrite
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


module ram_write(input signed [16:0] in1,in2,in3 ,input enable,clk,output reg [11:0] ram_addr,output reg signed [7:0] ram_write_data);
reg signed [16:0] accum1,accum2,accum3;
reg [5:0] counter; //2^n<=rowlength
reg [1:0] counter1,counter2,counter3;
reg init;
reg done;
parameter rowlength=64;
parameter kernelsum=16;
initial begin
    done=0;
    ram_addr=0;
    init=0;
    counter=0;
    counter1=0;
    counter2=2;
    counter3=1;
end
always @(posedge clk) begin
    if(enable==1 && done==0) begin
        case (counter)
        3'd0: begin
            accum1<=in1;
            counter<=1;
            if(init==1) begin
                if(accum2<0) ram_write_data<=0;
                ram_write_data<=((accum2/kernelsum)>255)?8'd255:(accum2/kernelsum); //temp=(rowlength-2)%3) ; if temp=0 counternum=3,temp=1 counternum=1 else counternum=2
                //ram_write_data<=accum3; 
                ram_addr<=ram_addr+1;
            end

        end
        3'd1:begin
            accum1<=accum1+in2;
            accum2<=in1;
            counter<=2;
        end
        3'd2:begin
            accum1<=accum1+in3;
            accum2<=accum2+in2;
            accum3<=in1;
            counter<=3;
        end

        default begin
            case (counter1)
            2'd0:begin
                if(accum1<0) ram_write_data<=0;
                else ram_write_data<=((accum1/kernelsum)>255)?8'd255:(accum1/kernelsum);
                ram_addr<=ram_addr+1;
                accum1<=in1;
                counter1<=1;
            end
            2'd1:begin
                accum1<=accum1+in2;
                counter1<=2;
            end
            2'd2:begin
                accum1<=accum1+in3;
                counter1<=0;
            end
            endcase

            case (counter2)
            2'd0:begin
                if(accum2<0) ram_write_data<=0;
                else ram_write_data<=(accum2/kernelsum>255)?8'd255:accum2/kernelsum;
                ram_addr<=ram_addr+1;
                accum2<=in1;
            end
            2'd1:begin
                accum2<=accum2+in2;
            end
            2'd2:begin
                accum2<=accum2+in3;
            end
            endcase

            case (counter3)
            2'd0:begin
                if(accum3<0) ram_write_data<=0;
                else ram_write_data<=(accum3/kernelsum>255)?8'd255:accum3/kernelsum;
                ram_addr<=ram_addr+1;
                accum3<=in1;
            end
            2'd1:begin
                accum3<=accum3+in2;
            end
            2'd2:begin
                accum3<=accum3+in3;
            end
            endcase  

            if(counter==rowlength-1) begin
                init<=1;
                counter<=0;
                counter1<=0;
                counter2<=2;
                counter3<=1;
            end
            else begin
                counter<=counter+1;
                if(counter1==2) begin
                    counter1<=0;
            end
            else begin
                counter1<=counter1+1;
            end

            if(counter2==2) begin
                counter2<=0;
            end
            else begin
                counter2<=counter2+1;
            end

            if(counter3==2) begin
                counter3<=0;
            end
            else begin
                counter3<=counter3+1;
            end
            end

        end        


       endcase
    end
end

always @(posedge clk) begin
if(ram_addr==(rowlength-2)*(rowlength-2)-1)begin
  done<=1;
  end
 
 
if(init==1) begin
    init<=0;
end
end
endmodule