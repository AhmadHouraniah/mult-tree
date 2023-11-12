import configure::*;

module test_multiply();
	timeunit 1ps;
	timeprecision 1ps;

	task check(
		input logic [XLEN-1 : 0] aa,
		input logic [XLEN-1 : 0] bb,
		input logic [2*XLEN-1 : 0] pp,
		input logic [2*XLEN-1 : 0] qq,
		input logic [2*XLEN-1 : 0] rr,
		input logic [0      : 0] ss
	);
		begin
			if (ss == 0) begin
				$write("%c[1;32m",8'h1B);
				$display("TEST SUCCEEDED");
				$write("%c[0m",8'h1B);
			end else begin
				$write("%c[1;31m",8'h1B);
				$display("TEST FAILED");
				$write("%c[0m",8'h1B);
			end
			$display("%h * %h = %h ^ %h == %h",aa,bb,pp,qq,rr);
		end
	endtask

	logic clock = 0;

	logic op;

	logic [XLEN-1 : 0] a; 
	logic [XLEN-1 : 0] b;
	logic [2*XLEN-1 : 0] p;
	logic [2*XLEN-1 : 0] q;
	logic [2*XLEN-1 : 0] r;
	logic [0      : 0] s;

	initial begin
		if (TYP == 0) begin
			$dumpfile("dadda.vcd");
		end else begin
			$dumpfile("wallace.vcd");
		end
		$dumpvars(0,test_multiply);
		$urandom(SEED);
	end

	initial begin
		#(MAXTIME) $finish;
	end

	always begin
		#1 clock = ~clock;
	end

	mul #(
		.XLEN (XLEN),
		.TYP (TYP)
	) mul_comp
	(
		.a (a),
		.b (b),
		.c (p)
	);

	assign q = a * b;
	assign r = p ^ q;
	assign s = |(r);

	always begin
		a = $urandom();
		b = $urandom();
		@(posedge clock);
		check(a,b,p,q,r,s);
	end

endmodule