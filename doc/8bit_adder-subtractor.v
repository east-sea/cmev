//_   8-bit adder/subtractor  http://vlsimaster.wordpress.com/tag/verilog-code-for-8-bit-addersubtractor/
module par_addsub(a,b,cin,sum,cout);
  input [7:0] a;
  input [7:0] b;
  input cin;
  output reg [7:0] sum;
  output reg cout;
  reg [8:0] c;
  integer i;

  always @ (a or b or cin)   begin

   c[0]=cin;
   if (cin == 0) begin
    for ( i=0; i<8 ; i=i+1)
    begin
     sum[i]= a[i]^b[i]^c[i];
     c[i+1]= (a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
    end
    end
    else if (cin == 1) begin
    for ( i=0; i<8 ; i=i+1)
    begin
    sum[i]= a[i]^(~ b[i])^c[i];
    c[i+1]= (a[i]&(~b[i]))|(a[i]&c[i])|((~b[i])&c[i]);
    end
    end
   cout=c[8];
  end
endmodule
