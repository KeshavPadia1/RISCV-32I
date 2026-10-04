
// controller.v - controller for RISC-V CPU

module controller (
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    input        Zero,
	 input        lt,
	 input        ltu,
    output       [1:0] ResultSrc,
    output       MemWrite,
    output       PCSrc, ALUSrc,
    output       RegWrite, Jump,
    output [2:0] ImmSrc,
    output [3:0] ALUControl,
	 output jalr
);

wire [1:0] ALUOp;
wire       Branch;
reg take;

main_decoder    md (op, ResultSrc, MemWrite, Branch,
                    ALUSrc, RegWrite, Jump, ImmSrc, ALUOp,jalr);

alu_decoder     ad (op[5], funct3, funct7b5, ALUOp, ALUControl);

// deciding take for every type of branch instruction
always @(*) begin 
case(funct3)
3'b000: take = Zero;
3'b001: take = ~Zero;
3'b100: take = lt;
3'b101: take = ~lt;
3'b110: take = ltu;
3'b111: take = ~ltu;
endcase
end

// for jump and branch
assign PCSrc = (Branch & take) | Jump;

endmodule

