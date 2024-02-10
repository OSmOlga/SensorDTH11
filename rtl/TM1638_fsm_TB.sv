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
logic [7:0] temp1, temp2, hum1, hum2; 

TM1638_fsm uut ( .clk(clk), .rst(rst), .clk1(clk1), .dio(dio), .stb(stb), .temp1(temp1), .temp2(temp2), .hum1(hum1), .hum2(hum2));

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
    
initial begin
        temp1 = 8'b1111_0010;
        temp2 = 8'b1101_1010;
        hum1 = 8'b1111_0010;
        hum2 = 8'b1101_1010;       
end
endmodule
