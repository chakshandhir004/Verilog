`define TRUE 1'b1
`define FALSE 1'b0


//SR FLIPFLOP
// module srflipflop(sr,clk,q,qbar);
// input [1:0] sr;
// input clk;
// output q,qbar;
// reg q,qbar;


// always @(posedge clk) begin
//     case(sr)
//     2'b00 : q=q;
//     2'b01 : q=0;
//     2'b10 : q=1;
//     2'b11 : q=1'bz;
//     endcase
//     assign qbar=~q;
// end

    
// endmodule



//D flipflop
// module dflipflop(d,clk,q,qbar);

// input d,clk;
// output q,qbar;
// reg q,qbar;

// always @(posedge clk) begin
//     assign q=d;
//     assign qbar=~q;
// end

// endmodule

//T flipflop
// module tflipflop (t,clk,q,qbar);
// input t,clk;
// output q,qbar;
// reg q,qbar;

// always @(posedge clk) begin
//     if(t) q<=q;
//     else q<=~q;

//     assign qbar=~q;
// end
    
// endmodule


//JK Flipflop
module jkflipflop (jk,clk,q,qbar);
input [1:0] jk;
input clk;
output q,qbar;
reg q,qbar;

always @(posedge clk) begin
    case(jk)
     2'b00 : q=q;
     2'b01 : q=0;
     2'b10 : q=1;
     2'b11 : q=~q;
    endcase
  assign qbar=~q;

end

    
endmodule






