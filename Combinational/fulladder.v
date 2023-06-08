// module fulladder(a,b,cin,sum,carry);
// input a,b,cin;
// output sum,carry;

// assign sum=a^b^cin;
// assign carry=(a&b) | (b&cin) | (cin&a);

// endmodule



// module fulladder(sum,cout,a,b,cin);
// input [3:0] a,b;
// input cin;
// output [3:0] sum;
// output cout;

// assign {cout,sum}=a+b+cin;

// endmodule



//Carry look ahead Adder (Time Complexity is O(log n))
module CarryLookAheadAdder(
  input [3:0]A, B, 
  input Cin,
  output [3:0] S,
  output Cout
);
  wire [3:0] Ci; 
  
  assign Ci[0] = Cin;
  assign Ci[1] = (A[0] & B[0]) | ((A[0]^B[0]) & Ci[0]);
  //assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & Ci[1]); expands to
  assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])));
  //assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & Ci[2]); expands to
  assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))));
  //assign Cout  = (A[3] & B[3]) | ((A[3]^B[3]) & Ci[3]); expands to
  assign Cout  = (A[3] & B[3]) | ((A[3]^B[3]) & ((A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))))));

  assign S = A^B^Ci;
endmodule