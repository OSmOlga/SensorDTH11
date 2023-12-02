`timescale 1ns / 1ps
//`include "INP80ms"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2023 23:03:33
// Design Name: 
// Module Name: DHT_controller
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


module DHT_controller(clk, rst, signal, en_set, data);

input logic clk, rst, signal, en_set;
inout logic data;

logic data_buf;

//INP80ms uut (.clk(clk), .rst(rst), .signal(signal));

always_ff @(posedge clk)
    begin
        if (rst)
                data_buf <= '0;
        if (en_set)
                data_buf <= data;
        else
                data_buf <= signal;
    end
 assign data = (en_set)? 'bz : data_buf;
          
endmodule
