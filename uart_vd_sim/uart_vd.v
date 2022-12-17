`timescale 1ns / 1ps
`define clk_period  20

module uart_vd(
    input rx_i,
    output reg tx_o
);

//-------------------------------------------------------------------------------    
reg [7:0] rx_data;
reg [7:0] tx_data;

reg start_bit, stop_bit, rx_done;
//-------------------------------------------------------------------------------
initial
begin
    tx_o = 1;    
    rx_done = 0;
    start_bit = 0;

    rx_data = 8'h00;    
    tx_data = 8'h55;     

    #(`clk_period * 10); 
    tx_task;
end       

//----------------------------------------------------------------------
task tx_task;
    begin
            tx_o = 0;              
            #(`clk_period * 10);      //start bit;

            tx_o = tx_data[0];          //bit 0;
            #(`clk_period * 10);    

            tx_o = tx_data[1];          //bit 1;
            #(`clk_period * 10);       

            tx_o = tx_data[2];          //bit 2;  
            #(`clk_period * 10);    

            tx_o = tx_data[3];          //bit 3;
            #(`clk_period * 10);     

            tx_o = tx_data[4];          //bit 4;
            #(`clk_period * 10);        

            tx_o = tx_data[5];          //bit 5;
            #(`clk_period * 10);           

            tx_o = tx_data[6];          //bit 6;
            #(`clk_period * 10);            

            tx_o = tx_data[7];          //bit 7;
            #(`clk_period * 10);            

            tx_o = 1;                   //stop bit;
            #(`clk_period * 10);         

            tx_o = 1; 
    end
endtask    

//-------------------------------------------------------------------------------    
always @(negedge rx_i)
    begin
        rx_done = 0;
        rx_data = 8'h00;

        #(`clk_period * 5) start_bit = rx_i;
        if ( start_bit == 0 )
        begin
            #(`clk_period * 10);     rx_data[0] = rx_i;
            #(`clk_period * 10);     rx_data[1] = rx_i;
            #(`clk_period * 10);     rx_data[2] = rx_i;
            #(`clk_period * 10);     rx_data[3] = rx_i;
            #(`clk_period * 10);     rx_data[4] = rx_i;
            #(`clk_period * 10);     rx_data[5] = rx_i;       
            #(`clk_period * 10);     rx_data[6] = rx_i;
            #(`clk_period * 10);     rx_data[7] = rx_i;  
            #(`clk_period * 10);     stop_bit   = rx_i;     
            #(`clk_period * 10);     
            if ( stop_bit == 1 )
            begin
                rx_done = 1;
            end else begin
                rx_done = 0;
            end                    
        end
    end   

//-------------------------------------------------------------------------------    
endmodule
