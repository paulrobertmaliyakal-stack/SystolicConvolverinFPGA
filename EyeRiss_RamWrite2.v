module ram_write(input [7:0] in1,in2,in3 ,input enable,clk,output reg ram_write_enable,output reg [4:0] ram_addr,output reg [11:0] ram_write_data);
reg sel1,sel2;
reg [11:0] accum1,accum2,accum3;
reg [1:0] counter,counter1,counter2,counter3;
reg [2:0] counter4; //number of elements in a row
reg stop1,stop2;
initial begin
    sel1=0;
    sel2=0;
    ram_addr=0;
    counter1=0;
    counter2=0;
    counter3=0;
    counter=0;
    counter4=0;
    stop1=0;
    stop2=0;
end
always @(posedge clk) begin

    if(enable==1 && counter4!=5) begin
        case(counter1)
        2'b00:begin
            counter1<=1;
            accum1<=in1;
        end
        2'b01:begin
            counter1<=2;
            accum1<=accum1+in2;
        end
        2'b10: begin
            counter1<=0;
            accum1<=accum1+in3;
            ram_write_enable<=1;
        end
        endcase
        sel1<=1;

        if(sel1==1) begin
        case(counter2)
        2'b00:begin
            counter2<=1;
            accum2<=in1;
        end
        2'b01:begin
            counter2<=2;
            accum2<=accum2+in2;
        end
        2'b10: begin
            counter2<=0;
            accum2<=accum2+in3;
        end
        endcase    
        sel2<=1;        
        end

        if(sel2==1) begin

        case(counter3)
        2'b00:begin
            counter3<=1;
            accum3<=in1;
        end
        2'b01:begin
            counter3<=2;
            accum3<=accum3+in2;
        end
        2'b10: begin
            counter3<=0;
            accum3<=accum3+in3;
        end
        endcase             

        end
end



end

always @(posedge clk) begin
    if(ram_write_enable==1 && enable==1) begin
      
        case (counter)
        2'b00: begin
            counter<=1;
            ram_write_data<=accum1;
        end
        2'b01: begin
            counter<=2;
            ram_write_data<=accum2;
        end
        2'b10: begin
            counter<=0;
            ram_write_data<=accum3;
        end
        endcase
        ram_addr<=ram_addr+1;
      
    end
end

always @(posedge clk) begin
    if(enable==1) begin
    counter4<=counter4+1;
    if(counter4==5) begin
        sel1<=0;
        sel2<=0;
        ram_write_enable<=0;
        counter4<=0;
    end
    end
end


endmodule