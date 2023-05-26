module GPIO_TB;

 
  parameter N = 8; 

  // Signals
  reg clk;
  reg reset;
  reg [N-1:0] gpio_in;
  wire [N-1:0] gpio_out;
  reg [N-1:0] gpio_direction;

  // Instantiate the GPIO module
  GPIO dut (
    .clk(clk),
    .reset(reset),
    .gpio_in(gpio_in),
    .gpio_out(gpio_out),
    .gpio_direction(gpio_direction)
  );

  // Clock generation
  initial begin
    clk=1'b0;
    forever #5 clk = ~clk;  
  end

  // Reset initialization
  initial begin
    reset = 1;
    #10 reset = 0;  
  end

  // Test stimulus
  initial begin
     $dumpfile("gpio.vcd");
     $dumpvars(0);
    //Set GPIO pins as outputs and drive specific values
    gpio_direction = {N{1'b0}};  // Set all pins as outputs
    #10 gpio_direction = {N{1'b1}};  // Set all pins as inputs
    #20;
    gpio_direction = {N{1'b0}};
    #10;
    $finish;  
  end
endmodule
