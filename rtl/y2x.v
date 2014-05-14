// ---------------------------------------------- 
// Author  :    ktram   
// History :    Init          : TMP_DATE
// -----------------------------------------------

module y2x #(parameter PARA_DW = 'd12) (

  input [PARA_DW-1:0]   y2r_00,
  input [PARA_DW-1:0]   y2r_01,
  input [PARA_DW-1:0]   y2r_02,
  //-
  input [PARA_DW-1:0]   y2r_10,
  input [PARA_DW-1:0]   y2r_11,
  input [PARA_DW-1:0]   y2r_12,
  //-
  input [PARA_DW-1:0]   y2r_20,
  input [PARA_DW-1:0]   y2r_21,
  input [PARA_DW-1:0]   y2r_22,
  //-
  input [PARA_DW-1+8:0]   y2r_03,
  input [PARA_DW-1+8:0]   y2r_13,
  input [PARA_DW-1+8:0]   y2r_23,
  //--
  input [7:0]          in_y,    //unsign
  input [7:0]          in_xb,   // unsign
  input [7:0]          in_xr,   // unsign
  //--
  input [11:0]         add_sub_ctrl,
  input [7:0]          round_num,
  input [4:0]          shift_num,

  //--
  output reg [7:0]    pre_r,
  output reg [7:0]    pre_g,
  output reg [7:0]    pre_b

  );

  


endmodule


module multi #(parameter A_DW= 'd12, parameter B_DW= 'd8) (a , b , result);
  

  parameter  Q_DW = A_DW + B_DW ;

  input [A_DW-1 :0] a;
  input [B_DW-1 :0] b;

  output [Q_DW -1 :0] result;

  wire [A_DW-1:0] [Q_DW-1:0] out_tmp;

  for (i=0; i < A_DW; i ++) begin
    assign out_tmp[i]  = (a[ i] == 1'b1) ? {((A_DW-1) -i)'h{0},  b,  (i)'h0} : (Q_DW-1)'h0; 
  end  

  for (i=0; i < Q_DW; i ++) begin
    assign result  = result + out_tmp[i]; 
  end  
  
/*****  
  assign out_10 = (a[10] == 1'b1) ? { 1'h0   b, 10'h0} : 19'h0; 
  assign out_9  = (a[ 9] == 1'b1) ? { 2'h0,  b,  9'h0} : 19'h0; 
  assign out_8  = (a[ 8] == 1'b1) ? { 3'h0,  b,  8'h0} : 19'h0; 
  assign out_7  = (a[ 7] == 1'b1) ? { 4'h0,  b,  7'h0} : 19'h0; 
  assign out_6  = (a[ 6] == 1'b1) ? { 5'h0,  b,  6'h0} : 19'h0; 
  assign out_5  = (a[ 5] == 1'b1) ? { 6'h0,  b,  5'h0} : 19'h0; 
  assign out_4  = (a[ 4] == 1'b1) ? { 7'h0,  b,  4'h0} : 19'h0; 
  assign out_3  = (a[ 3] == 1'b1) ? { 8'h0,  b,  3'h0} : 19'h0; 
  assign out_2  = (a[ 2] == 1'b1) ? { 9'h0,  b,  2'h0} : 19'h0; 
  assign out_1  = (a[ 1] == 1'b1) ? {10'h0,  b,  1'h0} : 19'h0; 
  assign out_0  = (a[ 0] == 1'b1) ? {11'h0,  b,  0'h0} : 19'h0; 
  assign result =   out_0 + out_1 + out_2 + out_3 + out_4 
                  + out_5 + out_6 + out_7 + out_8 + out_9 + out_10;
*****/

  
endmodule

