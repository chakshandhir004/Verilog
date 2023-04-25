`define TRUE 1'b1
`define FALSE 1'b0

//Shift Register(Ring Counter)
module register (clk,init,count);
input clk,init;
output reg [7:0] count;

always @(posedge clk) begin
    if(init) count=8'b 10000001;
    else begin
        count<= count<<1;
        count[0] <=count[7];
    end
end
    
endmodule