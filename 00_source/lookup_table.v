module lookup_table(Fg_CLK, RESETn, Address, out1, out2, sin1x, cos2x);
    input Fg_CLK;
    input RESETn;
    input wire [10:0] Address;
    input out1;
    input out2;

    output [31:0] sin1x;
    output [31:0] cos2x;

    // wire [31:0] sin1x;
    // wire [31:0] cos2x;

    wire [47:0] coef;

    coef_prom rom_module(
        .dout(coef), //output [47:0] dout

        .clk(Fg_CLK), //input clk
        .oce(1'd1), //input oce
        .ce(1'd1), //input ce
        .reset(~RESETn), //input reset
        .ad(Address) //input [10:0] ad
    );
   

    assign sin1x = {4'b0000  , coef[47:24], 4'b0000};
    assign cos2x = {6'b001111, coef[23: 0], 2'b00  };


endmodule