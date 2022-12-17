`timescale 1ns / 1ps
`include "uart_tx.v"
`include "uart_rx.v"
module uart_top(
    input clk,
    input rst_n,
    input rx_i,    
    output tx_o
);

//-------------------------------------------------------------------------------
wire tx_en;
wire [7:0] tx_data;
        
//-------------------------------------------------------------------------------        
uart_rx UART_RX(
    .clk(clk),
    .rst_n(rst_n),
    .rx_i(rx_i),
    .data_o(tx_data),
    .rx_done_o(tx_en)
);

//-------------------------------------------------------------------------------       
uart_tx UART_TX(
    .clk(clk),
    .rst_n(rst_n),
    .en_i(tx_en),
    .data_i(tx_data),
    .tx_o(tx_o),    
    .tx_done_o()
);   

//-------------------------------------------------------------------------------
endmodule
