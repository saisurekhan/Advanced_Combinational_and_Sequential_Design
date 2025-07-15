`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 11:09:24 AM
// Design Name: 
// Module Name: Compare
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


module Compare(
    input wire [7:0]A,B,
    input wire sign_input,
    input wire [2:0] OP_Code,
    output reg Greater_than,Less_than,Equal_to
    );
    
    always @(*) begin
        Greater_than = 0;
        Less_than = 0;
        Equal_to = 0;
        
        case (OP_Code) 
            3'b000: begin
                        if(sign_input == 0) begin 
                            if(A > B) begin 
                                Greater_than = 1;
                            end
                        end
                        else if(sign_input == 1) begin 
                               if($signed(A) > $signed(B)) begin 
                                    Greater_than = 1;
                               end
                        end
                    end 
            3'b001: begin 
                       if(sign_input == 0) begin 
                            if(A == B) begin 
                                Equal_to = 1;
                            end
                        end
                        else if(sign_input == 1) begin 
                               if($signed(A) == $signed(B)) begin 
                                    Equal_to = 1;
                               end
                        end 
                    end
            3'b010: begin
                        if(sign_input == 0) begin 
                            if(A < B) begin 
                                Less_than = 1;
                            end
                        end
                        else if(sign_input == 1) begin 
                               if($signed(A) < $signed(B)) begin 
                                    Less_than = 1;
                               end
                        end 
                    end
            endcase
     end 
endmodule
