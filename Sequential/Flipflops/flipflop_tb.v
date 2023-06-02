// module test();
// reg clk;
// reg[1:0] sr;
// wire q,qbar;

// srflipflop s(sr,clk,q,qbar);

// initial begin              // Clock generator
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     $dumpfile("flipflop.vcd");
//     $dumpvars(0);
//    #50 sr=2'b00;
//    #50 sr=2'b01;
//    #50 sr=2'b10;
//    #50 sr=2'b11;
//    #50 sr=2'b00;
//    #50 $finish;

// end

// initial begin
//     $monitor($time," ","sr=%b q=%b qbar=%b",sr,q,qbar);
// end

// endmodule



// module test();
// reg d,clk;
// wire q,qbar;

// dflipflop f(d,clk,q,qbar);


// initial begin              // Clock generator
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     $dumpfile("flipflop.vcd");
//     $dumpvars(0);
//     #50 d=0;
//     #50 d=1;
//     #50 $finish;
// end


// initial begin
//     $monitor($time," ","d=%b q=%b qbar=%b",d,q,qbar);
// end


// endmodule



// module test();
// reg t,clk;
// wire q,qbar;

// tflipflop c(t,clk,q,qbar);


// initial begin              // Clock generator
//     clk=`TRUE;
//     forever #5 clk=~clk;
// end

// initial begin
//     t=0;
// end

// initial begin
//     $dumpfile("flipflop.vcd");
//     $dumpvars(0);
//     #50 t=0;
//     #50 t=1;
//     #50 $finish;
// end


// initial begin
//     $monitor($time," ","t=%b q=%b qbar=%b",t,q,qbar);
// end


// endmodule





module test();
reg clk;
reg[1:0] jk;
wire q,qbar;

jkflipflop s(jk,clk,q,qbar);

initial begin              // Clock generator
    clk=`TRUE;
    forever #5 clk=~clk;
end

initial begin
    $dumpfile("flipflop.vcd");
    $dumpvars(0);
   #50 jk=2'b00;
   #50 jk=2'b01;
   #50 jk=2'b10;
   #50 jk=2'b11;
   #50 jk=2'b00;
   #50 $finish;

end

initial begin
    $monitor($time," ","jk=%b q=%b qbar=%b",jk,q,qbar);
end

endmodule