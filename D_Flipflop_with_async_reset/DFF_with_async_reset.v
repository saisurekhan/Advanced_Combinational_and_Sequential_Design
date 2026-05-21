`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module D_FF_wth_async_reset(
    input wire Data,
    input wire clk,
    input wire reset,
    output reg Q,
    output Q_bar);
    
    always @(posedge clk or posedge reset) begin
        if(reset == 1)  
            Q <= 0;
        else 
            Q <= Data;
    end 
    assign Q_bar = ~Q;
 endmodule 