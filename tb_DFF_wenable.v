`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_DFF_wenable(
    );
    
    reg Data,Enable,clk;
    wire Q,Q_bar;
    
    D_FF_wth_enable dut(
    .Data(Data),
    .Enable(Enable),
    .clk(clk),
    .Q(Q),
    .Q_bar(Q_bar)
    );
    
    integer errors; 
    
    //generating clk 
    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end 
    
    //creating task to self check 
    task check_by_self; 
        input expected_Q;
        begin 
            @(posedge clk);
            #1;
            
            if(Q != expected_Q) begin 
                $display("Error: Expected_Q is %b but we got %b at %0t",expected_Q, Q,$time);
                errors = errors + 1;
            end 
            
            if(Q_bar != ~(expected_Q)) begin 
                $display("Error: Expected Q_bar is %b but we got %b at %0t",~expected_Q,Q_bar,$time);
                errors = errors + 1;
            end 
        end 
       endtask  
    
    initial begin 
        errors = 0;
        
        Data = 0;
        Enable = 1;
        check_by_self(0);
        
        Data = 0;
        Enable = 0;
        check_by_self(0);
        
        Data = 1;
        Enable = 1;
        check_by_self(1);
        
        Data = 1;
        Enable = 0;
        check_by_self(1);
        
        Data = 0;
        Enable = 1;
        check_by_self(0);
             
    end   
endmodule
