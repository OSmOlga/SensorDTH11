`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 22:43:19
// Design Name: 
// Module Name: encoder_TB
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


module encoder_TB;
logic [3:0] in;
logic [7:0] out;

encoder uut (.in(in), .out(out));

initial begin
in = 4'd8;
#10
in = 4'd0;
#10
in = 4'd3;
end
endmodule
