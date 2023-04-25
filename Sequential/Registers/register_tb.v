module test ();
reg clk,init;
wire [7:0] count;

register r(clk,init,count);

initial begin
    clk=`TRUE;
    forever #5 clk=~clk;
end

initial begin
    init=1;
    #10 init=0;
end


initial begin
    $monitor($time," ","count=%b",count);
    #50 $finish;
end
    
endmodule