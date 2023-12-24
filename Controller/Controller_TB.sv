`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2023 16:18:41
// Design Name: 
// Module Name: Controller_TB
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


module Controller_TB;
//Inputs
logic clk, btn, rst;
//Inout
wire data;

//Outputs
logic [7:0] temp, hum;
logic en_set;
logic test;

Controller uut (.clk(clk), .rst(rst), .data(data), .btn(btn), .temp(temp), .hum(hum), .en_set(en_set));

initial
    begin
        btn = 1'd0;
        wait(~rst)
        #1000
        btn = 1'd1;
        #10
        btn = 1'd0;
        #23000000
        btn = 1'd1;
        #10
        btn = 1'd0;
        
     end

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
        test=1'b0;
        #9000000
        test = 1'b1;
        #8000000
        test = 1'b0;
        #1000000
        test = 1'b1;
        #45000
        test = 1'b0;
        #80000
        test = 1'b1;
        #80000
        test = 1'b0;
        
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            end
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            end
        repeat (11)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            end
        repeat (12)
            begin
                #54000
               test = 1'b1;
                #24000;
               test = 1'b0;
            end
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
         repeat (2)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
         repeat (2)
            begin
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            end
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0; 
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
                
                wait(btn)
        test=1'b0;
        #9000000
        test = 1'b1;
        #8000000
        test = 1'b0;
        #1000000
        test = 1'b1;
        #45000
        test = 1'b0;
        #80000
        test = 1'b1;
        #80000
        test = 1'b0;
        
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
                 #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
               #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
        repeat (11)
            begin
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0;
            end
        repeat (2)
            begin
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
                #54000
               test = 1'b1;
                #24000;
               test = 1'b0;
            end
        repeat (11)
            begin
                #54000
               test = 1'b1;
                #24000;
               test = 1'b0;
            end
         repeat (4)
            begin
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
            end
                #54000
                test = 1'b1;
                #24000;
                test = 1'b0; 
                #54000
                test = 1'b1;
                #70000;
                test = 1'b0;
                
    end
    
assign data = (en_set)? test : 1'dz;
endmodule

