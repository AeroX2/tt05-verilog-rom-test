`default_nettype none

module tt_um_seven_segment_seconds #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
	wire rst = !rst_n;

	reg [15:0] i;
	reg [15:0] pc;
	reg [7:0] rom [0:255];

	always @ (posedge rst)
	begin
		for (i = 0; i < 255; i = i + 1)
			rom[i] = 8'b00000000;
	end

	always @ (posedge clk)
	begin
		rom[pc] <= uio_in;
		pc <= pc + 1;
	end

	assign uo_out = rom[ui_in];

endmodule
