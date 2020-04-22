`timescale  1 ns / 100 ps
module count(valid,in,clk,en1,en2);
input clk,in, valid;
output en1,en2;
parameter TAGT_NUM = 64; //target元素个数
parameter TAGT_LENGTH = 6; //target地址长度
parameter REF_NUM = 1024; //referencr元素个数
parameter REF_LENGTH = 10; //reference地址长度

reg en1 = 0;
reg en2 = 0;
reg [6:0] count ;
reg[1:0] i;

always@(posedge clk or negedge valid or negedge in)
begin
  if(!valid)
    begin
    en1<= 'dz;
    en2<= 'dz;
    count <= 0;
    i <= 0;
    end
 else
  if((i < 2)&&in)
    i <= i+1;
  else
  begin
    i <= 0;
  if(in && count < TAGT_NUM)
    begin
	count <= count + 1;
	en1 <= 1;
	en2 <= 0;
    end
  else if(!in && count < TAGT_NUM)
    begin
	count <= 0;
	en1 <= 0;
	en2 <= 0;
    end
  else
    begin
	en2 <= 1;
	en1 <= 0;
    end
end
end
endmodule