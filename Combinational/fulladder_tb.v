module testbench();
reg a,b,cin;
wire sum,carry;

fulladder FA(a,b,cin,sum,carry);

initial begin
    a=0;b=0;cin=0;
end

initial begin
    #10 a=1;b=0;cin=0;
    #10 a=1;b=1;cin=0;
    #10 a=1;b=0;cin=1;
    #10 a=1;b=1;cin=1;

end

initial begin
    $monitor($time ," ","a=%b b=%b cin=%b sum=%b carry=%b",a,b,cin,sum,carry);
    #60 $finish;
end

endmodule