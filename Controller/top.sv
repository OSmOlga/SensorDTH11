`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 18:41:03
// Design Name: 
// Module Name: top
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


module top(clk, rst, data, en_set, stb, dio, clk1);

input logic clk, rst;
inout logic data;

output logic clk1;

output logic stb, dio;
output logic en_set;

logic [7:0] temp, hum;
logic [7:0] temp_ss, hum_ss;

logic [3:0] temp_ss1, temp_ss2, hum_ss1, hum_ss2;

DHT11 uut (.clk(clk), .rst(rst), .data(data), .en_set(en_set), .temp(temp), .hum(hum));

BCD_SV uut1 (.clk(clk), .rst(rst), .bin(temp), .bout(temp_ss));

BCD_SV uut2 (.clk(clk), .rst(rst), .bin(hum), .bout(hum_ss));

always_comb
    begin
        temp_ss1 = temp_ss [7:4];
        temp_ss2 = temp_ss [3:0];
        hum_ss1 = hum_ss [7:4];
        hum_ss2 = hum_ss [3:0];
    end
logic [7:0] temp1, temp2, hum1, hum2;

encoder en1 (.in(temp_ss1), .out(temp1));
encoder en2 (.in(temp_ss2), .out(temp2));
encoder en3 (.in(hum_ss1), .out(hum1));
encoder en4 (.in(hum_ss2), .out(hum2));

TM1638_fsm ss (.clk(clk), .rst(rst), .clk1(clk1), .dio(dio), .stb(stb), .temp1(temp1), .temp2(temp2), .hum1(hum1), .hum2(hum2));   

endmodule
