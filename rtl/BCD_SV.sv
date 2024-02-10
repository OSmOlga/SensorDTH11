`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 11:12:02
// Design Name: 
// Module Name: BCD_SV
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


module BCD_SV( clk, rst, bin, bout);

input logic [7:0] bin;
input logic clk;
input logic rst;
output logic [7:0] bout;

logic [7:0] cnt;
logic [7:0] bcd_in;
logic [7:0] bcd_out;
logic [4:0] i;

enum logic [1:0]
{
    Init = 2'b00,
    Shift = 2'b01,
    Add = 2'b10,
    Done = 2'b11
}
state, new_state;

// Logic of perehods

always_comb
begin
case (state)
Init: 
        new_state = Shift;
Shift: 
    if (i == 5'd7)
        new_state = Done;
    else 
        new_state = Add;
Add: 
        new_state = Shift;
Done: 
        new_state = Init;
endcase
end

// sost

always_ff @(posedge clk)
begin
case (state)
Init: 
    begin
        bcd_in <= bin;
        bcd_out <= 1'b0;
        i <= 5'd0;
    end
Shift:
    begin 
        bcd_out <= {bcd_out, bcd_in[7]};
        bcd_in <= {bcd_in[6:0], 1'b0};
        i <= i + 4'd1;
    end
Add:
    begin
    if (bcd_out[3:0] > 3'b100)
        bcd_out[3:0] <= bcd_out[3:0] + 2'b11;
    if (bcd_out[7:4] > 3'b100)
        bcd_out[7:4] <= bcd_out[7:4] + 2'b11;
    end 
Done: 
   bout <= bcd_out;
endcase
end

//State update 
always_ff @(posedge clk)
if (rst)
    state <= Init;
else
    state <= new_state;
endmodule
