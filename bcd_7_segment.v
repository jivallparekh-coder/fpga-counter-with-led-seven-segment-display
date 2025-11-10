`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2025 00:19:35
// Design Name: 
// Module Name: bcd_7_segment
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


module bcd_7_segment(
input clock_100Mhz,
input reset,
output reg [3:0] Anode_Activate,// Active perticular seven segment
output reg [6:0] LED_out // Seven segment
);
reg [3:0] displayed_number; // BCD counter 4 bits, MOD 6 counter 3 bits
reg [26:0] one_second_counter; // 1 Hz , 1 sec clock
always @(posedge clock_100Mhz or posedge reset)
begin
if(reset==1)
one_second_counter <= 0;
else begin
if(one_second_counter>=99999999)
one_second_counter <= 0;
else
one_second_counter <= one_second_counter + 1;
end
end
assign one_second_enable = (one_second_counter==99999999)?1:0;
always @(posedge clock_100Mhz or posedge reset)
begin
if(reset==1)
displayed_number = 0;
else
if (one_second_enable==1)
if ( displayed_number <9)
displayed_number = displayed_number + 1;
else
displayed_number = 0;
end
assign y_SAI = displayed_number;
always @(*)
begin
Anode_Activate=4'b1110; // Active last seven segment
case(displayed_number)
4'b0000: LED_out = 7'b0000001; // "0"
4'b0001: LED_out = 7'b1001111; // "1"
4'b0010: LED_out = 7'b0010010; // "2"
4'b0011: LED_out = 7'b0000110; // "3"
4'b0100: LED_out = 7'b1001100; // "4"
4'b0101: LED_out = 7'b0100100; // "5"
4'b0110: LED_out = 7'b0100000; // "6"
4'b0111: LED_out = 7'b0001111; // "7"
4'b1000: LED_out = 7'b0000000; // "8"
4'b1001: LED_out = 7'b0000100; // "9"
default: LED_out = 7'b0000001; // "0"
endcase
end
endmodule
