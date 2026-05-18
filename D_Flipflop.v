`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 01:47:05 PM
// Design Name: 
// Module Name: D_Flipflop
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


module D_Flipflop(
    input wire Data,
    input wire clk,
    output reg Q,
    output Q_bar
    );
    
    always @(posedge clk) begin 
        Q <= Data;
    end 
   assign Q_bar = ~Q;
  
endmodule
