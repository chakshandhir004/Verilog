// module muxtest();
// reg a0,a1,sel;
// wire out;

// mux m(a0,a1,sel,out);

// initial begin
//     a0=0;a1=0;sel=0;
// end

// initial begin
//     #10 a0=0;a1=0;sel=1;
//     #10 a0=0;a1=1;sel=1;
//     #10 a0=1;a1=1;sel=0;
// end

// initial begin
//     $monitor($time,"a0=%b a1=%b sel=%b out=%b",a0,a1,sel,out);
//     #40 $finish;
// end

// endmodule;



// module muxtest();
// reg a0,a1,a2,a3,s0,s1;
// wire out;

// mux m(a0,a1,a2,a3,s0,s1,out);

// initial begin
//     a0=0;a1=0;a2=0;a3=0;s0=0;s1=0;
// end

// initial begin
//     #10 a0=0;a1=0;a2=1;a3=0;s0=1;s1=0;
//     #10 a0=0;a1=0;a2=0;a3=1;s0=1;s1=1;
//     #10 a0=0;a1=0;a2=0;a3=0;s0=0;s1=0;
// end

// initial begin
//     $monitor($time," ","a0=%b a1=%b a2=%b a3=%b s0=%b s1=%b out=%b",a0,a1,a2,a3,s0,s1,out);
//     #40 $finish;
// end

// endmodule;

module muxtest();
reg [3:0] in;
reg [1:0] sel;
wire out;

mux m(in,sel,out);

initial begin
    in=4'b0;
    sel=2'b0;
end

initial begin
    #10  in=4'b 1000;sel=2'b 11;
    #10  in=4'b 1000;sel=2'b 01;
    #10  in=4'b 1001;sel=2'b 00;
end

initial begin
    $monitor($time," ","in=%b sel=%b out=%b",in,sel,out);
    #40 $finish;
end

endmodule;
