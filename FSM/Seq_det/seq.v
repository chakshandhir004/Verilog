//SEQUENCE DETECTOR 

//(a) 1010 (Mealey Machine Overlapping)
// module seq_1010(input din, clk, rst,
//                 output reg dout);
  

//   parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
  
  
//   reg [2:0] state, next_state;
  
//   // Next State Logic - combinational logic to compute the next state based on the current state and input value
//   always @ (*) begin
//     case (state)
//       S0: next_state = din ? S1 : S0;
//       S1: next_state = din ? S1 : S2;
//       S2: next_state = din ? S3 : S0;
//       //S3: next_state = din ? S1 : S0;// This transition for non-overlaping sequence detector (If uncommented, comment the next line)
//       S3: next_state = din ? S1 : S2; // This transition for overlaping sequence detector (If uncommented, comment the previous line)
//       default: next_state = S0;
//     endcase
//   end
  
//   // State Memory - Assign the computed next state to the state memory on the clock edge
//   always @ (posedge clk) begin
//     if (rst) state <= 2'b00;
//     else state <= next_state;
//   end
  
//   // Output functional logic - The states for which the output should be '1'
//   always @ (posedge clk) begin
//     if (rst) dout <= 1'b0;
//     else begin
//       if (~din & (state == S3)) dout <= 1'b1;
//       else dout <= 1'b0;
//     end
//   end
// endmodule

//(b) 1101 (Mealey Machine Overlapping)
module seq_1101(input din, clk, rst,
                output reg dout);
  

  parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
  
  
  reg [2:0] state, next_state;
  
  // Next State Logic - combinational logic to compute the next state based on the current state and input value
  always @ (*) begin
    case (state)
      S0: next_state = din ? S1 : S0;
      S1: next_state = din ? S2 : S0;
      S2: next_state = din ? S2 : S3;
      // S3: next_state = din ? S0 : S0;// This transition for non-overlaping sequence detector (If uncommented, comment the next line)
      S3: next_state = din ? S1 : S0; // This transition for overlaping sequence detector (If uncommented, comment the previous line)
      default: next_state = S0;
    endcase
  end
  
  // State Memory - Assign the computed next state to the state memory on the clock edge
  always @ (posedge clk) begin
    if (rst) state <= 2'b00;
    else state <= next_state;
  end
  
  // Output functional logic - The states for which the output should be '1'
  always @ (posedge clk) begin
    if (rst) dout <= 1'b0;
    else begin
      if (din & (state == S3)) dout <= 1'b1;
      else dout <= 1'b0;
    end
  end
endmodule
//(c)