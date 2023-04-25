//Traffic Signal Controller
//The traffic signal for main highway gets priority.Occasionally cars come from country road.
//At that time the traffic signal for country road must be green and for highway road musst be yellow and then red.



`define TRUE 1'b1
`define FALSE 1'b0
`define RED 2'd0    // As there are 3 colors so we need 2 bits to represent 
`define YELLOW 2'd1  // three colors
`define GREEN 2'd2

// State definition   HWY       CNTRY    As there are 5 states which can be represented by 3 bits only
`define S0 3'd0     //GREEN     RED
`define S1 3'd1     //YELLOW    RED
`define S2 3'd2     //RED       RED
`define S3 3'd3     //RED       GREEN
`define S4 3'd4     //RED       YELLOW


module sig_control(hwy,cntry,X,clock,clear);
output [1:0] hwy,cntry;
reg [1:0] hwy,cntry;
input X;  // If true there is car on cntryside else false (Sensor reading)
input clock,clear;

reg[2:0] state,next_state; //Internal state variables

initial begin
    state=`S0;
    next_state=`S0;
    hwy=`GREEN;
    cntry=`RED;
    $display("Traffic signal Controller");
end

always @(posedge clock) begin
    if(clear) state<=`S0;
    else state<=next_state;
end

always @(state) begin
    case(state)
        `S0:begin
            hwy=`GREEN;
            cntry=`RED;
        end
        `S1:begin
            hwy=`YELLOW;
            cntry=`RED;
        end  
        `S2:begin
            hwy=`RED;
            cntry=`RED;
        end  
        `S3:begin
            hwy=`RED;
            cntry=`GREEN;
        end  
        `S4:begin
            hwy=`RED;
            cntry=`YELLOW;
        end      
    endcase
end

always @(state or clear or X) begin
        case(state)
            `S0:if(X) next_state=`S1;
                else  next_state=`S0;
            `S1:begin  
                next_state=`S2;                    
            end    
             `S2:begin  
                next_state=`S3;
            end 
            `S3:if(X) next_state=`S3;
                else  next_state=`S4; 
            `S4:begin  
                next_state=`S0;
            end 
            default:next_state=`S0;
        endcase        
end


endmodule