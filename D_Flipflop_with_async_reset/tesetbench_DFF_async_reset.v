`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2026 11:28:29 AM
// Design Name: 
// Module Name: tb_DFF_async_reset
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


module tb_DFF_async_reset(
    );
    
    reg Data,clk,reset;
    wire Q,Q_bar;
    
    D_FF_wth_async_reset uut (
    .Data(Data),
    .clk(clk),
    .reset(reset),
    .Q(Q),
    .Q_bar(Q_bar)
    );
    
    //clock generation 
    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end 
    
    //task for self checking 
    task check_by_self;
        input expected_Q;
        begin 
            #5;
            if(reset == 0)  begin 
                if((Q == expected_Q) && (Q_bar == ~expected_Q) )
                    $display("Test pass");
                else 
                    $display("Error: expected Q was %b but we got %b at %0t; expected_Qbar was %b but we got %b",expected_Q,Q,$time, ~expected_Q, Q_bar);
                end  
            else 
                if((Q == expected_Q) && (Q_bar == ~expected_Q)) 
                    $display("test pass");
                else 
                    $display("Error: expected Q was %b but we got %b at %0t; expected_Qbar was %b but we got %b",expected_Q,Q,$time, ~expected_Q, Q_bar);
                end  
     endtask
     
     //what to check in task is mentioned here 
     initial begin 
     
         reset = 0;
         #1;
         Data = 1;
         check_by_self(1);
         
         reset = 1;
         #1;
         Data = 1;
         check_by_self(0);
         
         reset = 0;
         #1;
         Data = 1;
         check_by_self(1);
         
         reset = 1;
         #1;
         Data = 1;
         check_by_self(0);
         
         reset = 0;
         #1;
         Data = 0;
         check_by_self(0);
         
         reset = 1;
         #1;
         Data = 0;
         check_by_self(0);
         
    end 
 endmodule 
