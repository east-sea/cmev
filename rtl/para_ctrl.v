// ---------------------------------------------- 
// Author  :    ktram   
// History :    Init          : TMP_DATE
// -----------------------------------------------

module para_ctrl (

  /*******************
  parameter PARA_DW = 'd12;

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
  ***************/
  input [4:0]           shift_bit,

  output reg [7:0]          round_num,
  output reg                offset_en,
  output reg [7:0]    [7:0] offset_val,

//_   input wire clk_in
  );

   
always@(*)   begin
  if (shift_bit < 'd8) begin
    shift_bit = 'd8 ;
  end  
  else if (shift_bit > 'd17)  begin // 'h11 = 'd17
    shift_bit = 'd17 ;
  end  
  case (shift_bit)
    'd8:  begin
          round_num = 'd2;
          offset_en = 'b1;
    end   
    'd9:  begin
          round_num = 'd5;
          offset_en = 'b1;
    end  
    'd10: begin
          round_num = 'd1;
          offset_en = 'b1;
    end  
    'd11: begin
          round_num = 'd2;
          offset_en = 'b1;
    end  
    'd12: begin
          round_num = 'd4;
          offset_en = 'b1;
    end  
    'd13: begin
          round_num = 'd8;
          offset_en = 'b1;
    end  
    'd14: begin
          round_num = 'd16;
          offset_en = 'b1;
    end  
    'd15: begin
          round_num = 'd33;
          offset_en = 'b0;
    end  
    'd16: begin
          round_num = 'd66;
          offset_en = 'b0;
    end  
    'd17: begin
          round_num = 'd131;
          offset_en = 'b0;
    end  



end    

/******************
  Shift_bit Round_num   
8  256    200
9  512    500
10 1024   1000
11 2048   2000
12 4096   4000
13 8192   8000
14 16384  16000
15 32768  33000
16 65536  66000
17 131072 131000
    




*****************/

endmodule



