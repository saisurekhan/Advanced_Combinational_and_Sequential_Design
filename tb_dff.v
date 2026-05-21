`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_dff(
    );

reg Data, clk;
wire Q,Q_bar;

integer errors;

D_Flipflop dut(
.Data(Data),
.clk(clk),
.Q(Q),
.Q_bar(Q_bar)
);

//clock generation 
initial begin 
    clk = 0;
    forever #5 clk=~clk;
end 

//self-check task
task check_dff;
    input expected_Q;
    begin 
        @(posedge clk);
        #1;
        
        if(Q != expected_Q) begin 
            $display("Error: expected Q is %b. got Q=%b at time %0t",expected_Q,Q,$time);
            errors = errors + 1;
        end 
        
        if(Q_bar !== ~(expected_Q)) begin 
            $display("Error: Expected Q_bar is %b but got Q_bar = %b at %0t",~expected_Q,Q,$time);
            errors = errors + 1;
        end 
    end 
 endtask 
 
 initial begin 
    errors = 0;
    
    Data = 0;
    check_dff(0);
    
    Data = 1;
    check_dff(1);
    
    Data = 1;
    check_dff(1);
    
    Data = 0;
    check_dff(0);
    
    if(errors == 0)  
        $display("Test pass");
    else 
        $display("test fail with %0d errors",errors); 
    
    $finish;
   end
endmodule   
    
            
