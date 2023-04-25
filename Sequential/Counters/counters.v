
//Counters
`define TRUE 1'b1
`define FALSE 1'b0

// module upcounter(Q,clk,clr);
// input clk,clr;
// output [3:0] Q;
// reg Q;

// always @(posedge clk) begin
//     if(clr) Q=4'd0;
//     else begin
//         Q=(Q+1)%16;
//     end
// end
    
// endmodule


//Ripple counter
// module counter (Q,clk,clr);
// input clk,clr;
// output [3:0] Q;

// tflipflop t0(clk,clr,Q[0]);
// tflipflop t1(Q[0],clr,Q[1]);
// tflipflop t2(Q[1],clr,Q[2]);
// tflipflop t3(Q[2],clr,Q[3]);

    
// endmodule

// module tflipflop (clk,clr,q);
// input clk,clr;
// output q;
// reg q;

// always @(posedge clk) begin
//     if (clr) q=0;
//     else
//         q=~q;

// end


//Up down counter
// module counter(clr,ld,mode,clk,d_in,out);
// input clr,ld,mode,clk;
// input [7:0] d_in;
// wire d_in;
// output [7:0] out;
// reg out;

// always @(posedge clk) begin
//     if(ld) out<=d_in;
//     else if (clr) out<=0;
//     else if (mode) out<=out+1;
//     else out<=out-1;
// end
    
// endmodule


//Parametrized Counter
module counter (clk,clr,count);
parameter N = 3;
input clk,clr;
output [0:N] count;
reg count;

always @(posedge clk) begin
    if(clr) count<=0;
    else count<=count+4'b 0001;
end
    
endmodule
    
