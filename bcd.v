`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2025 00:19:35
// Design Name: 
// Module Name: bcd
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


module bcd(
input clock_100Mhz, // 100 MHz clock source on Basys 3 FPGA on W5 pin
input reset, // reset
output reg [3:0] displayed_number // BCD counter 4 bits, MOD 6 counter 3 bits
);
always @(posedge clock_100Mhz or posedge reset)
begin
if(reset==1)
displayed_number = 0;
else if ( displayed_number <9) //MoD 10 counter
displayed_number = displayed_number + 1;
else
displayed_number = 0;
end
endmodule
