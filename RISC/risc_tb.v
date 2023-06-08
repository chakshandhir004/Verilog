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
// initial begin
//     for (k=0; k<31; k=k+1)
//      mips.Reg[k]=k;

//      mips.Mem[0] = 32'h28010078; //ADDI R10,R0,120
//      mips.Mem[1] = 32'h0c631800; // OR R3,R3,R3
//      mips.Mem[2] = 32'h20220000; // LW R2,0(R1)
//      mips.Mem[3] = 32'h0c631800; // OR R3,R3,R3
//      mips.Mem[4] = 32'h2842002c; // ADDI R2,R2,45
//      mips.Mem[5] = 32'h0c631800; // OR R3,R3,R3
//      mips.Mem[6] = 32'h24220001; // SW R2,1(R1)
//      mips.Mem[7] = 32'hfc000000; // HLT

//      mips.Mem[120] = 85;

//       mips.PC = 0;
//       mips.HALTED=0;
//       mips.TAKEN_BRANCH =0;

//       #500 $display ("Mem[120]: %4d \nMem[121] : %4d", mips.Mem[120], mips.Mem[121]);
// end

// initial begin
//     $dumpfile("mips.vcd");
//     $dumpvars (0,test_mips32);
//     #600 $finish;
// end



// Eg2: 
//Compute the factorial of given number N stored in memory locaton 200
//The result will be stored in memory location 198
//Initialise R10 with memory address 200
//Load contents of memory location 200 into R3
//Initialise R2 with 1
//In a loop multiply R2 and R3 and store product in R2
//Decrement R3 by 1 and repeat the loop till R3 is zero
//Store the result in memory location 198 from R2

initial begin
    for (k =0 ;k<31 ;k=k+1 ) 
       mips.Reg[k]=k;

       mips.Mem[0]= 32'h280a00c8; //ADDI R10,R0,200
       mips.Mem[1]= 32'h28020001; //ADDI R2,R0,1
       mips.Mem[2]= 32'h0e94a000; //OR R20,R20,R20
       mips.Mem[3]= 32'h21430000; //LW R3,0(R10)
       mips.Mem[4]= 32'h0e94a000; //OR R20,R20,R20
       mips.Mem[5]= 32'h14431000; //Loop: MUL R2,R2,R3
       mips.Mem[6]= 32'h2c630001; //SUBI R3,R3,1
       mips.Mem[7]= 32'h0e94a000; //OR R20,R20,R20
       mips.Mem[8]= 32'h3460fffc; //BNEQZ R3,Loop (i.e -r offset so that PC can have add of correct instruction)
       mips.Mem[9]= 32'h2542fffe; //SW R2,-2(R10)
       mips.Mem[10]= 32'hfc000000; //HLT

       
    mips.Mem[200]=4;
    mips.PC=0;
    mips.HALTED=0;
    mips.TAKEN_BRANCH=0;

    #2000 $display("Mem[200]=%2d, Mem[198]=%6d", mips.Mem[200],mips.Mem[198]);
    
end

initial begin
    $dumpfile("mips.vcd");
    $dumpvars (0,test_mips32);
    $monitor ("R2: %4d", mips.Reg[2]);
    #3000 $finish;
end

endmodule