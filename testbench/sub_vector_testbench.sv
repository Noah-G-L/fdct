///////////////////
// created by: Noah Limpert, nlimpert@hmc.edu, april 21 2024
// Inpired by David / Sarah Harris DDCA RISCV EDition
// Purpose: general TB for 2 input, 1 output module w/ TV made
// Important things to change, parameter width (line 9/ 10), DUT (ln 19) test vector file (line 29) 
///////////////////

module sub_vector_testbench #(
    parameter WIDTH_IN = 8,
    parameter WIDTH_OUT = 8)(
    );
    //parameter VEC_LEN = WIDTH_IN*2+WIDTH_OUT; should replace line 17 thing and line 49.
    logic clk, reset;
    logic [WIDTH_IN-1:0] a,b;
    logic [WIDTH_OUT-1:0] y, yexpected;
    logic [31:0] vectornum, errors;
    logic [23:0] testvectors[1000:0];

    // Instantiate device under test 
    sub dut(a, b, y);

    // generrate clock 
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // At the start of test, load vectors 
    //and pulse reset
    initial begin
        $readmemb("/home/nlimpert/FDCT_VLSI/tests/sub_tv.txt", testvectors); 
        vectornum = 0; errors = 0;
        reset = 1; #22; reset = 0;
    end

    // apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; {a,b, yexpected} = testvectors[vectornum];
    end

    //check results on on falling edge of clk 
    always @(negedge clk) begin
        if(~reset) begin // skip during reset
            if(y !== yexpected) begin
                $display("Error: Inputs = %b", {a,b});
                $display(" outputs = %b (%b expected)", y, yexpected);
                errors = errors + 1;
            end
            vectornum = vectornum +1;
            if(testvectors[vectornum] === 24'bx ) begin // HEYHO THIS 25 NUMBER MAY NEED TO CHANGE
                $display("%d tests completed with %d errors",
                    vectornum, errors);
                $stop;
            end
        end
    end
endmodule
