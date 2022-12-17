`timescale 1ns / 1ps

`define clk_period  20

module uart_rx_tb();

//-------------------------------------------------------------------------------
reg clk, rst_n, rx_i;
wire [7:0] data_o;
wire rx_done_o;

//-------------------------------------------------------------------------------
 uart_rx UART_RX(
    clk,
    rst_n,
    rx_i,
    data_o,
    rx_done_o
);

//-------------------------------------------------------------------------------    
initial clk = 1;
    always #(`clk_period/2) clk = ~clk;   

//-------------------------------------------------------------------------------
initial begin
    rst_n = 1; 
    rx_i = 1;
    #`clk_period;
    
    rst_n = 0;     //begin to reset;
    #`clk_period;    
  
    rst_n = 1;     //finish reset;  
    #(`clk_period * 10);  
     
    rx_i = 0;
    #(`clk_period * 10);     //start bit;

    rx_i = 1;                //bit 0;
    #(`clk_period * 10);    

    rx_i = 0;                //bit 1;
    #(`clk_period * 10);        

    rx_i = 1;                //bit 2;
    #(`clk_period * 10);    

    rx_i = 0;                //bit 3;
    #(`clk_period * 10);  

    rx_i = 1;                //bit 4;
    #(`clk_period * 10);    

    rx_i = 0;                //bit 5;
    #(`clk_period * 10);   

    rx_i = 1;                //bit 6;
    #(`clk_period * 10);   

    rx_i = 0;                //bit 7;
    #(`clk_period * 10);     

    rx_i = 1;                //one stop bit;
    #(`clk_period * 10);               
      
    #(`clk_period *20);     

    $stop;       
end  
//waveform generation
initial
begin
$dumpfile("uart_rx_tb.vcd");
$dumpvars();
end
    
//-------------------------------------------------------------------------------
endmodule
