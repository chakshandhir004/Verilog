module SPI_Master_TB;
  reg clk;
  reg rst;
  reg cs_reg;
  wire sck;
  wire mosi;
  reg miso;
  
  wire cs = cs_reg; // Assign cs_reg to cs wire
  
  // Instantiate the SPI_Master module
  SPI_Master dut (
    .clk(clk),
    .rst(rst),
    .cs(cs_reg),
    .sck(sck),
    .mosi(mosi),
    .miso(miso)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  initial begin
    // Initialize inputs
    rst = 1;
    clk = 0;
    cs_reg = 1; // Initialize cs_reg to idle state
    #10 rst = 0;
    
    // Wait for a few clock cycles after releasing reset
    #20;
    
    // Set a sample data to be transmitted
    dut.tx_data = 8'b10101010;
    
    // Start the SPI communication
    #10 cs_reg = 0;
    #10 cs_reg = 1;
    
    // Wait for the SPI communication to complete
    repeat (8) begin
      #10;
    end
    
    // Check the received data
    $display("Received Data: %b", dut.rx_data);
    
    // End the simulation
    $finish;
  end
  
endmodule
