module interpolator(Fg_CLK, RESETn, out1, out2, Mode, Enable, interpOut);
    input Fg_CLK;
    input RESETn;
    input [31:0] out1;
    input [31:0] out2;
    input [0:3] Mode;
    input Enable;

    output reg [11:0] interpOut; // 12 bit

    reg Enable_delay;
    reg [31:0] delta_y;
    reg [31:0] interpOut_buffer;
    reg [31:0] delta_y_buffer;


    always @(*)begin //combination
        delta_y_buffer <=  $signed(out1-out2)/$signed(10**Mode);
    end

    always@(posedge Fg_CLK or negedge RESETn)begin
        if(~RESETn) Enable_delay <= 0;
        else        Enable_delay <= Enable;
    end

    always@(posedge Fg_CLK or negedge RESETn)begin
        if(~RESETn) delta_y <= 0;
        else        delta_y <= delta_y_buffer;//delta_y <= (out2-out1)/(10**Mode);//! /,** ไม่น่าทำงานได้ ต้องทำใหม่
            

    end

    always @(posedge Fg_CLK or negedge RESETn)begin
        if(~RESETn) begin
            interpOut_buffer <= 0; //! out1, out2 ต้องresetไหม
            interpOut <= 0;

        end
        else if (Enable_delay) begin
            interpOut_buffer <= out2;
            interpOut <= interpOut_buffer[29:18];
        end
        else begin
            
            interpOut_buffer <= interpOut_buffer + delta_y;
            interpOut <= interpOut_buffer[29:18];
        end
    end


endmodule