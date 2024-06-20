`timescal 1ps/1ps
module testbench();
    // ----------registers-------------
    // device under test
    dds_top dds_top_tb(
        .
    )

// ----------- system signal generator-----------
    always #(37037/2) clk = ~clk;

endmodule