// Arithmetic-logic unit module
module alu_tb
	();
	
	// Parameters
	parameter CNT_TESTS = 44; // cnt of tests
	
	// Test bench variables
	logic clk, reset_tb;
	logic [63 : 0] result_expected;
	logic zero_expected;
	
	int test_number, cnt_errors;
	logic [196 : 0] test [0 : CNT_TESTS-1];
		// {{a}, {b}, {ALUControl}, {result_expected}, {zero_expected}}
	
	// Module connections
	logic [63 : 0] a, b, result;
	logic [3 : 0] ALUControl;
	logic zero;

	alu dut
		(
			.a(a),
			.b(b),
			.ALUControl(ALUControl),
			.result(result),
			.zero(zero)
		);

	// Clock generation with 10ns period
	always begin
		clk = 1; #5ns;
		clk = 0; #5ns;
	end
	
	initial begin
		// Init tests
		test_number = 0;
		cnt_errors = 0;
		
		test = 
			'{
				// Two positive numbers
					// AND
					{{64'd93846573825364758}, {64'd27313240968594}, {4'b0000}, {64'd9715484885266}, {1'b0}},
					{{64'd27313240968594}, {64'd93846573825364758}, {4'b0000}, {64'd9715484885266}, {1'b0}},
					// OR
					{{64'd93846573825364758}, {64'd27313240968594}, {4'b0001}, {64'd93864171581448086}, {1'b0}},
					{{64'd27313240968594}, {64'd93846573825364758}, {4'b0001}, {64'd93864171581448086}, {1'b0}},
					// ADD
					{{64'd93846573825364758}, {64'd27313240968594}, {4'b0010}, {64'd93873887066333352}, {1'b0}},
					{{64'd27313240968594}, {64'd93846573825364758}, {4'b0010}, {64'd93873887066333352}, {1'b0}},
					// SUB
					{{64'd93846573825364758}, {64'd27313240968594}, {4'b0110}, {64'd93819260584396164}, {1'b0}},
					{{64'd27313240968594}, {64'd93846573825364758}, {4'b0110}, {64'd18352924813125155452}, {1'b0}},
					// PASS B
					{{64'd93846573825364758}, {64'd27313240968594}, {4'b0111}, {64'd27313240968594}, {1'b0}},
					{{64'd27313240968594}, {64'd93846573825364758}, {4'b0111}, {64'd93846573825364758}, {1'b0}},
				// Two negative numbers
					// AND
					{{64'd18446743597840186537}, {64'd18408884465879530302}, {4'b0000}, {64'd18408884044972472360}, {1'b0}},
					{{64'd18408884465879530302}, {64'd18446743597840186537}, {4'b0000}, {64'd18408884044972472360}, {1'b0}},
					// OR
					{{64'd18446743597840186537}, {64'd18408884465879530302}, {4'b0001}, {64'd18446744018747244479}, {1'b0}},
					{{64'd18408884465879530302}, {64'd18446743597840186537}, {4'b0001}, {64'd18446744018747244479}, {1'b0}},
					// ADD
					{{64'd18446743597840186537}, {64'd18408884465879530302}, {4'b0010}, {64'd18408883990010165223}, {1'b0}},
					{{64'd18408884465879530302}, {64'd18446743597840186537}, {4'b0010}, {64'd18408883990010165223}, {1'b0}},
					// SUB
					{{64'd18446743597840186537}, {64'd18408884465879530302}, {4'b0110}, {64'd37859131960656235}, {1'b0}},
					{{64'd18408884465879530302}, {64'd18446743597840186537}, {4'b0110}, {64'd18408884941748895381}, {1'b0}},
					// PASS B
					{{64'd18446743597840186537}, {64'd18408884465879530302}, {4'b0111}, {64'd18408884465879530302}, {1'b0}},
					{{64'd18408884465879530302}, {64'd18446743597840186537}, {4'b0111}, {64'd18446743597840186537}, {1'b0}},
				// One positive number and one negative number
					// AND
					{{64'd27586970463758451}, {64'd18441095276975396848}, {4'b0000}, {64'd27586952970666096}, {1'b0}},
					{{64'd18441095276975396848}, {64'd27586970463758451}, {4'b0000}, {64'd27586952970666096}, {1'b0}},
					// OR
					{{64'd27586970463758451}, {64'd18441095276975396848}, {4'b0001}, {64'd18441095294468489203}, {1'b0}},
					{{64'd18441095276975396848}, {64'd27586970463758451}, {4'b0001}, {64'd18441095294468489203}, {1'b0}},
					// ADD
					{{64'd27586970463758451}, {64'd18441095276975396848}, {4'b0010}, {64'd21938173729603683}, {1'b0}},
					{{64'd18441095276975396848}, {64'd27586970463758451}, {4'b0010}, {64'd21938173729603683}, {1'b0}},
					// SUB
					{{64'd27586970463758451}, {64'd18441095276975396848}, {4'b0110}, {64'd33235767197913219}, {1'b0}},
					{{64'd18441095276975396848}, {64'd27586970463758451}, {4'b0110}, {64'd18413508306511638397}, {1'b0}},
					// PASS B
					{{64'd27586970463758451}, {64'd18441095276975396848}, {4'b0111}, {64'd18441095276975396848}, {1'b0}},
					{{64'd18441095276975396848}, {64'd27586970463758451}, {4'b0111}, {64'd27586970463758451}, {1'b0}},
				// Overflow result
					// ADD
					// the real result is 9223372036854775809 but in 64-bit representation we get -9223372036854775807
					{{64'd9223372036854775807}, {64'd2}, {4'b0010}, {64'd9223372036854775809}, {1'b0}},
					{{64'd2}, {64'd9223372036854775807}, {4'b0010}, {64'd9223372036854775809}, {1'b0}},
					// SUB
					// the real result is -9223372036854775809 but in 64-bit representation we get 9223372036854775807
					{{64'd9223372036854775809}, {64'd2}, {4'b0110}, {64'd9223372036854775807}, {1'b0}},
					{{64'd18446744073709551614}, {64'd9223372036854775807}, {4'b0110}, {64'd9223372036854775807}, {1'b0}},
				// Check zero
					// AND
					{{64'd27586970463758451}, {64'd18419157103245793164}, {4'b0000}, {64'd0}, {1'b1}},
					{{64'd18441095276975396848}, {64'd5648796734154767}, {4'b0000}, {64'd0}, {1'b1}},
					// OR
					{{64'd0}, {64'd0}, {4'b0001}, {64'd0}, {1'b1}},
					{{64'd0}, {64'd0}, {4'b0001}, {64'd0}, {1'b1}},
					// ADD
					{{64'd27586970463758451}, {64'd18419157103245793165}, {4'b0010}, {64'd0}, {1'b1}},
					{{64'd18419157103245793165}, {64'd27586970463758451}, {4'b0010}, {64'd0}, {1'b1}},
					// SUB
					{{64'd27586970463758451}, {64'd27586970463758451}, {4'b0110}, {64'd0}, {1'b1}},
					{{64'd18419157103245793165}, {64'd18419157103245793165}, {4'b0110}, {64'd0}, {1'b1}},
					// PASS B
					{{64'd27586970463758451}, {64'd0}, {4'b0111}, {64'd0}, {1'b1}},
					{{64'd18441095276975396848}, {64'd0}, {4'b0111}, {64'd0}, {1'b1}}
			};
		
		// First reset test bench creation
		reset_tb = 1; #27ns reset_tb = 0;
	end
	
	always @(negedge clk) begin
		// Check test executed on positive edge of clk
		if(~reset_tb) begin
			if(result !== result_expected || zero !== zero_expected) begin
				$display("Error in test number %d with input = { a = %b, b = %b, ALUControl = %b } and output = { result = %b, zero = %b } --> The expected output was { result_expected = %b, zero_expected = %b }", test_number, a, b, ALUControl, result, zero, result_expected, zero_expected);
				cnt_errors++;
			end
			test_number++;
			
			if(test_number === CNT_TESTS) begin
				$display("%d tests completed with %d errors", CNT_TESTS, cnt_errors);
				#5ns $stop;
			end
		end
		
		// Prepare next test to positive edge of clk
		#2ns {a, b, ALUControl, result_expected, zero_expected} = test[test_number]; #2ns;
	end
	
endmodule