module test();
reg clk,clr;
wire [3:0] Q;

upcounter c(Q,clk,clr);

initial begin
    clk=`TRUE;
    forever #5 clk=~clk;
end

initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0);
    clr=`FALSE;
    #10 clr=`TRUE;
    #200 clr=`FALSE;
end

// initial begin
//     t=1;
// end

initial begin
    $monitor($time," ","C[3]=%b C[2]=%b C[1]=%b C[0]=%b  Clear=%b",Q[3],Q[2],Q[1],Q[0],clr);
end

initial begin
    #400 $finish;
end

    
endmodule


// module test();
// reg clk,clr,ld,mode;
// reg [7:0] d_in;
// wire [7:0] out;

// counter c(clr,ld,mode,clk,d_in,out);

// initial begin
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     d_in=8'b 0;
// end

// initial begin
//     #10 clr=0;ld=1;mode=1;
//     #10 clr=0;ld=0;mode=1;
//     #10 clr=0;ld=1;mode=1;
// end

// initial begin
//     $monitor($time," ","out=%b",out);
//     #40 $finish;
// end

  
// endmodule



// module test ();
// reg clk,clr;
// parameter N = 3;
// wire [0:N] count;

// counter c(clk,clr,count);


// initial begin
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     #10 clr=0;
//     #10 clr=0;
//     #10 clr=1;
// end

// initial begin
//     $monitor($time," "," clr=%b, count=%b",clr,count);
//     #40 $finish;
// end

// endmodule