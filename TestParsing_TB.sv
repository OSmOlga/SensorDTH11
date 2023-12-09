`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2023 20:28:18
// Design Name: 
// Module Name: TestParsing_TB
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


module TestParsing_TB;
//Inputs
logic clk, rst, en_set;
logic inp;

//Outputs
logic [39:0] out;


TestParsing uut (.clk(clk), .rst(rst), .en_set(en_set), .inp(inp), .out(out));

initial
    begin
        clk = 1'd0;
        forever #5 clk = ~clk;
    end
    
initial 
    begin
        rst = 1'd0;
        repeat (2) @(posedge clk);
        rst = 1'd1;
        repeat (2) @(posedge clk);
        rst = 1'd0;
    end

      initial 
    begin
        wait(~rst)
        inp=1'b0;
        #18000000
        inp = 1'b1;
        #45000
        inp = 1'b0;
        #80000
        inp = 1'b1;
        #80000
        inp = 1'b0;
        repeat(8)
        begin
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        end
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
         #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
         #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        repeat(10)
        begin
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        end
          repeat(2)
        begin
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        end
          repeat(2)
        begin
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        end
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        repeat (3)
        begin
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        end
        repeat (2)
         begin
        #54000
        inp = 1'b1;
        #70000
        inp = 1'b0;
        end
         repeat (2)
         begin
        #54000
        inp = 1'b1;
        #24000
        inp = 1'b0;
        end
      end

 initial
    begin
        wait (~rst)
        en_set = 1'b0;
        #18000000
        en_set = 1'b1;
    end

endmodule
