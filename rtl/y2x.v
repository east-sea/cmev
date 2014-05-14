// ---------------------------------------------- 
// Author  :    ktram   
// History :    Init          : TMP_DATE
// -----------------------------------------------

module y2x #(parameter PARA_DW = 'd12) (

  input [PARA_DW-1:0]   y2r_00,
  input [PARA_DW-1:0]   y2r_01,
  input [PARA_DW-1:0]   y2r_02,
  //-
  input [PARA_DW-1+8:0]   y2r_03,
  //--
  input [7:0]          in_y,    //unsign
  input [7:0]          in_xb,    //unsign
  input [7:0]          in_xr,    //unsign
  //--
  input [3:0]          add_sub_ctrl,
  input [7:0]          round_num,
  input [4:0]          shift_num,
  //--
  output reg [7:0]    pre_r,
  );

  reg [PARA_DW+8 - 1 : 0] y2r_00_mul_y;
  reg [PARA_DW+8 - 1 : 0] y2r_01_mul_xb;
  reg [PARA_DW+8 - 1 : 0] y2r_02_mul_xr;
  reg [PARA_DW+8 : 0]     r_tmp;
  reg [31 : 0]            r_tmp_2;

  multi#(PARA_DW, 8)  (y2r_00, in_y , y2r_00_mul_y) ;
  multi#(PARA_DW, 8)  (y2r_01, in_xb, y2r_00_mul_xb) ;
  multi#(PARA_DW, 8)  (y2r_01, in_xr, y2r_00_mul_xr) ;

  addsub_tmp #(PARA_DW+8)  (y2r_00_mul_y, y2r_01_mul_xb, y2r_02_mul_xr, y2r_03, add_sub_ctrl, r_tmp);

  // scale :
  r_tmp_2 = r_tmp << round_num;
  pre_r   = r_tmp_2 >> shift_num;

endmodule

//_ module scale_complete (

//_   );
  

//_ endmodule  

module addsub #(parameter A_DW ='d 20) (
  input [A_DW-1:0] in_1,
  input [A_DW-1:0] in_2,
  input            carry_in,

  output reg [A_DW-1:0] sum,
  output reg       carry_out
  )

  // ---
  reg [A_DW:0]   c_tmp;
  integer     i;

  always @ (in_1 or in_2 or carry_in)   begin
    c_tmp[0]=carry_in;
    if (carry_in == 0) begin  // is adder
      for ( i=0; i< A_DW ; i=i+1)
      begin
        sum[i]= in_1[i]^in_2[i]^ c_tmp[i];
        c_tmp[i+1]= (in_1[i]&in_2[i]) |  (in_1[i]&c_tmp[i]) | (in_2[i]&c_tmp[i]);
      end
    end

    else if (carry_in == 1) begin  // subtractor
      for ( i=0; i<A_DW ; i=i+1)
      begin
        sum[i] = in_1[i]^ (~ in_2[i]) ^ c_tmp[i];
        c_tmp[i+1]= (in_1[i] & (~in_2[i]))  |  (in_1[i]&c_tmp[i]) | ((~in_2[i])&c_tmp[i]);
      end
    end
    carry_out=c_tmp[A_DW];
  end
endmodule


module multi #(parameter A_DW= 'd12, parameter B_DW= 'd8) (a , b , result);
  

  parameter  Q_DW = A_DW + B_DW ;

  input [A_DW-1 :0] a;
  input [B_DW-1 :0] b;
  integer           i;

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



/// --- not use ------------
module addsub_tmp #(
  parameter A_DW = 'd20 
//_   parameter B_DW = 'd20, 
//_   parameter C_DW = 'd20, parameter D_DW = 'd20, 
  ) 
  (
  input [A_DW-1:0] in_a,
  input [A_DW-1:0] in_b,
  input [A_DW-1:0] in_c,
  input [A_DW-1:0] in_d,
  input [3:0]          add_sub_en,	  //  0, add; 1: subtract
  output reg [A_DW:0] result
  );
  reg [A_DW+1:0] q ;
   
  always @ (*) begin
    case (add_sub_en[2:0]) 
      3'b111 : begin
               result = in_a - in_b - in_c - in_d;
      end
      3'b110 : begin
               result = in_a - in_b - in_c + in_d;
      end
      3'b101 : begin
               result = in_a - in_b + in_c - in_d;
      end
      3'b100 : begin
               result = in_a - in_b + in_c + in_d;
      end
      3'b011 : begin
               result = in_a + in_b - in_c - in_d;
      end
      3'b010 : begin
               result = in_a + in_b - in_c + in_d;
      end
      3'b001 : begin
               result = in_a + in_b + in_c - in_d;
      end
      3'b000 : begin
               result = in_a + in_b + in_c + in_d;
      end
    endcase  
    if (result < 0) result = (~result) + 1'b1;
  end

  


endmodule

