`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 02:36:03 PM
// Design Name: 
// Module Name: D_FF_wth_enable
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


module D_FF_wth_enable(
    input wire Data,
    input wire Enable,
    input clk,
    output reg Q,
    output  Q_bar
    );
    
    always @(posedge clk) begin 
        if (Enable)  
            Q <= Data ;
        else 
            Q <= Q;
    end 
    assign Q_bar = ~Q;
 endmodule 
