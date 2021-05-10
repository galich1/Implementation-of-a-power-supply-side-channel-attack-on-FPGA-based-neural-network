`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mirko Gali?
// 
// Create Date: 05/10/2020 11:49:23 AM
// Design Name: 
// Module Name: Neural_Network
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


(* DONT_TOUCH = "true" *) 
(* use_dsp = "no" *) 
module Neural_Network(
    input clk,
    input rst,
    input byteRecv,
    input [7:0] byteIn,
    input [3:0] sw,
    output reg trigOut,
    output reg [4:0] byteCnt,
    output [23:0] dataOut
    );
    
reg [7:0] inputValue;
reg [7:0] weight [15:0];
reg [15:0] mul;
reg [23:0] result;
reg [23:0] resultInProcces;
reg [4:0] weightCnt;

parameter IDLE  = 6'b000001, RECVBYTE = 6'b000010, WAITBYTE = 6'b000100, MUL = 6'b001000, ADD = 6'b010000, OUTPUT = 6'b100000;

reg [5:0] state;
reg [5:0] nextState;

always @ (*)
begin
    nextState = 6'b000000;
    case(state)
        IDLE:
        begin
            if(byteRecv)
                nextState = RECVBYTE;
            else    
                nextState = IDLE;
        end
        RECVBYTE:
        begin
            nextState=MUL;   
        end
        WAITBYTE:
        begin
            if(byteRecv)
                nextState = RECVBYTE;
            else
                nextState = WAITBYTE;         
        end
        MUL:
        begin
			nextState = ADD;       
        end
        ADD:
        begin
            if(byteCnt == 5'd16)
                nextState = OUTPUT;
            else
                nextState = WAITBYTE;          
        end
        OUTPUT:
        begin
             nextState = IDLE;          
        end
        default:
        begin
            nextState = IDLE;        
        end
     endcase
end

always @ (posedge clk)
begin
    if (rst == 1'b0)
    begin
        state <= IDLE;
    end
    else
    begin
        state <= nextState;
    end        
end

always @ (posedge clk)
begin
    if (rst == 1'b0)
    begin
        weight[0]<=8'b00000001;
        weight[1]<=8'b00000011;
        weight[2]<=8'b00000111;
        weight[3]<=8'b00001111;
        weight[4]<=8'b00011111;
        weight[5]<=8'b00111111;
        weight[6]<=8'b01111111;
        weight[7]<=8'b11111111;
        weight[8]<=8'b10011011;
        weight[9]<=8'b10011001;
        weight[10]<=8'b10011010;
        weight[11]<=8'b10011111;
        weight[12]<=8'b10011110;
        weight[13]<=8'b10011101;
        weight[14]<=8'b10011100;
        weight[15]<=8'b00001111;
        weightCnt<=5'd0;
        trigOut <= 1'b0;
        byteCnt <= 5'b0;
        inputValue <= 7'b0;
        mul <= 15'b0;
        resultInProcces <=23'b0;
		result <= 23'b0;
    end
    else
    begin
        case(state)
            IDLE:
            begin
                weight[0]<=8'b00000001;
                weight[1]<=8'b00000011;
                weight[2]<=8'b00000111;
                weight[3]<=8'b00001111;
                weight[4]<=8'b00011111;
                weight[5]<=8'b00111111;
                weight[6]<=8'b01111111;
                weight[7]<=8'b11111111;
                weight[8]<=8'b10011011;
                weight[9]<=8'b10011001;
                weight[10]<=8'b10011010;
                weight[11]<=8'b10011111;
                weight[12]<=8'b10011110;
                weight[13]<=8'b10011101;
                weight[14]<=8'b10011100;
                weight[15]<=8'b00001111;
                weightCnt<=5'd0;
                trigOut <= 1'b0;
                byteCnt <= 5'b0;
                inputValue <= 7'b0;
                mul <= 15'b0;
                resultInProcces <=23'b0;
                result <= 23'b0;  
            end
            RECVBYTE:
            begin
                trigOut <= 1'b0;
                byteCnt <= byteCnt + 1;
                inputValue <= byteIn;
                mul <= 15'b0;
                resultInProcces <=resultInProcces;
				result <= 23'b0;    
            end
            WAITBYTE:
            begin
                trigOut <= 1'b0;
                byteCnt <= byteCnt;
                inputValue <= inputValue;
                mul <=15'b0;
                resultInProcces <=resultInProcces;
				result <= 23'b0;      
            end
            MUL:
            begin
                trigOut <= 1'b0;
                byteCnt <= byteCnt;
                inputValue <= inputValue;
                mul <= inputValue*weight[weightCnt];
                weightCnt<=weightCnt+1;
				result <= result;
            end
            ADD:
            begin
                trigOut <= 1'b0;
                inputValue <= inputValue;
                mul <= mul;
				resultInProcces <= resultInProcces+mul;  
				result<=result;
            end
            OUTPUT:
            begin
                trigOut <= 1'b1;
                byteCnt <= 5'b0;
                inputValue <= inputValue;
                mul <= mul;
                resultInProcces <= resultInProcces;
				result <= resultInProcces;
            end
            default:
            begin
                trigOut <= 1'b0;
                byteCnt <= 5'b0;
                inputValue <= 7'b0;
                mul <= 5'b0;
				result <= 23'b0;
				resultInProcces <= 23'b0;
            end    
        endcase
        
    end
        
end
assign dataOut = result;
   
endmodule
