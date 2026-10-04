
// data_mem.v - data memory

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
	 input       [2:0] funct3,
    output reg  [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// combinational read logic
wire [DATA_WIDTH-1:0] word  = data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE];
wire [7:0]            rbyte = word[{wr_addr[1:0], 3'b000} +: 8];
wire [15:0]           rhalf = word[{wr_addr[1], 4'b0000} +: 16];

always @(*) begin
    case (funct3)
        3'b000:  rd_data_mem = {{24{rbyte[7]}},  rbyte};   // lb
        3'b001:  rd_data_mem = {{16{rhalf[15]}}, rhalf};   // lh
        3'b100:  rd_data_mem = {24'b0, rbyte};             // lbu
        3'b101:  rd_data_mem = {16'b0, rhalf};             // lhu
        default: rd_data_mem = word;                       // lw (010) and others
    endcase
end
// synchronous write logic
always @(posedge clk) begin
    if (wr_en) begin 
	 case(funct3)
	 3'b010: data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= wr_data;
	 3'b000: data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE][{wr_addr[1:0], 3'b000} +: 8] <= wr_data[7:0];
	 3'b001: data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE][{wr_addr[1], 4'b0000} +: 16] <= wr_data[15:0]; 
	 endcase
end
end

endmodule
