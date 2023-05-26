//RISC: Reduced Instruction Set Computer(MIPS32)
//32 bit Processor
//Instruction is fetched from memory decoded and then executed and pc increments by 1

module pipe_MIPS32(clk1,clk2);
input clk1,clk2;

reg [31:0] PC,IF_ID_IR,IF_ID_NPC;
reg [31:0] ID_EX_IR,ID_EX_NPC,ID_EX_A,ID_EX_B,ID_EX_Imm;
reg [2:0] ID_EX_type,EX_MEM_type,MEM_WB_type;   // type is basically the type of instruction i.e R/R,R/ALU etc..
                                                // In each stage we will be taking some decision depending on type of instruction
reg [31:0] EX_MEM_IR,EX_MEM_ALUOut,EX_MEM_B;
reg EX_MEM_cond; //1 bit reg required for jump or branch ocnditioning checking
reg [31:0] MEM_WB_IR,MEM_WB_ALUOut,MEM_WB_LMD;

reg [31:0] Reg [0:31]; //32 registers each of 32 bits Register bank (32*32)
reg [31:0] Mem [0:1023]; // There are 1024 words each word of 32 bits

parameter ADD=6'b000000 , SUB=6'b000001 , AND=6'b000010 , OR=6'b000011 , SLT=6'b000100 , MUL=6'b000101 , HLT=6'b111111,
          LW=6'b001000 , SW=6'b001001, ADDI=6'b001010, SUBI=6'b001011, SLTI=6'b001100, BNEQZ=6'b001101 , BEQZ=6'b001110;

parameter RR_ALU=3'b000, RM_ALU=3'b001, LOAD=3'b010,
          STORE=3'b011, BRANCH=3'b100, HALT=3'b101;

reg HALTED; //Whenever we get hlt instr then we need to stop the execution but acc to pipeline structure
            //the previous instruc were in pipeline in diff stages so we cannot stop at that time and we can not 
            //execute the next instru following hlt so we maintain this reg to check whether to execute a instruction
            //As soon as we get hlt instruction set this reg to 1
reg TAKEN_BRANCH; //Similar to hlt instruc. In EX stage we came to know whether to take a branch or not if want to take
                  //then set this reg to 1 so that next instr can not be executed 

//Different stages 

//Instruction fetch
always @(posedge clk1) begin
    if(HALTED==0) begin                 //We are whether halted reg is set or not if not only then to execute the instruction
        if(((EX_MEM_IR[31:26]==BEQZ) && (EX_MEM_cond==1)) ||   //we have defined parameter for BEQZ so opcode will be checked and compared
        ((EX_MEM_IR[31:26]==BNEQZ) && (EX_MEM_cond==0)) )       //these two conditions specify that the branch is taken 'cond' will only be 1 when reg is 0 
                                                               // so when not equal to 0 cond=0 and condition is also branch if not equal to 0 thus we need to jump in both cases                         
        begin
            IF_ID_IR <= #2 Mem[EX_MEM_ALUOut];   // when we need to take the branch then instruction will be fetched from ALUOUT address
            TAKEN_BRANCH <= #2 1'b1;            // This reg is set to 1
            IF_ID_NPC <= #2 EX_MEM_ALUOut+1;    // NPC and PC is incremented by 1
            PC<= #2 EX_MEM_ALUOut+1;
        end
        else                        // If branch is not taken simply take the content store in IR register and move program counter ahead
        begin
            IF_ID_IR <= #2 Mem[PC];  // Instruction taken from location where PC is pointing
            IF_ID_NPC <= #2 PC+1;   // Increment    NPC by1
            PC <= #2 PC+1;
        end
    end
end

