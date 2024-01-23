`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2024 16:02:59
// Design Name: 
// Module Name: TM1638_fsm_TB
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


module TM1638_fsm_TB;

logic clk, rst, dio, stb, clk1;
 
TM1638_fsm uut (.clk(clk), .rst(rst), .clk1(clk1), .dio(dio), .stb(stb));

initial
    begin
        clk <= 1'd0;
        forever #5 clk <= ~clk;
    end
    
initial 
    begin
        rst <= 1'd0;
        repeat(2) @(posedge clk);
        rst <= 1'd1;
        repeat(2) @(posedge clk);
        rst <= 1'd0;
    end
endmodule
