`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2024 15:49:32
// Design Name: 
// Module Name: TM1638_fsm
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


module TM1638_fsm(clk, rst, clk1, dio, stb);

input logic clk, rst;

(* mark_debug = "true" *)output logic stb;
(* mark_debug = "true" *)output logic dio;
(* mark_debug = "true" *)output logic clk1;

logic [7:0] cnt;
logic clk_2u;
logic rst_2u;
logic rst1;
logic [2:0] tmp;

always_ff @(posedge clk)
    begin
        if (rst)
            begin
                cnt <= 8'd0;
                clk_2u <= 1'd0;
                rst_2u <= 1'd1;
                tmp <= 3'd0;
                rst1 <= 1'd1;
            end
        else
                cnt <= cnt + 8'd1;
        if (cnt == 8'd199)
            begin
                clk_2u <= ~clk_2u;
                cnt <= 8'd0;
                tmp <= tmp + 3'd1;
            end
        if (tmp == 3'd2)
            rst_2u <= 1'd0;
        if (tmp == 3'd7)
            rst1 <= 1'd0;     
    end

logic [15:0] i;
enum logic [2:0]
{
    Init,
    Set_cmd1,
    Set_cmd2,
    Set_data,
    Set_cmd3,
    Done
}
state, new_state;  

logic [2:0] p;
always_ff @(posedge clk_2u)
    begin
        case(state)
            Init:                       new_state <= Set_cmd1;
            Set_cmd1:
                if (p == 3'd1)         new_state <= Set_cmd2;
            Set_cmd2:
                if (p == 3'd2)         new_state <= Set_data;
            Set_data:
                if (p == 3'd3)        new_state <= Set_cmd3;
            Set_cmd3:
                if (p == 3'd4)         new_state <= Done;
//            Done:
//                if (p == 3'd5)          new_state <= Init;
         
        endcase
    end


always_ff @(posedge clk_2u)
    begin
        case(state)
            Init:
                begin
                                                    stb <= 1'd1;
                                                    clk1 <= 1'd1;
                                                    i <= 16'd0;
                                                    p <= 3'd0;
                end
            Set_cmd1:
                begin
                                                    stb <= 1'd0;
                                                    i <= i + 16'd1;
                    if (i > 16'd0 && i < 16'd17)
                                                    clk1 <= ~clk1;
                    if (i == 16'd17)
                        begin
                                                    stb <= 1'd1;
                                                    i <= 16'd0;
                                                    p <= 3'd1;
                        end          
                end
            Set_cmd2:
                begin
                                                    i <= i + 16'd1;
                    if (i > 16'd0)            
                                                    stb <= 1'd0;
                    if (i > 16'd0 && i < 16'd17)
                                                    clk1 <= ~clk1;
                    if (i == 16'd17)
                        begin
                                                    i <= 16'd0;
                                                    p <= 3'd2;
                        end
                end
            Set_data:
                begin
                                                    stb <= 1'd0;
                                                    i <= i + 16'd1;
                    if (i>16'd0 && i < 16'd257)
                                                    clk1 <= ~clk1;
                    if (i == 16'd257)
                        begin
                                                    stb <= 1'd1;
                                                    i <= 16'd0;
                                                    p <= 3'd3;
                        end
                end
            Set_cmd3:
                begin
                                                    i <= i + 16'd1;
                    if (i > 16'd0)      
                                                    stb <= 1'd0;
                    if (i > 16'd1 && i < 16'd17)
                                                    clk1 <= ~clk1;
                    if (i == 16'd1)
                                                    stb <= 1'd1;
                    if (i == 16'd17)
                        begin
                                                    i <= 16'd0;
                                                    p <= 3'd4;
                                                    stb <= 1'd1;
                        end
                end
            Done:
                begin
                                                    i <= i + 16'd1;
                                                    stb <= 1'd1;
                    if (i == 16'd5)
                        begin
                                                    i <= 16'd0;
                                                    p <= 3'd5;
                        end           
                end

        endcase
    end
logic [7:0] index;

localparam [7:0]
cmd1 = 8'b0100_0000,
cmd2 = 8'b1100_0000,
cmd3 = 8'b1000_1111;

logic [0:7] data1 = 8'b1001_1100;
logic [0:7] data2 = 8'b0111_0110;
logic [0:7] data3 = 8'b0110_1110;
logic [0:7] data4 = 8'b1110_1111;

logic [0:127] data_buff = {data1, 8'b0, data2, 8'b1111_1111, data3, 8'b0, data4, 8'b1111_1111, data1, 8'b0, data2, 8'b1111_1111, data3, 8'b0, data4, 8'b1111_1111};

always_ff @(negedge clk1 or posedge rst)
    if (rst)
        begin
            dio <= 1'd0;
            index <= 8'd0;
        end
    else
        begin
        case(state)
            Set_cmd1:
                begin
                                        dio <= cmd1[index];
                                        index <= index + 8'd1;
                    if (index == 8'd7)
                                        index <= 8'd0;
                end
            Set_cmd2:
                begin
                                        dio <= cmd2[index];
                                        index <= index + 8'd1;
                    if (index == 8'd7)
                                        index <= 8'd0;
                end
            Set_cmd3:
                begin
                                        dio <= cmd3[index];
                                        index <= index + 8'd1;
                    if (index == 8'd7)
                                        index <= 8'd0;
                end
            Set_data:
                begin
                                        dio <= data_buff[index];
                                        index <= index + 8'd1;
                    if (index == 8'd127)
                                        index <= 8'd0;
                end
        endcase
        end

//state update
always_ff @(posedge clk_2u)
    if (rst_2u)
            state <= Init; 
    else
        state <= new_state;
endmodule
