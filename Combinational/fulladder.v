module fulladder(a,b,cin,sum,carry);
input a,b,cin;
output sum,carry;

assign sum=a^b^cin;
assign carry=(a&b) | (b&cin) | (cin&a);

endmodule


// module fulladder(sum,cout,a,b,cin);
// input [3:0] a,b;
// input cin;
// output [3:0] sum;
// output cout;

// assign {cout,sum}=a+b+cin;

// endmodule
