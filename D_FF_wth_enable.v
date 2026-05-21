`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
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
