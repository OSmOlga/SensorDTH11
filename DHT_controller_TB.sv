`timescale 1ns / 1ps
//`include INP80ms_TB
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2023 22:46:36
// Design Name: 
// Module Name: DHT_controller_TB
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


module DHT_controller_TB;
//Inputs
logic clk;
logic rst;
wire data;
logic signal;
logic en_set;

//Outputs

logic test;

DHT_controller uut (.clk(clk), .rst(rst), .signal(signal), .en_set(en_set), .data(data));


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
        en_set =1'd0;
        repeat (4) @(posedge clk);
        #150
        en_set = 1'd1;
    end
    initial 
    begin
        signal=1'b0;
     #15
        signal = 1'b1;
        #105
        signal = 1'b0;
        #55
        signal = 1'b1;
      end
      
      initial 
    begin
        test=1'b0;
        #10
        test = 1'b1;
        #100
        test = 1'b0;
        #100
        test = 1'b1;
        #250
        test = 1'b0;
        #50
        test = 1'b1;
      end
assign data = (en_set)? test : 1'dz;
endmodule
