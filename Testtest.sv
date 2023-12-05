`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2023 20:41:54
// Design Name: 
// Module Name: Testtest
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


module Testtest(clk, rst, en_set, inp, out);

input logic clk, rst, en_set;
input logic inp;
output logic [1:0] out;

logic [12:0] cnt;
logic [1:0] tmp;
logic [12:0] num;
// Internal counter
always_ff @(posedge clk)
    if (rst)
        begin
        cnt <= 13'd0;
        end
    else
        cnt <= cnt + 13'd1;

always_ff @(posedge clk)
    if (rst)
        tmp <= 2'd0;
    else
        tmp <= {tmp[0], inp};
        
assign out = tmp;

endmodule