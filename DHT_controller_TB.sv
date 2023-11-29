`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2023 23:04:41
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
logic clk, rst;

//Outputs
logic signal;

// Instantiate the Unit Under Test (UUT)
DHT_controller uut (.clk(clk), .rst(rst), .signal(signal));
// Initialize Inputs
initial
    begin
    clk = 1'd0;
    forever #0.5 clk = ~clk;
    end
    
initial
    begin
        rst = 1'd0;
        repeat (2) @ (posedge clk);
        rst = 1'd1;
        repeat (2) @ (posedge clk);
        rst = 1'd0;
    end
    
endmodule
