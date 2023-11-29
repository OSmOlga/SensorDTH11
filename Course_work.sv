`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2023 15:58:43
// Design Name: 
// Module Name: CW
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


module CW(clk, rst, data, res);
    input clk, rst, data;
    output res;
logic temp_f;
logic hum_f;
logic [3:0]  data_t;
logic [3:0] data_h;
always_ff @ (posedge clk)
    begin
        if (temp_f)
            data_t <= data;
        if (hum_f)
            data_h <= data;
    end
    
    
endmodule
