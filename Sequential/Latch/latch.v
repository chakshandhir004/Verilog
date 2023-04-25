//Nor latch
// module latch(s,r,q,qbar);
// input s,r;
// output q,qbar;
// nor(q,r,qbar);
// nor(qbar,s,q);
// endmodule



//Nand Latch
module latch(s,r,q,qbar);
input s,r;
output q,qbar;
assign q=~(r&qbar);
assign qbar=~(s&q);
endmodule
