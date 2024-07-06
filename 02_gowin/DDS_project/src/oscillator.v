module oscillator (Fg_CLK, RESETn, Enable, Ready, init1, init2, Mode, freqchange, out1, out2);
    input Fg_CLK;
    input RESETn;
    input Enable;
    input Ready;
    input [31:0] init1;//sin1x
    input [31:0] init2;//cos2x

    input [3:0]Mode;
    input freqchange;

    output reg [31:0] out1;
    output reg [31:0] out2;

    reg [31:0] a;
    reg [31:0] b;
    reg [63:0] c;
    reg [31:0] out;
    reg [31:0] out1_a;
    
    reg zcross;
    reg dir;
    reg do_update;
    reg update_wait;

    always @(*)begin //combination
        c       <=  $signed(a)*$signed(out1);
        out1_a  <=  c[60:29];
    end

    always @(*)begin //combination
        out     <= out1_a-out2;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   out1 <= 0;
        else if (Ready | do_update)     begin
            // out1 <= init1; //sin(B)
            if (dir) out1 <= init1;
            else     out1 <= ~init1 + 1;
        end
        else if (Enable)    out1 <= out;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   out2 <= 0;
        else if (Ready | do_update)     out2 <= 0;
        else if (Enable)    out2 <= out1;
    end

    always @(posedge Fg_CLK or negedge RESETn)begin //sequential
        if      (~RESETn)   a <= 0;
        else if (Ready | do_update)     a <= init2;
    end

    //zcross crossing
    always @(*)begin 
        
            if (Mode == 4) begin //mode 4
            if((out1 [31:23] == 9'd0)||(out1 [31:23] == {9{1'b1}})) zcross <= 1;
            else zcross <= 0;
        end
        else begin //mode 0-3
            if((out1 [31:22] == 10'd0)||(out1 [31:22] == {10{1'b1}})) zcross <= 1;
            else zcross <= 0;
        end
        
    end

    //dir 
    always @(*)begin 
        if (out2[31]) dir <= 1; //up
        else          dir <= 0; //down
    end

    always @(posedge Fg_CLK or negedge RESETn)begin 
        if      (~RESETn)    update_wait <= 0;
        else if (freqchange) update_wait <= 1;
        else if (do_update)     update_wait <= 0;
    end

    always @(*)begin //combination
        if(zcross & update_wait) do_update <= 1;
        else do_update <= 0;
    end
endmodule