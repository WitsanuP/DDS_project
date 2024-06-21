module oscillator (Fg_CLK, RESETn, Enable, Ready, init1, init2, out1, out2);
    input Fg_CLK;
    input RESETn;
    input Enable;
    input Ready;
    input [31:0] init2;
    input [31:0] init1;

    output reg [31:0] out1;
    output reg [31:0] out2;

    reg [31:0] a;
    reg [31:0] b;
    reg [63:0] c;
    reg [31:0] out;
    reg [31:0] out1_a;

    always @(*)begin //combination
        c       <=  $signed(a)*$signed(out1);
        out1_a  <=  c[60:29];
    end

    always @(*)begin //combination
        out     <= out1_a-out2;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   out1 <= 0;
        else if (Ready)     out1 <= init1; //sin(B)
        else if (Enable)    out1 <= out;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   out2 <= 0;
        else if (Ready)     out2 <= 0;
        else if (Enable)    out2 <= out1;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   a <= 0;
        else if (Ready)     a <= init2;
    end
endmodule