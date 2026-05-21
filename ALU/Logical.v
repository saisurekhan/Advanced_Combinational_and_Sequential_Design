`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module Logical(
    input wire [7:0]A,B,
    input wire [2:0]OP_Code,
    output reg [7:0]NOT_Output_A,NOT_Output_B,AND_Output,OR_Output,
    output reg [7:0]NAND_Output,NOR_Output,XOR_Output,XNOR_Output
    );
    
    always @(*) begin
        NOT_Output_A = 0;
        NOT_Output_B = 0;
        AND_Output = 0;
        OR_Output = 0;
        NAND_Output = 0;
        NOR_Output = 0;
        XOR_Output = 0;
        XNOR_Output = 0;
        
        case (OP_Code)  
            3'b000: begin
                        NOT_Output_A = ~(A);
                    end
            3'b001: begin
                        NOT_Output_B = ~(B);   
                    end
            3'b010: begin
                        AND_Output = (A & B);
                    end
            3'b011: begin
                        OR_Output = (A | B);
                    end
            3'b100: begin
                        NAND_Output = ~(A & B);
                    end
            3'b101: begin
                        NOR_Output = ~(A | B);
                    end
            3'b110: begin 
                        XOR_Output = (A ^ B);
                    end
            3'b111: begin
                        XNOR_Output = ~(A ^ B);
                    end
        endcase 
   end
endmodule
