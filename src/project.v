/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_contador_display (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
    assign uio_out [3:0] = 4'b0000;
  assign uio_oe  = 8'b0000_0000;

    wire [7:0] segmentos;
    wire [3:0] sel_seg;
    //wire [7:0] contador_reg;

    assign uo_out [7:0] = segmentos;
    assign uio_out [7:4] = sel_seg;
    //assign uio_oe [7]=rst_n;
    //assign uio_out [3] = contador_reg[7];
    contador_display contador_display_Unit(

        .clk(clk),
        .rst(rst_n),
        .segmentos(segmentos),
        .sel_seg(sel_seg)
        //.contador_reg(contador_reg)
        
    );
  // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_out [3:0], uio_in [7:0], ui_in [7:0], uio_oe [7:0], 1'b0};

endmodule
