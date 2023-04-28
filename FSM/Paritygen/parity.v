// module parity (x,clk,z);
// input x,clk;
// output reg z;
// reg even_odd; //The machine state I have only 2 states so it can be handled by 1 flipflop
// parameter EVEN = 0, ODD=1;

// always @(posedge clk)    //Whenever posedge of clk come we check the current state if it is EVEN 
// case (even_odd)         // or ODD then we update both output z and current state
//     EVEN:begin
//         z<=x?1:0;               //As If I/P(x) is 1 we will go to odd state(1) and else remain in even state(0)
//         even_odd<=x?ODD:EVEN;   //Changing the State
//     end
//     ODD:begin
//         z<=x?0:1;
//         even_odd<=x?EVEN:ODD;
//     end
//     default:even_odd<=EVEN;
// endcase

    
// endmodule


//Modified Version(Will not generate a latch for Z)
module parity (x,clk,z);
input x,clk;
output reg z;
reg even_odd; 
parameter EVEN = 0, ODD=1;

always @(posedge clk)   
case (even_odd)        
    EVEN: even_odd<=x?ODD:EVEN;   
    ODD:even_odd<=x?EVEN:ODD;
    default:even_odd<=EVEN;
endcase

always @(even_odd) begin
    case (even_odd)
        EVEN:z=0;
        ODD:z=1;
    endcase
    
end

    
endmodule
