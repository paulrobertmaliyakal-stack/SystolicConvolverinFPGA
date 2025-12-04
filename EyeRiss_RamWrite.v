
`timescale 1ps / 1ps
module RamWrite(
    input [7:0] out1,
    input [7:0] out2,
    input [7:0] out3,
    input enable,
    output reg [7:0] ram_write_data,
    output reg [1:0] ram_enable_out,
    input clk
    );
    integer i=0;
    reg [2:0] counter1,counter2,counter3;
    reg [7:0] accum1,accum2,accum3;
//    reg accum_en1,accum_en2,accum_en3;
    initial begin
    counter1=0;
    counter2=0;
    counter3=0;
    accum1=0;
    accum2=0;
    accum3=0;
//    accum_en1=1;
//    accum_en2=0;
//    accum_en3=0;
    end
     
    always @(posedge clk) begin
    if(i>-1) begin
    if(counter1==2) begin
    ram_enable_out=1;
    counter1<=0;
    end
    else  counter1<=counter1+1;
    end
    
    if (i>0) begin
    if(counter2==2)  counter2<=0;
    else counter2<=counter2+1;
    end
    
    if(i>1) begin
    if(counter3==2) counter3<=0;
    else counter3<=counter3+1;
    end
    
    
    i=i+1;
    
    
    end
    
    always @(negedge clk) begin
    
    case (counter1) 
    2'b0: accum1=out1;
    2'b01: accum1=accum1+out2;
    2'b10: begin
    accum1=accum1+out3;
    ram_write_data=accum1;
    end
    endcase
    
        case (counter2) 
    2'b0: accum2=out1;
    2'b01: accum2=accum2+out2;
    2'b10:begin
     accum2=accum2+out3;
     ram_write_data=accum2;
     end
    endcase
    
        case (counter3) 
    2'b0: accum3=out1;
    2'b01: accum3=accum3+out2;
    2'b10: begin
    accum3=accum3+out3;
    ram_write_data=accum3;
    end
    endcase
end      
endmodule




