//2*1 MUX (Data flow modelling using conditional operator)
// module mux(a0,a1,sel,out);
// input a1,a0,sel;
// output out;
// assign out=sel?a1:a0;

// endmodule


//2*1 MUX (Behavioral modelling)
// module mux(a0,a1,sel,out);
// input a0,a1,sel;
// output out;
// reg out;
// always @(a0 or a1 or sel) begin
//     if(sel) assign out=a1;
//     else assign out=a0;
// end

// endmodule

//4*1 MUX (Data flow modelling using boolean expression)
// module mux(a0,a1,a2,a3,s0,s1,out);
// input a0,a1,a2,a3;
// input s0,s1;
// output out;

// assign out=(!s1 & !s0 & a0) | (!s1 & s0 & a1)  | (s1 & !s0 & a2) | (s1 & s0 & a3);

// endmodule


//4*1 MUX (Gate level Modelling)
// module mux(a0,a1,a2,a3,s0,s1,out);
// input a0,a1,a2,a3;
// input s0,s1;
// output out;

// wire s1n,s10;

// not(s1n,s1);
// not(s0n,s0);

// wire c,d,e,f;
// and(c,s1n,s0n,a0);
// and(d,s1n,s0,a1);
// and(e,s1,s0n,a2);
// and(f,s1,s0,a3);
// or(out,c,d,e,f);

// endmodule


//4*1 MUX (Using nsted conditional Operators)
// module mux(a0,a1,a2,a3,s0,s1,out);
// input a0,a1,a2,a3;
// input s0,s1;
// output out;

// assign out = s1?(s0?a3:a2):(s0?a1:a0);

// endmodule


// 4*1 MUX (Behavioral Modelling)
module mux(in,sel,out);
input [3:0] in;
input [1:0] sel;
output out;

assign out = in[sel];

endmodule

//16*1 MUX()