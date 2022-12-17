`timescale 1ns / 1ps
`define clk_period  20

module uart_vd_tb();

//-------------------------------------------------------------------------------
reg clk, rst_n;
wire rx, tx;

//-------------------------------------------------------------------------------
uart_top UART_TOP(
    .clk(clk),
    .rst_n(rst_n),
    .rx_i(tx),    
    .tx_o(rx)
);
//-------------------------------------------------------------------------------    
uart_vd UART_VD(
    .rx_i(rx),
    .tx_o(tx)
);
//-------------------------------------------------------------------------------    
initial clk = 1;
    always #(`clk_period/2) clk = ~clk;   

//-------------------------------------------------------------------------------
initial begin
    rst_n = 1; 
    #`clk_period;
    
    rst_n = 0;       //begin to reset;
    #`clk_period;    
    
    rst_n = 1;    
    #(`clk_period);       
     
    #(`clk_period * 250);               
    $stop;
end  

//waveform generation
initial
begin
$dumpfile("uart_vd.vcd");
$dumpvars(1);
end
//-------------------------------------------------------------------------------    

endmodule
