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
// CREATED		"Mon Apr 02 20:07:09 2018"

module micsig(
	clk,
	in_data1,
	in_data2,
	indata_1_1,
	indata_2_2,
	CLKO,
	outdata4,
	rden,
	rdaddr,
	signal1,
	signal2,
	signal3,
	signal4
);


input wire	clk;
input wire	in_data1;
input wire	in_data2;
input wire	indata_1_1;
input wire	indata_2_2;
output wire	CLKO;
output wire	outdata4;
output wire	rden;
output wire	[9:0] rdaddr;
output wire	[15:0] signal1;
output wire	[15:0] signal2;
output wire	[15:0] signal3;
output wire	[15:0] signal4;

wire	SYNTHESIZED_WIRE_0;
wire	[9:0] SYNTHESIZED_WIRE_1;
wire	[9:0] SYNTHESIZED_WIRE_2;
wire	[15:0] SYNTHESIZED_WIRE_3;
wire	[15:0] SYNTHESIZED_WIRE_4;
wire	[15:0] SYNTHESIZED_WIRE_5;
wire	[15:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[15:0] SYNTHESIZED_WIRE_8;
wire	[15:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_10;

assign	rden = SYNTHESIZED_WIRE_0;




xinhao	b2v_inst(
	.clk(clk),
	.in_data1(in_data1),
	.in_data2(in_data2),
	.CLKO(CLKO),
	.rden(SYNTHESIZED_WIRE_0),
	.outdata4(outdata4),
	.rdaddr(SYNTHESIZED_WIRE_1),
	.signal1(SYNTHESIZED_WIRE_3),
	.signal2(SYNTHESIZED_WIRE_5),
	.signal3(SYNTHESIZED_WIRE_7),
	.signal4(SYNTHESIZED_WIRE_9));


xinhao_b	b2v_inst2(
	.clk(clk),
	.in_data1(indata_1_1),
	.in_data2(indata_2_2),
	
	
	
	.rdaddr(SYNTHESIZED_WIRE_2),
	.signal1(SYNTHESIZED_WIRE_4),
	.signal2(SYNTHESIZED_WIRE_6),
	.signal3(SYNTHESIZED_WIRE_8),
	.signal4(SYNTHESIZED_WIRE_10));


micchoose	b2v_inst4(
	.rden(SYNTHESIZED_WIRE_0),
	.rdaddr_1(SYNTHESIZED_WIRE_1),
	.rdaddr_2(SYNTHESIZED_WIRE_2),
	.signal1_1(SYNTHESIZED_WIRE_3),
	.signal1_2(SYNTHESIZED_WIRE_4),
	.signal2_1(SYNTHESIZED_WIRE_5),
	.signal2_2(SYNTHESIZED_WIRE_6),
	.signal3_1(SYNTHESIZED_WIRE_7),
	.signal3_2(SYNTHESIZED_WIRE_8),
	.signal4_1(SYNTHESIZED_WIRE_9),
	.signal4_2(SYNTHESIZED_WIRE_10),
	.rdaddr(rdaddr),
	.signal1(signal1),
	.signal2(signal2),
	.signal3(signal3),
	.signal4(signal4));


endmodule
