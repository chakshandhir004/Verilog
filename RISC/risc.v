module moduleName (clk1,clk2);
input clk1,clk2

reg [31:0] PC,IF_ID,IF_ID_NPC;
reg [31:0] ID_EX_IR,ID_EX_NPC,ID_EX_A,ID_EX_B,ID_EX_Imm;
reg [2:0] ID_EX_type,EX_MEM_type,MEM_WB_type;   // type is basically the type of instruction i.e R/R,R/ALU etc..
                                                // In each stage we will be taking some decision depending on type of instruction
reg [31:0] EX_MEM_IR,EX_MEM_ALUOut,EX_EM_B,
reg EX_MEM_cond; //1 bit reg required for jump or branch ocnditioning checking
reg [31:0] MEM_WB_IR,MEM_WB_ALUOut,MEM_WB_LMD;

reg [31:0] Reg [0:31]; //32 registers each of 32 bits Register bank (32*32)
reg [31:0] Mem [0:1023]; // There are 1024 words each word of 32 bits

parameter ADD=6'b000000, SUB=6'b000001, AND=6'b000010, 0R=6'b000011,       //Code becomes more readable
          SLT=6'b0000100, MUL=6'b000101,HLT=6'b111111,
          LW=6'b001000; 

parameter RR_ALU=3'b000, RM_ALU=3'b001, LOAD=3'b010, STORE=3'b011
          STORE=3'b011, BRANCH=3'b100, HLT=3'b101;

reg HALTED; //set after hlt instruction is completed
reg TAKEN_BRANCH; //Required to disable instructions after branch

//Different stages 

//Instruction fetch
always @(posedge clk1) begin
    if(HALTED==0) begin                 //We are checking 6 bits for opcode
        if((EX_MEM_IR[31:26]==BEQZ) && (EX_MEM_COND==1)) ||
        ((EX_MEM_IR[31:26]==BNEQZ) && (EX_MEM_cond==0))          // If branch is taken
        begin
            IF_ID_IR <= #2 Mem[EX_MEM_ALUOut];
            TAKEN_BRANCH <= #2 1'b1;
            IF_ID_NPC <= #2 EX_MEM_ALUOut+1;
            PC<= #2 EX_MEM_ALUOut+1;
        end
        else                        // If branch is not taken simply take the content store in IR register and move program counter ahead
        begin
            IF_ID_IR <= #2 Mem[PC];
            IF_ID_NPC <= #2 PC+1;
            PC <= #2 PC+1;
        end
    end
end

//Instruction decode(Decode Instruction,Prefetching Source reg,sign extension)
always @(poedge clk2) begin
    if(HALTED==0)
    begin
        if(IF_ID_IR[25:21]==5'b00000) ID_EX_A<=0;
        else ID_EX_A<= #2 Reg[IF_ID_IR[25:21]];    //"rs"

        if(IF_ID_IR[20:16]==5'b00000) ID_EX_B<=0;
        else ID_EX_B<= #2 Reg[IF_ID_IR[20:16]];    //"rt"

        ID_EX_NPC <= #2 IF_ID_NPC;  //Forwarded 
        ID_EX_IR <= #2 IF_ID_IR;
        ID_EX_Imm <= #2 {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}};  //Sign Extension
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
                    SUBI  EX_MEM_ALUOut <= #2 ID_EX_A - ID_EX_Imm;
                    default: EX_MEM_ALUOut <= #2 32'hxxxxxxxx;
                endcase
            end
            LOAD,STORE:begin
                EX_MEM_ALUOut<= #2 ID_EX_A + ID_EX_Imm;
                EX_MEM_B<= #2 ID_EX_B;
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
        MEM_WB_type<= EX_MEM_type;
        MEM_WB_IR<= #2 EX_MEM_IR;

        case(EX_MEM_type)
        RR_ALU,RM_ALU:MEM_WB_ALUOut <= #2 EX_MEM_ALUOut;
        LOAD: MEM_WB_LMD<= #2 Mem{EX_MEM_ALUOut};
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