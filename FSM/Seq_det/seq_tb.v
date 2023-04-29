module tb ();
  
  reg din, clk, rst;
  wire dout;
  wire [1:0] S;
  
  seq_1101 u0 (din, clk, rst, dout);
  
  always #1 clk = ~clk;
  
  initial begin
    clk = 0; rst = 1; din = 0;
    
    #5 rst = 0; din = 0;
    
    #1 din = 0;
    #2 din = 0;
    #2 din = 0;
    #2 din = 1;
    #2 din = 0;
    #2 din = 0;
    #2 din = 1;
    #2 din = 0;
    #2 din = 1;
    #2 din = 1;
    #2 din = 0;
    #2 din = 1;
    #2 din = 1;
    #2 din = 0;
    #2 din = 1;
    #2 din = 0;
    #40 $stop;
    
  end
  
  initial begin
  $dumpfile("dump.vcd");
    $dumpvars(0);
end
  
endmodule