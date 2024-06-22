`timescale 1ps/1ps

module rotary_tb();

    // ----------- registers -----------
    reg Fg_CLK_tb = 0;
    reg RESETn_tb = 0;
    reg Rot_A_i = 1;
    reg Rot_B_i = 1;
    reg Rot_C_i = 0;
    
    // ----------- wires -----------
    wire [11:0] Adddress_o;
    wire FreqChng_o;

    // ----------- device under test -----------
    rotary rotary_module (
        .Fg_CLK (Fg_CLK_tb), 
        .RESETn (RESETn_tb), 
        .Rot_A  (Rot_A_i), 
        .Rot_B  (Rot_B_i), 
        .Rot_C  (Rot_C_i), 
        
        .Address    (Adddress_o), 
        .FreqChng   (FreqChng_o)
    );

    // ----------- system signal generator-----------
    always #(41_666/2) Fg_CLK_tb = ~Fg_CLK_tb; //24M

    // ----------- test scenarios -----------
    initial begin
        repeat(100)@(posedge Fg_CLK_tb);
        RESETn_tb <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        $display("Starting test");
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 

        repeat(500)@(posedge Fg_CLK_tb);
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 

    repeat(500)@(posedge Fg_CLK_tb);
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(1000)@(posedge Fg_CLK_tb);
    //plus
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(1000)@(posedge Fg_CLK_tb);

    //test Rot_C can loop and increat follow condition
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);


    //plus
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);
        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(10)@(posedge Fg_CLK_tb);
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);

    //plus
    repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 

        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        /////////////////////////
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);
    //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);
    //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);
    //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(100)@(posedge Fg_CLK_tb);
    //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;

    repeat(100)@(posedge Fg_CLK_tb);
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
    repeat(100)@(posedge Fg_CLK_tb);
        
        //minus
        Rot_A_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1; 
    repeat(500)@(posedge Fg_CLK_tb);



//Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);

        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);


        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);


        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);


        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);

        //Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);
//Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//Rot C
        Rot_C_i <= 1;
        repeat(1)@(posedge Fg_CLK_tb);
        Rot_C_i <= 0;
repeat(100)@(posedge Fg_CLK_tb);
//plus
        Rot_B_i <=0 ;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 0;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_B_i <= 1;
        repeat(100)@(posedge Fg_CLK_tb);
        Rot_A_i <= 1; 
        repeat(200)@(posedge Fg_CLK_tb);
       
        
        //plus
        repeat(25)begin
            Rot_B_i <=0 ;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 0;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 1;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 1; 
            repeat(200)@(posedge Fg_CLK_tb);
        end

repeat(10)begin
            //Rot C
            Rot_C_i <= 1;
            repeat(1)@(posedge Fg_CLK_tb);
            Rot_C_i <= 0;
            repeat(10)@(posedge Fg_CLK_tb)
        repeat(100)@(posedge Fg_CLK_tb);
    //pluss
            Rot_B_i <=0 ;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 0;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 1;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 1; 
            repeat(200)@(posedge Fg_CLK_tb);
        end


        repeat(15)begin
            //Rot C
            Rot_C_i <= 1;
            repeat(1)@(posedge Fg_CLK_tb);
            Rot_C_i <= 0;
            repeat(10)@(posedge Fg_CLK_tb)
        repeat(100)@(posedge Fg_CLK_tb);
    //minus
            Rot_A_i <=0 ;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 0;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 1;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 1; 
            repeat(200)@(posedge Fg_CLK_tb);

        end
        repeat(2)begin
            //Rot C
            Rot_C_i <= 1;
            repeat(1)@(posedge Fg_CLK_tb);
            Rot_C_i <= 0;
            repeat(10)@(posedge Fg_CLK_tb)
            repeat(100)@(posedge Fg_CLK_tb);
        end

        //minus
        repeat(25)begin
            Rot_A_i <=0 ;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 0;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_A_i <= 1;
            repeat(100)@(posedge Fg_CLK_tb);
            Rot_B_i <= 1; 
            repeat(200)@(posedge Fg_CLK_tb);
        end
        
        repeat(1000)@(posedge Fg_CLK_tb);$stop;

    end

    // ----------- dumping wave -----------
    initial begin
        $dumpfile("rotary_tb.vcd");
        $dumpvars(0,rotary_tb);
    end
endmodule
