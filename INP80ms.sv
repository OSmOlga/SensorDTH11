`timescale 1ns / 1ps
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


module INP80ms(clk, rst, signal);

input logic clk; 
input logic rst;
output logic signal;

logic [20:0] cnt;
logic signal_cnt;

always_ff @(posedge clk)
    begin
        if (rst)
            begin
                cnt <= 21'd0;
                signal_cnt <= 1'd0;
            end            
        else 
            cnt <= cnt + 21'd1;
        if (cnt == 21'd1800000)
            signal_cnt <= 1'd1;
     end
    
assign signal = signal_cnt;
endmodule
