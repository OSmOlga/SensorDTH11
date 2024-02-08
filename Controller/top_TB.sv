`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 18:41:33
// Design Name: 
// Module Name: top_TB
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
module top_TB;
//Inputs
logic clk, rst;

//Inout
wire data;

//Outputs
logic en_set;
logic test;
logic dio, stb, clk1;

top uut (.clk(clk), .rst(rst), .data(data), .en_set(en_set), .stb(stb), .dio(dio), .clk1(clk1));

//tasks
task automatic num_0 (ref logic a);
    int time1;
    int time2;
    int time3;
    time1 = $time;
    #($urandom_range(50_000, 56_000));
        a = 1'b1;
    time2 = $time;
    $display("\n%0d ns zero, time = %0d", time2 - time1, $time);
    #($urandom_range(25_000, 27_000))
        a = 1'b0;
    time3 = $time;
    $display("%0d ns one => ZERO, time = %0d", time3 - time2, $time);
endtask

task automatic num_1 (ref logic a);
    int time1;
    int time2;
    int time3;
    time1 = $time;
    #($urandom_range(50_000, 56_000));
        a = 1'b1;
    time2 = $time;
    $display("\n%0d ns zero, time = %0d", time2 - time1, $time);
    #($urandom_range(76_000, 82_000))
        a = 1'b0;
    time3 = $time;
    $display("%0d ns one => ONE, time = %0d", time3 - time2, $time);
endtask

task automatic inp_num (input logic [0:7] a, ref logic b);
    int i;
    for (i = 0; i < 8; i = i + 1)
        begin
            if (a[i] == 1'd1)
                num_1 (b);
            else 
                num_0 (b);
            $display("\nThe %0d bit has been processed", i);
        end
    $display("\nThe number %0d has been processed", a);
endtask

task automatic set_ht (input logic [0:7] hum, input logic [0:7] temp, ref logic c);
    #45_000
$display ("Initialization was successful, time = %0d", $time);
        c = 1'd0;
    #($urandom_range(85_000, 90000));
        c = 1'b1;
    #($urandom_range(85_000, 90000));
        c = 1'b0;
$display ("\nThe DHT11 is ready to send data, time = %0d", $time);       
    inp_num (hum, c);
    inp_num (8'd0, c);
    inp_num (temp, c);
    inp_num (8'd0, c);
    inp_num (temp + hum, c);
    #51_100
        c = 1'b1;
$display ("\nData from the DHT11 has been transmitted, time = %0d", $time); 
endtask

initial
    begin
        clk = 1'd0;
        forever #5 clk = ~clk;
    end
    
initial 
    begin
        rst = 1'd0;
        repeat (2) @(posedge clk);
        rst = 1'd1;
        repeat (2) @(posedge clk);
        rst = 1'd0;
    end
    
      initial 
    begin
        test=1'b0;
        #9_000_000
        test = 1'b1;
        #8_000_000
        test = 1'b0;
        #1000000
        test = 1'b1;
        
        wait(en_set);
        set_ht (8'd53, 8'd24, test);                
    end   
assign data = (en_set)? test : 1'dz;
endmodule
