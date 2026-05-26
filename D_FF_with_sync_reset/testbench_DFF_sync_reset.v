`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module tb_DFF_sync_reset(
    );
    
    reg Data,clk,sync_reset;
    wire Q,Q_bar;
    
    DFF_with_sync_reset dut(
    .Data(Data),
    .clk(clk),
    .sync_reset(sync_reset),
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
            if(sync_reset == 1)
                if(expected_Q == Q && Q_bar == ~expected_Q) 
                    $display("test pass");
                else 
                    $display("Error: Expected Q should be %b but we got %b, similarly, expected Q_Bar should be %b but we got %b at %0t", expected_Q,Q,~expected_Q,Q_bar,$time);
            else if(expected_Q == Q && Q_bar == ~expected_Q) 
                    $display("test pass");
                else 
                    $display("Error: Expected Q should be %b but we got %b, similarly, expected Q_Bar should be %b but we got %b at %0t", expected_Q,Q,~expected_Q,Q_bar,$time);
        end 
    endtask 

    ////conditions to check and verify if flipflop is working properly ///
    
    initial begin 
        #2;
        Data = 1;
        sync_reset = 1;
        @(posedge clk);
        #1;
        check_by_self(0);
        
        Data = 0;
        sync_reset = 1;
        @(posedge clk);
        #1;
        check_by_self(0);
        
        Data = 1;
        sync_reset = 0;
        @(posedge clk);
        #1;
        check_by_self(1);
        
        Data = 0;
        sync_reset = 0;
        @(posedge clk);
        #1;
        check_by_self(0);
        
        Data = 0;
        sync_reset = 1;
        @(posedge clk);
        #1;
        check_by_self(0);
    end 
endmodule

