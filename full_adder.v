module full_adder(
	    input A, B, Cin,
	        output Sum, Cout
	);

	xor x1(Sum, A, B, Cin);
	and a1(tmp1, A, B);
	and a2(tmp2, A, Cin);
	and a3(tmp3, B, Cin);
	or o1(Cout, tmp1, tmp2, tmp3);

endmodule
