module test ();
parameter N=10;
reg [N-1:0] A,B,C,D;
reg clk;
wire [N-1:0] F;

part1 p(F,A,B,C,D,clk);

initial begin
    clk=1'b0;
    forever #5 clk=~clk;
end

initial begin
    #5 A=10;B=12;C=6;D=3;
    #20 A=10;B=10;C=5;D=3;
    #20 A=12;B=11;C=4;D=2;
end

initial begin
    $dumpfile("part1.vcd");
    $dumpvars(0);
    $monitor($time," ","F=%d",F);
    #100 $finish;
end

endmodule