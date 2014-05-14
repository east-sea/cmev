//Module : common library
//Date : 7/May/2014
//Author : hoang.phung

`define DFT_DELAY 1
module dff #(parameter SIZE=1) (clk, d, q);
 input clk;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk) q <= #`DFT_DELAY d;
endmodule

module dff_en #(parameter SIZE=1) (clk, en, d, q);
 input clk,en;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk) begin
  if (en) q <= #`DFT_DELAY d;
 end
endmodule

module dff_arst #(parameter SIZE=1) (clk, rst_n, d, q);
 input clk,rst_n;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk or negedge rst_n) begin
  if (~rst_n) q <= #`DFT_DELAY 'b0;
  else q <= #`DFT_DELAY d;
 end
endmodule

module dff_arst_en #(parameter SIZE=1) (clk, rst_n, en, d, q);
 input clk,rst_n,en;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk or negedge rst_n) begin
  if (~rst_n) q <= #`DFT_DELAY 'b0;
  else if (en) q <= #`DFT_DELAY d;
 end
endmodule

module dff_srst #(parameter SIZE=1) (clk, rst_n, d, q);
 input clk,rst_n;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk) begin
  if (~rst_n) q <= #`DFT_DELAY 'b0;
  else q <= #`DFT_DELAY d;
 end
endmodule

module dff_srst_en #(parameter SIZE=1) (clk, rst_n, en, d, q);
 input clk,rst_n,en;
 input [SIZE-1:0] d;
 output [SIZE-1:0] q;
 reg [SIZE-1:0] q;
 always @ (posedge clk) begin
  if (~rst_n) q <= #`DFT_DELAY 'b0;
  else if (en) q <= #`DFT_DELAY d;
 end
endmodule

module mux21 #(parameter SIZE=1) (d0, d1, sel, y);
 input [SIZE-1:0] d0,d1;
 input sel;
 output [SIZE-1:0] y;
 assign y = sel ? d1 : d0;
endmodule

module dlat (en, d, q);
 input en, d;
 output q;
 reg q;
 always @ (en or d) begin
  if (en) q <= d;
 end
endmodule

module dlat_rst (en, rst_n, d, q);
 input en, rst_n, d;
 output q;
 reg q;
 always @ (en or rst_n or d) begin
  if (~rst_n) q <= 1'b0;
  else if (en) q <= d;
 end
endmodule

//Unsigned adders
module hadder #(parameter SIZE=1) (output cout, [SIZE-1:0] sum, input [SIZE-1:0] a, b);
 assign {cout,sum} = a + b;
endmodule

module fadder #(parameter SIZE=1) (output cout, [SIZE-1:0] sum, input [SIZE-1:0] a, b, input cin);
 assign {cout,sum} = a + b + cin;
endmodule
