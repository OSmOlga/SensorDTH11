`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2024 18:40:34
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


module DHT11(clk, rst, data, en_set, temp, hum);
//module DHT11(clk, rst, data, en_set);
input logic clk, rst; 
inout logic data;

logic data_buf;
logic signal;
logic [39:0] out;
output logic [7:0] temp;
output logic [7:0] hum;
output logic en_set;
         
//Internal counter
logic [1:0]         tmp;
logic [13:0]        num;
logic [13:0]        cnt;
logic [39:0]        out_buff;     

logic clk_1m;
logic [15:0] cnt_1m;

// 1ms clock
always_ff @(posedge clk)
    if (rst)
        begin
                        clk_1m <= 1'd0;
                        cnt_1m <= 16'd0;
        end
    else
        if (cnt_1m == 16'd49999)
            begin
                        clk_1m <= ~ clk_1m;
                        cnt_1m <= 16'd0;
            end
        else
                        cnt_1m <= cnt_1m + 16'd1;
//2 sec counter
logic [8:0] cnt_signal;

always_ff @(posedge clk_1m or posedge rst)
    if (rst)
        begin
                        signal <= 1'd1;
                        cnt_signal <= 9'd0;
        end
    else
        begin
                        cnt_signal <= cnt_signal + 9'd1;
            if (cnt_signal == 9'd2)
                        signal <= 1'd0;
            else
                if (cnt_signal == 9'd22)
                        signal <= 1'd1;
//                else
//                    if (cnt_signal == 13'd3222)
//                        cnt_signal <= 13'd0;
                        
         end
                        
//enable signal                        
logic [1:0] tmp1;

always_ff @(posedge clk)
    if(rst)
        begin
                        tmp <= 2'd0;
                        tmp1 <= 2'b11;
        end
    else
        begin
                        tmp1 <= {tmp1[0], signal};
                        tmp <= {tmp[0], data};
        end
        
always_ff @(posedge clk)
    if (rst)
                        en_set <= 1'd0;
    else
        begin
            if (tmp1 == 2'b01)
                        en_set <= 1'd1;
            if (tmp1 == 2'b10)
                        en_set <= 1'd0;
        end
        
always_ff @(posedge clk)
    begin
        if (rst)
            begin
                cnt <= 14'd0;
                num <= 14'd0;
            end
        else
            begin
                if ((tmp[0]&~tmp[1])|(~tmp[0]&tmp[1]))
                    begin
                        num <= cnt + 13'd1;
                        cnt <= 14'd0;
                    end
                else
                    begin
                        cnt <= cnt + 14'd1;
                        num <= 14'd0;
                    end
           end
    end
logic [1:0] flag;
logic [5:0] i;

always_ff @(posedge clk)
    if(~en_set)
        begin
                        flag <= 2'd0;
                        out_buff <= 40'd0;
                        i <= 6'd0;
        end
    else
        begin
            case(num) inside
                [14'd8500:14'd9000]: flag <= {flag[0], 1'd1};
                [14'd2500:14'd2700]: if(&flag)
                    begin
                        out_buff <= {out_buff[38:0], 1'd0};
                        i <= i + 6'd1;
                    end
                [14'd7600:14'd8200]: if(&flag)
                    begin
                        out_buff <= {out_buff[38:0], 1'd1};
                        i <= i + 6'd1;
                    end
            endcase
//            if (i == 6'd40)
//                i <= 6'd0;
        end    

//Temperature and humidity  
logic [7:0] temp_buff;
logic [7:0] hum_buff;
logic [7:0] sum;
logic [7:0] ch_sum;

always_ff @(posedge clk)
    if (i == 6'd40)
        begin
            hum_buff <= out_buff [39:32];
            temp_buff <= out_buff [23:16];
            sum <= out_buff[7:0];
            ch_sum <= temp_buff + hum_buff;
            if (sum == ch_sum)
                begin
                    temp <= temp_buff;
                    hum <= hum_buff;
                end
            else
                begin
                    temp <= 8'd0;
                    hum <= 8'd0;
                end
         end       
     
//Data inout port
always_ff @(posedge clk)
        if (rst)
                        data_buf <= '0;
        else
            if (en_set)
                        data_buf <= data;
            else
                        data_buf <= signal;
    
 
 assign data = (en_set)? 'bz : data_buf;

endmodule