//Instruction decode(Decode Instruction,Prefetching Source reg,sign extension)
always @(posedge clk2) begin
    if(HALTED==0)
    begin
        if(IF_ID_IR[25:21]==5'b00000) ID_EX_A<=0;
        else ID_EX_A<= #2 Reg[IF_ID_IR[25:21]];    //"rs"

        if(IF_ID_IR[20:16]==5'b00000) ID_EX_B<=0;
        else ID_EX_B<= #2 Reg[IF_ID_IR[20:16]];    //"rt"

        ID_EX_NPC <= #2 IF_ID_NPC;  //Forwarded 
        ID_EX_IR <= #2 IF_ID_IR;
        ID_EX_Imm <= #2 {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}};  //Sign Extension forming imm data of 32 bits
    end

    case (IF_ID_IR[31:26])
        ADD,SUB,AND,OR,SLT,MUL: ID_EX_type<= #2 RR_ALU; 
        ADDI,SUBI,SLTI:         ID_EX_type<= #2 RM_ALU;
        LW:                     ID_EX_type<= #2 LOAD;
        SW:                     ID_EX_type<= #2 STORE;
        BNEQZ,BEQZ:             ID_EX_type<= #2 BRANCH;
        HLT:                    ID_EX_type<= #2 HALT;
        default:                ID_EX_type<= #2 HALT;
    endcase
end

//Execution Stage (EX STAGE)
always @(posedge clk1) begin
    if(HALTED==0)begin
        EX_MEM_type<= #2 ID_EX_type;
        EX_MEM_IR <= #2 ID_EX_IR;
        TAKEN_BRANCH<= #2 0;  //Resetting the taken branch to 0

        case (ID_EX_type)
            RR_ALU:begin
                case(ID_EX_IR[31:26])
                    ADD: EX_MEM_ALUOut <= #2 ID_EX_A + ID_EX_B;
                    SUB: EX_MEM_ALUOut <= #2 ID_EX_A - ID_EX_B;  
                    AND: EX_MEM_ALUOut <= #2 ID_EX_A & ID_EX_B;
                    OR:  EX_MEM_ALUOut <= #2 ID_EX_A | ID_EX_B;
                    default: EX_MEM_ALUOut <= #2 32'hxxxxxxxx;
                endcase
            end
            RM_ALU:begin
                case (ID_EX_IR[31:26])
                    ADDI: EX_MEM_ALUOut <= #2 ID_EX_A + ID_EX_Imm;
                    SUBI: EX_MEM_ALUOut <= #2 ID_EX_A - ID_EX_Imm;
                    default: EX_MEM_ALUOut <= #2 32'hxxxxxxxx;
                endcase
            end
            LOAD,STORE:begin
                EX_MEM_ALUOut<= #2 ID_EX_A + ID_EX_Imm;
                EX_MEM_B<= #2 ID_EX_B+ID_EX_Imm;
            end
            BRANCH:begin
                EX_MEM_ALUOut<= #2 ID_EX_NPC + ID_EX_Imm;
                EX_MEM_cond<= #2 (ID_EX_A==0);
            end
        endcase
    end
end

//Memory Stage
always @(posedge clk2) begin
    if(HALTED==0)begin
        MEM_WB_type<=#2 EX_MEM_type;
        MEM_WB_IR<= #2 EX_MEM_IR;

        case(EX_MEM_type)
        RR_ALU,RM_ALU: MEM_WB_ALUOut <= #2 EX_MEM_ALUOut;
        LOAD: MEM_WB_LMD<= #2 Mem[EX_MEM_ALUOut];
        STORE: if(TAKEN_BRANCH==0)       //Disable Write
                    Mem[EX_MEM_ALUOut] <= #2 EX_MEM_B;

        endcase
    
    end
    
end

//Write Back
always @(posedge clk1) begin
    if(TAKEN_BRANCH==0)
    case (MEM_WB_type)
        RR_ALU: Reg[MEM_WB_IR[15:11]] <= #2 MEM_WB_ALUOut;
        RM_ALU: Reg[MEM_WB_IR[20:16]] <= #2 MEM_WB_ALUOut;
        LOAD: Reg[MEM_WB_IR[20:16]] <= #2 MEM_WB_LMD;
        HALT: HALTED<= #2 1'b1; 
    endcase
    
end
endmodule