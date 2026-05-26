`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module DFF_with_sync_reset(
    input wire Data,
    input wire clk,
    input wire sync_reset,
    output reg Q,
    output Q_bar
    );
    
    always @(posedge clk) begin 
        if(sync_reset == 1)  
            Q <= 0;
        else 
            Q <= Data;
    end 
    assign Q_bar = ~Q;

endmodule