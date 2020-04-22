`timescale  1 ns / 100 ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: YuJie Zhang
// 
// Create Date: 2019/06/30 17:06:36
// Design Name: 
// Module Name: choose
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BWT_Match (clk,loc1,loc2,rst,out);
parameter TAGT_NUM = 32; //target元素个数
parameter TAGT_LENGTH = 5; //target地址长度
parameter REF_NUM = 1024; //reference元素个数
parameter REF_LENGTH = 10; //reference地址长度
input clk,rst;
output [REF_LENGTH-1:0] loc1,loc2;
output out;//标志本次匹配结束

reg rEn0,rEn1,rEn_data,valid,out,rEn_SA;
reg [TAGT_LENGTH:0] rAddr_data;
reg[2:0]  i;
reg [REF_LENGTH-1:0] R_head,R_tail;
wire [1:0]  rAddr1,data_in; 
wire en1, en2, rst, in;
wire[REF_LENGTH-1:0]data0,data1,rData1,rAddr00,rAddr01;
wire[1:0] sigl;
wire [REF_LENGTH-1:0] data_SA[1:0];
wire [REF_LENGTH-1:0] rAddr_SA[1:0];

count #(.TAGT_NUM(TAGT_NUM),.TAGT_LENGTH(TAGT_LENGTH),.REF_NUM(REF_NUM),.REF_LENGTH(REF_LENGTH)) c1(.valid(valid),.in(in),.clk(clk),.en1(en1),.en2(en2));
choose #(.TAGT_NUM(TAGT_NUM),.TAGT_LENGTH(TAGT_LENGTH),.REF_NUM(REF_NUM),.REF_LENGTH(REF_LENGTH)) OCC(.sig(sigl),.rEn(rEn0),.rAddr0(rAddr00),.rAddr1(rAddr01),.clk(clk),.data0(data0),.data1(data1));
sram_Hy_single #(.DEPTH(4),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(2)) C(.rData(rData1),.rEn(rEn1),.rAddr(rAddr1),.clk(clk)); 
sram_target #(.DEPTH(TAGT_NUM),.WIDTHS(2),.ADDR_WIDTH(TAGT_LENGTH)) target(.rData(data_in),.rEn(rEn_data),.rAddr(rAddr_data),.clk(clk));
sram_SA #(.DEPTH(REF_NUM),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(REF_LENGTH)) SA(.rData0(data_SA[0]),.rData1(data_SA[1]),.rEn(rEn_SA),.rAddr0(rAddr_SA[0]),.rAddr1(rAddr_SA[1]),.clk(clk));

assign in = (R_head>=R_tail)? 1:0;
assign sigl = data_in;
assign rAddr1 = data_in;
assign rAddr00 = R_head;
assign rAddr01 = (R_tail==0)?0:R_tail-1;
assign rAddr_SA[0] = (en2)? R_tail:0;
assign rAddr_SA[1] = (en2)? R_head:0;
assign loc1 = (out)?data_SA[0]:0;
assign loc2 = (out)?data_SA[1]:0;


always@(posedge clk or negedge rst)
if(!rst)
   begin
    rAddr_data <= TAGT_NUM;
    valid <= 0;
    R_head <= 'bz;
    R_tail <= 'bz;
    out <= 0;
    rEn0 <= 0;
    rEn1 <= 0;
    rEn_data <= 1;
    rEn_SA <= 0;
    i <= 0;
   end
else
    if(i < 2)
        i <= i+1;
    else
    begin
        i <= 0;
     if(rAddr_data == TAGT_NUM)
         begin
            R_head <= REF_NUM - 1;
            R_tail <= 1;
            valid <= 1;
            rEn0 <= 1;
            rEn1 <= 1;
            rEn_SA <= 1;
            rEn_data <= 1;
            rAddr_data <= rAddr_data - 1;
         end
    else if (en1 && !en2 && rAddr_data > 0)
	     begin
            R_head <= data0 + rData1-1;
            R_tail <= data1 + rData1 ;
            rAddr_data <= rAddr_data - 1;
	     end
	else if (en1 && !en2 && rAddr_data == 0)
	     begin
	         R_head <= data0 + rData1-1;
             R_tail <= data1 + rData1 ;
         end
	else if(en2||(!en1 && !en2))
	     begin
	        rEn0 <= 0;
	        rEn1 <= 0;
	        out <= 1;
	     end
    end

endmodule


