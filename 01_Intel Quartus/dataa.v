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
// CREATED		"Tue Mar 20 20:39:58 2018"

module dataa(
	clk,
	reset_n,
	ast_sink_valid,
	rready,
	ast_sink_error,
	data1,
	data2,
	data3,
	data4,
	rden,
	rdaddr,
	signal1,
	signal2,
	signal3,
	signal4
);


input wire	clk;
input wire	reset_n;
input wire	ast_sink_valid;
input wire	rready;
input wire	[1:0] ast_sink_error;
input wire	[17:0] data1;
input wire	[17:0] data2;
input wire	[17:0] data3;
input wire	[17:0] data4;
output wire	rden;
output wire	[9:0] rdaddr;
output wire	[15:0] signal1;
output wire	[15:0] signal2;
output wire	[15:0] signal3;
output wire	[15:0] signal4;

wire	[32:0] out1;
wire	[32:0] out2;
wire	[32:0] out3;
wire	[32:0] out4;
wire	wready;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_35;
wire	[9:0] SYNTHESIZED_WIRE_36;
wire	[9:0] SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_31;

assign	rden = SYNTHESIZED_WIRE_35;
assign	rdaddr = SYNTHESIZED_WIRE_36;




wr	b2v_33(
	.wready(wready),
	.rready(rready),
	.rden(SYNTHESIZED_WIRE_35),
	.wren(SYNTHESIZED_WIRE_34),
	.o(SYNTHESIZED_WIRE_31));


divider10	b2v_654(
	.clk(clk),
	.CLKout(SYNTHESIZED_WIRE_32));


fir	b2v_inst(
	.clk(SYNTHESIZED_WIRE_32),
	.reset_n(reset_n),
	.ast_sink_valid(ast_sink_valid),
	.ast_sink_data(data2),
	.ast_sink_error(ast_sink_error),
	
	.ast_source_data(out2)
	);


fir	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_32),
	.reset_n(reset_n),
	.ast_sink_valid(ast_sink_valid),
	.ast_sink_data(data3),
	.ast_sink_error(ast_sink_error),
	
	.ast_source_data(out3)
	);


count200	b2v_inst10(
	.clk(SYNTHESIZED_WIRE_33),
	.clr(SYNTHESIZED_WIRE_34),
	
	.count(SYNTHESIZED_WIRE_36));


divider22	b2v_inst11(
	.clk(clk),
	.CLKout(SYNTHESIZED_WIRE_33));


fir	b2v_inst2(
	.clk(SYNTHESIZED_WIRE_32),
	.reset_n(reset_n),
	.ast_sink_valid(ast_sink_valid),
	.ast_sink_data(data1),
	.ast_sink_error(ast_sink_error),
	
	.ast_source_data(out1)
	);


fir	b2v_inst3(
	.clk(SYNTHESIZED_WIRE_32),
	.reset_n(reset_n),
	.ast_sink_valid(ast_sink_valid),
	.ast_sink_data(data4),
	.ast_sink_error(ast_sink_error),
	
	.ast_source_data(out4)
	);


ram	b2v_inst4(
	.wren(SYNTHESIZED_WIRE_34),
	.rden(SYNTHESIZED_WIRE_35),
	.wrclock(SYNTHESIZED_WIRE_32),
	.rdclock(SYNTHESIZED_WIRE_33),
	.data(out1[32:17]),
	.rdaddress(SYNTHESIZED_WIRE_36),
	.wraddress(SYNTHESIZED_WIRE_37),
	.q(signal1));


ram	b2v_inst5(
	.wren(SYNTHESIZED_WIRE_34),
	.rden(SYNTHESIZED_WIRE_35),
	.wrclock(SYNTHESIZED_WIRE_32),
	.rdclock(SYNTHESIZED_WIRE_33),
	.data(out2[32:17]),
	.rdaddress(SYNTHESIZED_WIRE_36),
	.wraddress(SYNTHESIZED_WIRE_37),
	.q(signal2));


ram	b2v_inst6(
	.wren(SYNTHESIZED_WIRE_34),
	.rden(SYNTHESIZED_WIRE_35),
	.wrclock(SYNTHESIZED_WIRE_32),
	.rdclock(SYNTHESIZED_WIRE_33),
	.data(out3[32:17]),
	.rdaddress(SYNTHESIZED_WIRE_36),
	.wraddress(SYNTHESIZED_WIRE_37),
	.q(signal3));


ram	b2v_inst7(
	.wren(SYNTHESIZED_WIRE_34),
	.rden(SYNTHESIZED_WIRE_35),
	.wrclock(SYNTHESIZED_WIRE_32),
	.rdclock(SYNTHESIZED_WIRE_33),
	.data(out4[32:17]),
	.rdaddress(SYNTHESIZED_WIRE_36),
	.wraddress(SYNTHESIZED_WIRE_37),
	.q(signal4));


count200	b2v_inst9(
	.clk(SYNTHESIZED_WIRE_32),
	.clr(SYNTHESIZED_WIRE_31),
	.co(wready),
	.count(SYNTHESIZED_WIRE_37));


endmodule
