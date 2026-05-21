`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module Main_Code(
    input wire [7:0]A,B,
    input wire [6:0]OP_Code,
    input wire carry_in,Borrow_in,
    input wire [3:0]Shift_value,
    output reg Carry_out,Borrow_out,
    output reg [15:0]Result
    );
    
    ///wires required for the logic block///
    wire [7:0]NOT_Output_A,NOT_Output_B,AND_Output,OR_Output;
    wire [7:0]NAND_Output,NOR_Output,XNOR_Output,XOR_Output;
    ////Instantiating the submodules////
    ///logic block////
    Logical LOGIC_unit(
    .A(A),
    .B(B),
    .OP_Code(OP_Code[2:0]),
    .NOT_Output_A(NOT_Output_A),
    .NOT_Output_B(NOT_Output_B),
    .AND_Output(AND_Output),
    .OR_Output(OR_Output),
    .NAND_Output(NAND_Output),
    .NOR_Output(NOR_Output),
    .XOR_Output(XOR_Output),
    .XNOR_Output(XNOR_Output)
    );
    ///logical block instantiation ends here////
    
    ////wires required for arithmetic block///
    wire [15:0] Sum,Difference,Product,Quotient;
    wire [15:0] Reminder,Increment_output,Decrement_output;
    wire Carry,Borrow;
    //////instantiation of arithmetic submodule////
    Arithmetic Arithmetic_unit(
    .A(A),
    .B(B),
    .sign_input(OP_Code[4]),
    .OP_Code(OP_Code[2:0]),
    .Carry(Carry),
    .Borrow(Borrow),
    .Carry_in(carry_in),
    .Borrow_in(Borrow_in),
    .Sum(Sum),
    .Difference(Difference),
    .Product(Product),
    .Quotient(Quotient),
    .Reminder(Reminder),
    .Increment_output(Increment_output),
    .Decrement_output(Decrement_output)
    );
///////Arithmetic block instantiation ends here//////////
////wires required for shifters///
wire [7:0]Logical_Left_Shift,Logical_Right_Shift;
wire [7:0]Arithmetic_Left_Shift,Arithmetic_Right_Shift;
wire [7:0]Barrel_Shift;
wire [7:0]Rotate_left,Rotate_right;
////instantiation of the shifter block///
Shifters Shift_unit(
.A(A),
.sign_input(OP_Code[4]),
.shift_direction(OP_Code[3]),
.OP_Code(OP_Code[2:0]),
.Shift_value(Shift_value),
.Logical_Left_Shift(Logical_Left_Shift),
.Logical_Right_Shift(Logical_Right_Shift),
.Arithmetic_Left_Shift(Arithmetic_Left_Shift),
.Arithmetic_Right_Shift(Arithmetic_Right_Shift),
.Barrel_Shift(Barrel_Shift),
.Rotate_left(Rotate_left),
.Rotate_right(Rotate_right)
);
/////Arithmetic block instantiation ends///
///wires required for compare///
wire Greater_than,Less_than,Equal_to;
////Instantiation of compare block
Compare Comparator_unit (
.A(A),
.B(B),
.sign_input(OP_Code[4]),
.OP_Code(OP_Code[2:0]),
.Greater_than(Greater_than),
.Less_than(Less_than),
.Equal_to(Equal_to)
);

    always @(*) begin 
        Result = 0;
        Carry_out = 0;
        Borrow_out = 0;
        $display("OP_Code received: %b", OP_Code);
        
        case (OP_Code)
            7'b0000000: begin 
                        Result = {8'b0,NOT_Output_A};
                      end
            7'b0000001: begin
                        Result = {8'b0,NOT_Output_B};
                      end
            7'b0000010: begin 
                        Result = {8'b0,AND_Output};
                      end 
            7'b0000011: begin 
                        Result = {8'b0,OR_Output};
                      end
            7'b0000100: begin
                        Result = {8'b0,NAND_Output};
                      end 
            7'b0000101: begin 
                        Result = {8'b0,NOR_Output};
                      end
            7'b0000110: begin 
                        Result = {8'b0,XOR_Output};
                      end
            7'b0000111: begin 
                        Result = {8'b0,XNOR_Output};
                      end
             ///Gates end here/////
            /////arithmetic begins here/////
            7'b0100000: begin 
                        Result = Sum;
                        Carry_out = Carry;
                       end
            7'b0100001: begin 
                        Result = Difference;
                        Borrow_out = Borrow;
                       end
            7'b0100010: begin 
                        Result = Product;
                       end
            7'b0100011: begin 
                        Result = Quotient;
                        ///Reminder = Reminder;
                       end
            7'b0100100: begin 
                        Result = Increment_output;
                       end
            7'b0100101: begin 
                        Result = Decrement_output;
                       end
            7'b0110000: begin 
                        Result = Sum;
                        Carry_out = Carry;
                       end
            7'b0110001: begin 
                        Result = Difference;
                        Borrow_out = Borrow;
                       end
            7'b0110010: begin 
                        Result = Product;
                       end
            7'b0110011: begin 
                        Result = Quotient;
                        ///Reminder = Reminder;
                       end
            7'b0110100: begin 
                        Result = Increment_output;
                       end
            7'b0110101: begin 
                        Result = Decrement_output;
                       end
            /////Arithmetic ends here///
           ////shifting starts here////
            7'b1000000: begin 
                         Result = {8'b0,Logical_Left_Shift};
                        end
            7'b1000001: begin 
                         Result = {8'b0,Logical_Right_Shift};
                        end
            7'b1000010: begin
                         Result = {8'b0,Arithmetic_Left_Shift};
                        end
            7'b1000011: begin 
                         Result = {8'b0,Arithmetic_Right_Shift};
                        end
            7'b1000100: begin 
                         Result = {8'b0,Barrel_Shift};
                        end
            7'b1000101: begin 
                         Result = {8'b0,Rotate_left}; 
                        end
            7'b1000110: begin 
                         Result = {8'b0,Rotate_right};
                        end
            7'b1001100: begin
                         Result = {8'b0, Barrel_Shift};  
                        end
            7'b1010000: begin 
                         Result = {8'b0,Logical_Left_Shift};
                        end
            7'b1010001: begin
                         Result = {8'b0,Logical_Right_Shift};
                         end
            7'b1010010: begin 
                         Result = {8'b0,Arithmetic_Left_Shift};
                        end
            7'b1010011: begin
                         Result = {8'b0,Arithmetic_Right_Shift};
                        end
            7'b1010100: begin 
                        Result = {8'b0,Barrel_Shift};
                        end
            7'b1011100: begin 
                        Result = {8'b0,Barrel_Shift};
                        end
            7'b1010101: begin
                         Result = {8'b0,Rotate_left};
                        end
            7'b1010110: begin 
                         Result = {8'b0,Rotate_right};
                        end
            ///shifting ends here 
            ///comaprision starts here
            7'b1100000: begin
                         Result = {15'b0,Greater_than}; 
                        end
            7'b1100001: begin 
                         Result = {15'b0,Less_than}; 
                        end
            7'b1100010: begin
                         Result = {15'b0,Equal_to}; 
                        end
            7'b1110000: begin 
                         Result = {15'b0,Greater_than}; 
                        end
            7'b1110001: begin 
                         Result = {15'b0,Less_than}; 
                        end
            7'b1110010: begin
                         Result = {15'b0,Equal_to}; 
                        end
            ///comparision ends here 
            default : begin 
                        $display("OP_Code not Valid !!");
                      end 
         endcase
     end                      
endmodule
