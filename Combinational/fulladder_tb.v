// module testbench();
// reg a,b,cin;
// wire sum,carry;

// fulladder FA(a,b,cin,sum,carry);

// initial begin
//     a=0;b=0;cin=0;
// end

// initial begin
//     #10 a=1;b=0;cin=0;
//     #10 a=1;b=1;cin=0;
//     #10 a=1;b=0;cin=1;
//     #10 a=1;b=1;cin=1;

// end

// initial begin
//     $monitor($time ," ","a=%b b=%b cin=%b sum=%b carry=%b",a,b,cin,sum,carry);
//     #60 $finish;
// end

// endmodule


module testbench();
  reg [3:0]A, B; 
  reg Cin;
  wire [3:0] S;
  wire Cout;
  wire[4:0] add;
  
  CarryLookAheadAdder cla(A, B, Cin, S, Cout);
  
  assign add = {Cout, S};
  initial begin
    $monitor("A = %b: B = %b, Cin = %b --> S = %b, Cout = %b, Addition = %b", A, B, Cin, S, Cout, add);
    A = 1; B = 0; Cin = 0; #3;
    A = 2; B = 4; Cin = 1; #3;
    A = 4'hb; B = 4'h6; Cin = 0; #3;
    A = 5; B = 3; Cin = 1;
  end
endmodule

