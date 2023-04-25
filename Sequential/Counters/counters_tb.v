// module test();
// reg clk,clr;
// wire [3:0] Q;

// counter c(Q,clk,clr);

// initial begin
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     $dumpfile("counter.vcd");
//     $dumpvars(0);
//     clr=`FALSE;
//     #10 clr=`TRUE;
//     #200 clr=`FALSE;
// end

// // initial begin
// //     t=1;
// // end

// initial begin
//     $monitor($time," ","C[0]=%b C[0]=%b C[0]=%b C[0]=%b  Clear=%b",Q[0],Q[1],Q[2],Q[3],clr);
// end

// initial begin
//     #400 $finish;
// end

    
// endmodule


