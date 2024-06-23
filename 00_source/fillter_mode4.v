module fillter_mode4(Address_i, Mode_i, Address_o);
    input wire [10:0] Address_i;
    input wire [3:0] Mode_i;
    output reg [10:0] Address_o;

    // always @(*)begin
    //     if((Mode_i == 3'b011 )&& (Address_i<= 800)) Address_o <= 800;
    //     else                            Address_o <= Address_i; 
    // end

    assign Address_o = Address_i;
endmodule