`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module Shifters(
    input wire [7:0]A,
    input wire [2:0]OP_Code,
    input wire sign_input,shift_direction,
    input wire [3:0]Shift_value,
    output reg [7:0]Logical_Left_Shift,Logical_Right_Shift,
    output reg [7:0]Arithmetic_Left_Shift,Arithmetic_Right_Shift,
    output reg [7:0]Barrel_Shift,
    output reg [7:0]Rotate_left,Rotate_right
    );
    
    integer Shift;
    
    always @(*) begin 
       Logical_Left_Shift = 0;
       Logical_Right_Shift = 0;
       Arithmetic_Left_Shift = 0;
       Arithmetic_Right_Shift = 0;
       Barrel_Shift = 0;
       Rotate_left = 0;
       Rotate_right = 0;
       Shift = Shift_value;
       
       case (OP_Code)
            3'b000: begin 
                        if(sign_input == 0 | sign_input == 1) begin 
                            Logical_Left_Shift = (A << Shift_value);
                        end
                    end
            3'b001: begin
                        if(sign_input == 0 | sign_input == 1) begin
                            Logical_Right_Shift = (A >> Shift_value);
                        end
                    end
            3'b010: begin
                        if(sign_input == 0) begin 
                            Arithmetic_Left_Shift = (A <<< Shift_value);
                        end
                        else if(sign_input == 1)begin
                            Arithmetic_Left_Shift = ($signed(A) <<< Shift_value);
                        end
                    end
            3'b011: begin
                        if(sign_input == 0) begin 
                            Arithmetic_Right_Shift = (A >>> Shift_value);
                        end
                        else if(sign_input == 1) begin 
                            Arithmetic_Right_Shift = ($signed(A) >>> Shift_value);
                        end
                    end
            3'b100: begin
                        if(shift_direction == 0) begin
                            if(sign_input == 0 | sign_input == 1) begin 
                                Barrel_Shift = (A <<< Shift_value);
                            end
                        end 
                        else if(shift_direction == 1 && sign_input == 0) begin 
                            Barrel_Shift = (A >>> Shift_value);
                        end
                        else if(shift_direction == 1 && sign_input == 1) begin 
                            Barrel_Shift = ($signed(A) >>> Shift_value);
                        end    
                    end
            3'b101: begin 
                        if(sign_input == 0) begin 
                            Rotate_left = (A << Shift) | (A >> (8-Shift));
                        end 
                        else if(sign_input == 1) begin 
                            Rotate_left = ($signed(A) << Shift) | ($signed(A) >> (8-Shift));
                        end
                    end
            3'b110: begin 
                        if(sign_input == 0) begin 
                            Rotate_right = (A >> Shift) | (A << (8-Shift));
                        end
                        else if(sign_input == 1) begin
                            Rotate_right = (A >> Shift) | (A << (8-Shift));
                        end
                    end
          endcase
       end     
endmodule
