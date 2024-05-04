///////////////////
// created by: Noah Limpert, nlimpert@hmc.edu, april 21 2024
// Inpired by David / Sarah Harris DDCA RISCV EDition
// Purpose: general TB for 2 input, 1 output module w/ TV made
// Important things to change, parameter width (line 9/ 10), DUT (ln 19) test vector file (line 29) 
///////////////////

module param_mult_vector_testbench #(
    parameter WIDTH_IN = 8, // CHANGE BASED ON DUT
    parameter WIDTH_OUT = 16)(
    );
    //parameter VEC_LEN = WIDTH_IN*2+WIDTH_OUT; should replace line 17 thing and line 49.
    logic clk, reset;
    logic [WIDTH_IN-1:0] a,b; // CHANGE BASED ON INPUTs 
    logic [WIDTH_OUT-1:0] y, yexpected; // CHANGE BASED ON OUTPUTS
    logic [31:0] vectornum, errors;
    logic [31:0] testvectors[1000:0]; // CHANGE WIDTH BASED ON OUTPUTS

    // Instantiate device under test 
    param_mult dut(a, b, y); // CHANGE BASED ON DUT 

    // generrate clock 
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // At the start of test, load vectors 
    //and pulse reset
    initial begin
        $readmemb("/home/nlimpert/FDCT_VLSI/tests/param_mult_tv.txt", testvectors); //Change based on name of TV
        vectornum = 0; errors = 0;
        reset = 1; #22; reset = 0;
    end

    // apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; {a,b, yexpected} = testvectors[vectornum];  // CHANGE BASED ON Inputs / Expected Outputs 
    end

    //check results on on falling edge of clk 
    always @(negedge clk) begin
        if(~reset) begin // skip during reset
            if(y !== yexpected) begin
                $display("Error: Inputs = %b", {a,b}); // CHANGE BASED ON SET OF INPUTS
                $display(" outputs = %b (%b expected)", y, yexpected);  // CHANGE BASED ON OUTPUTS
                errors = errors + 1;
            end
            vectornum = vectornum +1;
            if(testvectors[vectornum] === 32'bx ) begin // HEYHO THIS 32 NUMBER MAY NEED TO CHANGE
                $display("%d tests completed with %d errors",
                    vectornum, errors);
                $stop;
            end
        end
    end
endmodule
