module test();
reg x,clk;
wire z;
parity p(x,clk,z);

initial begin
    clk=1'b0;
    forever #10 clk=~clk;
end

initial begin
    #10 x=0;
    #10 x=1;
    #10 x=1;
    #10 $finish;
end

initial begin
    $monitor($time," ","x=%b z=%b",x,z);
end
    
endmodule