`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module tb_main_code;

    // DUT Inputs
    reg [7:0] A, B;
    reg [6:0] OP_Code;
    reg [3:0] Shift_value;
    reg carry_in, borrow_in;

    // DUT Outputs
    wire [15:0] Result;
    wire Carry_out, Borrow_out;

    // Instantiate the DUT
    Main_Code uut (
        .A(A),
        .B(B),
        .OP_Code(OP_Code),
        .carry_in(carry_in),
        .Borrow_in(borrow_in),
        .Shift_value(Shift_value),
        .Carry_out(Carry_out),
        .Borrow_out(Borrow_out),
        .Result(Result)
    );

    // Declare test vector arrays (Verilog-style)
    reg [7:0] A_vec [0:9];
    reg [7:0] B_vec [0:9];
    reg [3:0] Shift_val_vec [0:9];
    reg       Carry_in_vec [0:9];
    reg       Borrow_in_vec [0:9];
    reg [6:0] Opcode_vec [0:9];

    integer i;

    initial begin
        // Initialize test vectors
    A_vec[0]        = 8'hF0; B_vec[0] = 8'h0F; Shift_val_vec[0] = 4'd0; Carry_in_vec[0] = 0; Borrow_in_vec[0] = 0; Opcode_vec[0] = 7'b0000000; // AND
    A_vec[1]        = 8'h10; B_vec[1] = 8'h20; Shift_val_vec[1] = 4'd0; Carry_in_vec[1] = 0; Borrow_in_vec[1] = 0; Opcode_vec[1] = 7'b0100000; // ADD (unsigned)
    A_vec[2]        = 8'h80; B_vec[2] = 8'h90; Shift_val_vec[2] = 4'd0; Carry_in_vec[2] = 0; Borrow_in_vec[2] = 0; Opcode_vec[2] = 7'b0110000; // ADD (signed)
    A_vec[3]        = 8'h10; B_vec[3] = 8'h04; Shift_val_vec[3] = 4'd0; Carry_in_vec[3] = 0; Borrow_in_vec[3] = 0; Opcode_vec[3] = 7'b0100011; // DIV (unsigned)
    A_vec[4]        = 8'hAA; B_vec[4] = 8'h00; Shift_val_vec[4] = 4'd2; Carry_in_vec[4] = 0; Borrow_in_vec[4] = 0; Opcode_vec[4] = 7'b1000100; // Barrel Shift Left
    A_vec[5]        = 8'hAA; B_vec[5] = 8'h00; Shift_val_vec[5] = 4'd2; Carry_in_vec[5] = 0; Borrow_in_vec[5] = 0; Opcode_vec[5] = 7'b1001100; // Barrel Shift Right
    A_vec[6]        = 8'hF0; B_vec[6] = 8'h00; Shift_val_vec[6] = 4'd4; Carry_in_vec[6] = 0; Borrow_in_vec[6] = 0; Opcode_vec[6] = 7'b1010011; // ASR (signed)
    A_vec[7]        = 8'h96; B_vec[7] = 8'h00; Shift_val_vec[7] = 4'd1; Carry_in_vec[7] = 0; Borrow_in_vec[7] = 0; Opcode_vec[7] = 7'b1000101; // Rotate Left
    A_vec[8]        = 8'h10; B_vec[8] = 8'h10; Shift_val_vec[8] = 4'd0; Carry_in_vec[8] = 0; Borrow_in_vec[8] = 0; Opcode_vec[8] = 7'b1100000; // Equal (unsigned)
    A_vec[9]        = 8'h90; B_vec[9] = 8'h80; Shift_val_vec[9] = 4'd0; Carry_in_vec[9] = 0; Borrow_in_vec[9] = 0; Opcode_vec[9] = 7'b1110001; // Greater (signed)


        // Run test cases
        for (i = 0; i < 10; i = i + 1) begin
            A           = A_vec[i];
            B           = B_vec[i];
            OP_Code     = Opcode_vec[i];
            Shift_value = Shift_val_vec[i];
            carry_in    = Carry_in_vec[i];
            borrow_in   = Borrow_in_vec[i];

            #10;

            $display("Test %0d: A=%h B=%h OP_Code=%b Shift=%0d | Result=%h Carry=%b Borrow=%b",
                      i, A, B, OP_Code, Shift_value, Result, Carry_out, Borrow_out);
        end

        $finish;
    end

endmodule
