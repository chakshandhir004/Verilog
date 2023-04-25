module test();
reg s,r;
wire q,qbar;

latch l(s,r,q,qbar);


initial begin
        
  #5  r=1'b1;  s=1'b0;
  #5  r=1'b1;  s=1'b1;
  #5  r=1'b0;  s=1'b1;
  #5  r=1'b1;  s=1'b1;
  #5  r=1'b1;  s=1'b1;
end

initial begin
    $monitor($time," ","s=%b r=%b q=%b qbar=%b",s,r,q,qbar);
end

endmodule