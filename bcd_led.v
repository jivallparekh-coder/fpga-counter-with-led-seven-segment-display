`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2025 00:19:35
// Design Name: 
// Module Name: bcd_led
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


module bcd_led(
 input clock_100Mhz, // 100 MHz clock source on Basys 3 FPGA on W5 pin
 input reset, // reset
 output [3:0] Y_JSP// Active perticular seven segment
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
 else if (one_second_enable==1)
 if ( displayed_number <9) //MoD 1 counter
 displayed_number = displayed_number + 1;
 else
 displayed_number = 0;
 end

assign Y_JSP = displayed_number;
endmodule



