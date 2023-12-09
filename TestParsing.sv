`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2023 18:17:39
// Design Name: 
// Module Name: TestParsing
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


module TestParsing(clk, rst, en_set, inp, out);

input logic clk, rst, en_set;
input logic inp;
output logic [39:0] out;

// Internal counter
logic [1:0] tmp;
logic  [12:0] num;
logic [12:0] cnt;
logic [39:0] out_buff;


always_ff @(posedge clk)
    begin
        if (rst)
            begin
                cnt <= 13'd0;
                num <= 13'd0;
            end
        if ((tmp[0]&~tmp[1])|(~tmp[0]&tmp[1]))
            begin
                num <= cnt + 13'd1;
                cnt <= 13'd0;
            end
        else
            begin
                cnt <= cnt + 13'd1;
                num <= 13'd0;
            end
    end
    
always_ff @(posedge clk)
    if (rst)
        begin
        tmp <= 2'd0;
        end
    else
        tmp <= {tmp[0], inp};

//FSM
enum logic [2:0]
{
    Init = 3'd0,
    Wnum = 3'd1,
    P80u = 3'd2,
    WZorO = 3'd3,
    P54u = 3'd4,
    P70u = 3'd5,
    P24u = 3'd6,
    DONE = 3'd7
} state, new_state;

logic [1:0] tmp1;
logic [5:0] i;

always_comb
    begin
    case(state)
        Init:                               new_state = Wnum;
        Wnum:
            if (num == 13'd8000)            new_state = P80u;
        P80u:
            begin
            if (tmp1 == 2'd2)               new_state = WZorO;
            if (tmp1 == 2'd1)               new_state = Wnum;
            end
        WZorO:
            begin
            if (i == 6'd40)                 new_state = DONE;
            if (num == 13'd5400)            new_state = P54u;
            end
        P54u:
            begin
            if (num == 13'd2400)            new_state = P24u;
            if (num == 13'd7000)            new_state = P70u;
            end
        P24u:                               new_state = WZorO;
        P70u:                               new_state = WZorO;
        
    endcase   
    end

always_comb
    begin
    case(state)
        Init:
            begin
                                tmp1 = 2'd0;
                                i    = 6'd0;
            end
        P80u:                   
                                tmp1 = tmp1 + 2'd1;
        P24u:
            begin
                                out_buff = {out_buff[38:0], 1'd0};
                                i = i + 6'd1;
            end
         P70u:
            begin
                                out_buff = {out_buff[38:0], 1'd1};
                                i = i + 6'd1;
            end
            
        DONE:
            out = out_buff;
    endcase   
    end

//State update 
always_ff @(posedge clk)
if (rst)
    state <= Init;
else
    state <= new_state;
endmodule   
        
   

