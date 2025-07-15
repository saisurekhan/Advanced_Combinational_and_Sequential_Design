`timescale 1ns / 1ps
`default_nettype none 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 09:41:43 AM
// Design Name: 
// Module Name: Arithmetic
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


module Arithmetic(
    input wire [7:0]A,B,
    input wire [2:0]OP_Code,
    input wire Carry_in,Borrow_in,
    input wire sign_input,
    output reg [15:0]Sum,
    output reg Carry,Borrow,
    output reg [15:0]Difference,
    output reg [15:0]Product,
    output reg [15:0]Quotient,Reminder,
    output reg [15:0]Increment_output,Decrement_output
    );
    
    integer i;
    reg [8:0]temporary_carry,temporary_Borrow;
    
    always @(*) begin 
        Sum = 0;
        Carry = 0;
        Difference = 0;
        Borrow = 0;
        Quotient = 0;
        Reminder = 0;
        
        case (OP_Code)
            3'b000: begin
                        if(sign_input == 0 | sign_input == 1) begin
                            temporary_carry[0] = Carry_in;
                            for(i = 0;i < 8; i = i+1) begin 
                                Sum[i] = (A[i]^B[i]^temporary_carry[i]);
                                temporary_carry[i+1] = ( (A[i] & B[i]) | (temporary_carry[i] & (A[i] ^ B[i]))); 
                            end
                            Carry = temporary_carry[8]; 
                        end
                    end
            3'b001: begin
                        if(sign_input == 0 | sign_input == 1) begin
                            temporary_Borrow[0] = Borrow_in;
                            for(i = 0; i < 8; i = i + 1) begin
                                Difference[i] = (A[i] ^ B[i] ^ temporary_Borrow[i]);
                                temporary_Borrow[i+1] = ( ((~(A[i])) & B[i]) | (temporary_Borrow[i] & (~(A[i] ^ B[i]))));
                            end
                            Borrow = temporary_Borrow[8];
                        end
                    end
            3'b010: begin 
                        if(sign_input == 0) begin 
                            Product = A*B;
                        end
                        else if(sign_input == 1) begin
                            Product = $signed(A) * $signed(B);
                        end
                    end 
            3'b011: begin 
                        if(sign_input == 0) begin 
                            Quotient = A/B;
                            Reminder = A%B;
                        end 
                        else if(sign_input == 1) begin
                            Quotient = $signed(A) / $signed(B);
                            Reminder = $signed(A) % $signed(B);
                        end
                    end
             3'b100: begin
                        if (sign_input == 0) begin 
                            Increment_output = A + 1;
                        end
                        else if(sign_input == 1) begin 
                            Increment_output = $signed(A) + 1;
                        end 
                     end
             3'b101: begin 
                        if(sign_input == 0) begin 
                            Decrement_output = A - 1;
                        end
                        else if(sign_input == 1) begin 
                            Decrement_output = $signed(A) - 1;
                        end 
                     end
       endcase
    end             
        
endmodule
