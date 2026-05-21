`timescale 1ns / 1ps
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
