module GPIO (
  input clk,                   // Clock signal
  input reset,                 // Reset signal
  input [N-1:0] gpio_in,       // Input data for GPIO pins
  output reg [N-1:0] gpio_out, // Output data for GPIO pins
  input [N-1:0] gpio_direction // Direction control for GPIO pins (0: input, 1: output)
);
  parameter N = 8;  // Number of GPIO pins

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      gpio_out <= {N{1'b0}};  // Reset the GPIO output values to 0
    end else begin
      if (gpio_direction == {N{1'b1}}) begin
        // If all GPIO pins are set as outputs, update the output values
        gpio_out <= gpio_in;
      end else begin
        // If any GPIO pin is set as an input, retain the current output values
        gpio_out <= gpio_out;
      end
    end
  end

endmodule
