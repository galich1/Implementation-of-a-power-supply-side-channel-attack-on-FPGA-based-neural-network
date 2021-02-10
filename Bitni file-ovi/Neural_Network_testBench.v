`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mirko Gali?
// 
// Create Date: 05/10/2020 11:56:23 AM
// Design Name: 
// Module Name: Neural_Network_testBench
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


module Neural_Network_testBench;
    reg clk, rst, byteRecv;
    reg [7:0] byteIn;
    reg [3:0] sw;
    wire trigOut;
    wire [4:0] byteCnt;
    wire [23:0] dataOut;
    
    
    Neural_Network DUT(    
    .clk        (clk),
    .rst        (rst),
    .byteRecv   (byteRecv),
    .byteIn     (byteIn),
    .sw         (sw),
    .trigOut    (trigOut),
    .byteCnt    (byteCnt),
    .dataOut    (dataOut)
    );  
    
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #10;
        rst = 1;
    end
    
    initial begin
            sw = 4'b0;
            #30;
            byteRecv = 1; byteIn = 8'haa; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'hbb; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'hcc; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'hdd; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'hee; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'hff; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h11; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h22; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h33; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h44; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h55; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h66; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h77; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h88; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h99; #2; byteRecv = 0; #10;
            byteRecv = 1; byteIn = 8'h15; #2; byteRecv = 0; #10; 
        
    end
        
        
    
endmodule
