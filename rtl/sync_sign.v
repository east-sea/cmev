// --- 
// ktram
// History :    Init          : 14-May-2014
// -----------------------------------------------


module sync_sign (
  input [7:0]         in_y,
  input [7:0]         in_xb,
  input [7:0]         in_xr,
  input [1:0]         mode,

  output reg [7:0]     o_usign_y,  
  output reg [7:0]     o_usign_xb,  
  output reg [7:0]     o_usign_xr,  
  output reg [7:0]     thresh_low,  
  output reg [7:0]     thresh_hi,  
  output reg [11:0]    add_sub_ctr,  

  input               reset_n;
  input               clk_in
  );
  // param define:
  parameter  YP2RGB = 2'b00;
  parameter  YC2RGB = 2'b01;
  parameter  YU2RGB = 2'b10;
  /****
ypbpr 2 rgb   [ [1   0.000  1.575  0]  ;   // add_sub_ctr[11 ,10, 9, 8]
                [1  -0.187 -0.468  0]  ;   // add_sub_ctr[ 7 , 6, 5, 4]
                [1   1.856  0.000  0]   ]; // add_sub_ctr[ 3 , 2, 1, 0]
  ****/
  parameter  ADD_SUB_YP2RGB = 11'b0000_0110_0000;    // 0: (+) / 1: (-)
  
  //Init
//_   initial begin
//_     o_usign_y  = 0;
//_     o_usign_xb = 0;
//_     o_usign_xr = 0;
//_   end

  
  wire [7:0] in_y_t; 
  wire [7:0] in_xb_t; 
  wire [7:0] in_xr_t; 
  // gate by 1FF
  dff_arst#(8) sync_y  (clk_in, reset_n, in_y, in_y_t); 
  dff_arst#(8) sync_xb (clk_in, reset_n, in_xb, in_xb_t); 
  dff_arst#(8) sync_xr (clk_in, reset_n, in_xr, in_xr_t); 

  //  
  always@(*)   begin
    o_usign_y = in_y_t ;  // y always positive value

    case (mode)  
      YP2RGB : begin
               thresh_low  = 8'h0;
               thresh_hi   = 8'hFF;
               add_sub_org = ADD_SUB_YP2RGB;
               add_sub_ctr = add_sub_org;
               // 
               o_usign_xb      = (in_xb[7]) ? ({0,in_xb_t[6:0]} + 1'b1) : in_xb_t[7:0];
               add_sub_ctr[10] = (in_xb[7]) ? (~ add_sub_org[10]) : add_sub_org[10];
               add_sub_ctr[ 6] = (in_xb[7]) ? (~ add_sub_org[ 6]) : add_sub_org[ 6];
               add_sub_ctr[ 2] = (in_xb[7]) ? (~ add_sub_org[ 2]) : add_sub_org[ 2];
               
               o_usign_xr      = (in_xr[7]) ? ({0,in_xr_t[6:0]} + 1'b1) : in_xr_t[7:0];
               add_sub_ctr[9]  = (in_xr[7]) ? (~ add_sub_org[ 9]}) : add_sub_org[ 9];
               add_sub_ctr[5]  = (in_xr[7]) ? (~ add_sub_org[ 5]}) : add_sub_org[ 5];
               add_sub_ctr[1]  = (in_xr[7]) ? (~ add_sub_org[ 1]}) : add_sub_org[ 1];
      end

    endcase

  end
endmodule

