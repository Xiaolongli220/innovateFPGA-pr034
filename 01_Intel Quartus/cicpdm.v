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
// CREATED		"Tue Mar 20 10:49:02 2018"

module cicpdm(
	reset_n,
	clk,
	in_valid,
	in_data1,
	in_data2,
	in_data3,
	in_data4,
	out_ready,
	in_error,
	o1,
	o2,
	o3,
	o4
);


input wire	reset_n;
input wire	clk;
input wire	in_valid;
input wire	in_data1;
input wire	in_data2;
input wire	in_data3;
input wire	in_data4;
input wire	out_ready;
input wire	[1:0] in_error;
output wire	[17:0] o1;
output wire	[17:0] o2;
output wire	[17:0] o3;
output wire	[17:0] o4;






cic	b2v_inst(
	.in_valid(in_valid),
	.in_data(in_data1),
	.out_ready(out_ready),
	.clk(clk),
	.reset_n(reset_n),
	.in_error(in_error),
	
	
	.out_data(o1)
	);


cic	b2v_inst2(
	.in_valid(in_valid),
	.in_data(in_data2),
	.out_ready(out_ready),
	.clk(clk),
	.reset_n(reset_n),
	.in_error(in_error),
	
	
	.out_data(o2)
	);


cic	b2v_inst3(
	.in_valid(in_valid),
	.in_data(in_data3),
	.out_ready(out_ready),
	.clk(clk),
	.reset_n(reset_n),
	.in_error(in_error),
	
	
	.out_data(o3)
	);


cic	b2v_inst4(
	.in_valid(in_valid),
	.in_data(in_data4),
	.out_ready(out_ready),
	.clk(clk),
	.reset_n(reset_n),
	.in_error(in_error),
	
	
	.out_data(o4)
	);


endmodule
