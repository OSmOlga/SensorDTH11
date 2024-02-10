`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 11:15:15
// Design Name: 
// Module Name: BCD_SV_TB
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


module BCD_SV_TB;

//Inputs
logic clk, rst;
logic [7:0] bin;

//Outputs
logic [7:0] bout;

// Instantiate the Unit Under Test (UUT)
BCD_SV uut (.clk(clk), .rst(rst), .bin(bin), .bout(bout));
// Initialize Inputs
initial
    begin
    clk = 1'd0;
    forever #5 clk = ~clk;
    end
    
initial
    begin
        rst = 1'd0;
        repeat (2) @ (posedge clk);
        rst = 1'd1;
        repeat (2) @ (posedge clk);
        rst = 1'd0;
    end
    
initial
    begin
        bin = 8'b0011_1111;
 
    end
    
endmodule
