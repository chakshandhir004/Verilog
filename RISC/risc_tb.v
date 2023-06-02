module test_mips32;
reg clk1,clk2;
integer k;
pipe_MIPS32 mips(clk1,clk2);

initial begin
    clk1=0;
    clk2=0;
    repeat(50) begin
        #5 clk1=1; #5 clk1=0;
        #5 clk2=1; #5 clk2=0;
    end
end


// Eg1 : Load the data from loaction 120 add 45 to it then store the data at location 121
// Initialize the reg R1 with 120 then load the contents of memory location 120 in reg R2 and add 45 to it
// add 1 to 120 then memory location will be 121 which is in reg 121 then store the data of R2 to that mem add
initial begin
    for (k=0; k<31; k=k+1)
     mips.Reg[k]=k;

     mips.Mem[0] = 32'h28010078; //ADDI R10,R0,120
     mips.Mem[1] = 32'h0c631800; // OR R3,R3,R3
     mips.Mem[2] = 32'h20220000; // LW R2,0(R1)
     mips.Mem[3] = 32'h0c631800; // OR R3,R3,R3
     mips.Mem[4] = 32'h2842002c; // ADDI R2,R2,45
     mips.Mem[5] = 32'h0c631800; // OR R3,R3,R3
     mips.Mem[6] = 32'h24220001; // SW R2,1(R1)
     mips.Mem[7] = 32'hfc000000; // HLT

     mips.Mem[120] = 85;

      mips.PC = 0;
      mips.HALTED=0;
      mips.TAKEN_BRANCH =0;

      #500 $display ("Mem[120]: %4d \nMem[121] : %4d", mips.Mem[120], mips.Mem[121]);
end

initial begin
    $dumpfile("mips.vcd");
    $dumpvars (0,test_mips32);
    #600 $finish;
end



// Eg2: 
    
endmodule