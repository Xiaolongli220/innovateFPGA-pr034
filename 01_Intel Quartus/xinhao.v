// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Wed Mar 21 16:56:30 2018"

module xinhao(
	clk,
	rready,
	in_data1,
	CLKO,
	rden,
	rdaddr,
	signal1,
	signal2,
	signal3,
	signal4
);


input wire	clk;
input wire	rready;
input wire	in_data1;
output wire	CLKO;
output wire	rden;
output wire	[9:0] rdaddr;
output wire	[15:0] signal1;
output wire	[15:0] signal2;
output wire	[15:0] signal3;
output wire	[15:0] signal4;

wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_2;
wire	[0:1] SYNTHESIZED_WIRE_27;
wire	[17:0] SYNTHESIZED_WIRE_4;
wire	[17:0] SYNTHESIZED_WIRE_5;
wire	[17:0] SYNTHESIZED_WIRE_6;
wire	[17:0] SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_28;
wire	[0:0] SYNTHESIZED_WIRE_12;
wire	[0:0] SYNTHESIZED_WIRE_13;
wire	[0:0] SYNTHESIZED_WIRE_15;
wire	[9:0] SYNTHESIZED_WIRE_29;

assign	SYNTHESIZED_WIRE_26 = 1;
assign	SYNTHESIZED_WIRE_2 = 1;
assign	SYNTHESIZED_WIRE_27 = 0;
assign	SYNTHESIZED_WIRE_28 = 1;




dataa	b2v_inst(
	.clk(SYNTHESIZED_WIRE_25),
	.reset_n(SYNTHESIZED_WIRE_26),
	.ast_sink_valid(SYNTHESIZED_WIRE_2),
	.rready(rready),
	.ast_sink_error(SYNTHESIZED_WIRE_27),
	.data1(SYNTHESIZED_WIRE_4),
	.data2(SYNTHESIZED_WIRE_5),
	.data3(SYNTHESIZED_WIRE_6),
	.data4(SYNTHESIZED_WIRE_7),
	.rden(rden),
	.rdaddr(rdaddr),
	.signal1(signal1),
	.signal2(signal2),
	.signal3(signal3),
	.signal4(signal4));



divider10	b2v_inst10(
	.clk(SYNTHESIZED_WIRE_8),
	.CLKout(CLKO));


cicpdm	b2v_inst11(
	.reset_n(SYNTHESIZED_WIRE_26),
	.clk(SYNTHESIZED_WIRE_25),
	.in_valid(SYNTHESIZED_WIRE_28),
	.in_data1(in_data1),
	.in_data2(SYNTHESIZED_WIRE_12),
	.in_data3(SYNTHESIZED_WIRE_13),
	.out_ready(SYNTHESIZED_WIRE_28),
	.in_data4(SYNTHESIZED_WIRE_15),
	.in_error(SYNTHESIZED_WIRE_27),
	.o1(SYNTHESIZED_WIRE_4),
	.o2(SYNTHESIZED_WIRE_5),
	.o3(SYNTHESIZED_WIRE_6),
	.o4(SYNTHESIZED_WIRE_7));


divider10	b2v_inst12(
	.clk(SYNTHESIZED_WIRE_25),
	.CLKout(SYNTHESIZED_WIRE_8));


PLL	b2v_inst2(
	.refclk(clk),
	
	.outclk_0(SYNTHESIZED_WIRE_25)
	);


count200	b2v_inst3(
	.clk(SYNTHESIZED_WIRE_25),
	
	
	.count(SYNTHESIZED_WIRE_29));


pdm	b2v_inst4(
	.clock(SYNTHESIZED_WIRE_25),
	.address(SYNTHESIZED_WIRE_29),
	.q(SYNTHESIZED_WIRE_12));


pdm	b2v_inst5(
	.clock(SYNTHESIZED_WIRE_25),
	.address(SYNTHESIZED_WIRE_29),
	.q(SYNTHESIZED_WIRE_13));


pdm	b2v_inst6(
	.clock(SYNTHESIZED_WIRE_25),
	.address(SYNTHESIZED_WIRE_29),
	.q(SYNTHESIZED_WIRE_15));





endmodule
