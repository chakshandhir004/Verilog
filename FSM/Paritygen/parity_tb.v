module test();
reg x,clk;
wire z;
parity p(x,clk,z);

initial begin
    clk=1'b0;
    forever #5 clk=~clk;
end

initial begin
    $dumpfile("parity.vcd");
    $dumpvars(0);
    // $dumplimit(50);
    #2 x=0;
    #10 x=1;
    #10 x=1;
    #10 $finish;
end

initial begin
    $monitor($time," ","z=%b",z);
end
    
endmodule