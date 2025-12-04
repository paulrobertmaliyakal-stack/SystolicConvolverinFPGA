module ram_write(input [7:0] in1,in2,in3 ,input enable,clk,output reg ram_write_enable,output reg [4:0] ram_addr,output reg [7:0] ram_write_data);
reg [9:0] accum1,accum2,accum3;
reg [2:0] counter;
reg [1:0] counter1,counter2,counter3;
reg init;
initial begin
    init=0;
    counter=0;
    counter1=0;
    counter2=2;
    counter3=1;
end
always @(posedge clk) begin
    if(enable==1) begin
        case (counter)
        3'd0: begin
            accum1<=in1;
            counter<=1;
            if(init==1) begin
                ram_write_data<=(accum3>255)?8'd255:accum3; //needs to be changed accordind to the input matrix
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
                ram_write_data<=(accum1>255)?8'd255:accum1;
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
                ram_write_data<=(accum2>255)?8'd255:accum2;
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
                ram_write_data<=(accum3>255)?8'd255:accum3;
                accum3<=in1;
            end
            2'd1:begin
                accum3<=accum3+in2;
            end
            2'd2:begin
                accum3<=accum3+in3;
            end
            endcase  

            if(counter==4) begin
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
                counter<=0;
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
if(init==1) begin
    init<=0;
end
end
endmodule

