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


module TM1638_fsm(clk, rst, clk1, dio, stb, temp1, temp2, hum1, hum2);

input logic clk, rst;
input logic [7:0] temp1, temp2, hum1, hum2;

output logic stb;
output logic dio;
output logic clk1;

logic [7:0] cnt;
logic clk_2u;
logic rst_2u;
logic [2:0] tmp;

always_ff @(posedge clk)
    begin
        if (rst)
            begin
                cnt <= 8'd0;
                clk_2u <= 1'd0;
                rst_2u <= 1'd1;
                tmp <= 3'd0;
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
            Done:
                if (p == 3'd5)          new_state <= Init;
         
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
                    if (i == 16'd65534)
                        begin
                                                    i <= 16'd0;
                                                    p <= 3'd5;
                        end           
                end

        endcase
    end
logic [7:0] index;
logic tmp_d;

always_ff @(posedge clk_2u or posedge rst)
    if (rst)
        tmp_d <= 1'd0;
    else
        if(p == 3'd5)
            tmp_d <= 1'd1;
        else tmp_d <= 1'd0;
    
    
localparam [7:0]
cmd1 = 8'b0000_0010,
cmd3 = 8'b1111_0001;

localparam [0:7]
cmd2 = 8'b0000_0011;

logic [0:7] data_t = 8'b0001_1110;
logic [0:7] data = 8'b0001_0000;
logic [0:7] data_h = 8'b0010_1110;

logic [0:151] data_buff;
logic [7:0] d_s;

always_ff @(posedge tmp_d or posedge rst)
    if (rst)
        begin
            d_s <= 8'd1;
            data_buff <= 152'd0;
        end
    else
        begin
            d_s <= {d_s[6:0], d_s[7]};
            data_buff <= {cmd1, cmd2, data_t, {8{d_s[0]}}, data, {8{d_s[1]}}, temp1, {8{d_s[2]}}, temp2, {8{d_s[3]}}, data_h, {8{d_s[4]}}, data, {8{d_s[5]}}, hum1, {8{d_s[6]}}, hum2, {8{d_s[7]}}, cmd3};
        end  
  
always_ff @(negedge clk1 or posedge rst)
        if (rst)
            begin
                                                    dio <= 1'd0;
                                                    index <= 8'd0;
            end
        else
            begin
                                                     dio <= data_buff[index];
                                                     index <= index + 8'd1;
              if (index == 8'd151)
                                                     index <= 8'd0;                        
            end
    

//state update
always_ff @(posedge clk_2u)
    if (rst_2u)
            state <= Init; 
    else
        state <= new_state;
endmodule