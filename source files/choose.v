`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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


module choose(sig,rEn,rAddr0,rAddr1,clk,data0,data1);
input[1:0] sig;
input rEn;
input[9:0] rAddr0,rAddr1;
input clk;
output[9:0] data0,data1;

parameter TAGT_NUM = 64; //target元素个数
parameter TAGT_LENGTH = 6; //target地址长度
parameter REF_NUM = 1024; //referencr元素个数
parameter REF_LENGTH = 10; //reference地址长度
wire [1:0]sig;
wire rEn;
wire[9:0] rAddr0,rAddr1;
wire [9:0]rData0[0:3];
wire [9:0]rData1[0:3];
reg [9:0]data0,data1;
    
    sram_OCCA #(.DEPTH(REF_NUM),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(REF_LENGTH)) OCCA(.rData0(rData0[0]),.rData1(rData1[0]),.rEn(rEn),.rAddr0(rAddr0),.rAddr1(rAddr1),.clk(clk));
    sram_OCCC #(.DEPTH(REF_NUM),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(REF_LENGTH)) OCCC(.rData0(rData0[1]),.rData1(rData1[1]),.rEn(rEn),.rAddr0(rAddr0),.rAddr1(rAddr1),.clk(clk));
    sram_OCCG #(.DEPTH(REF_NUM),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(REF_LENGTH)) OCCG(.rData0(rData0[2]),.rData1(rData1[2]),.rEn(rEn),.rAddr0(rAddr0),.rAddr1(rAddr1),.clk(clk));
    sram_OCCT #(.DEPTH(REF_NUM),.WIDTHS(REF_LENGTH),.ADDR_WIDTH(REF_LENGTH)) OCCT(.rData0(rData0[3]),.rData1(rData1[3]),.rEn(rEn),.rAddr0(rAddr0),.rAddr1(rAddr1),.clk(clk));
  
   always@(*)
   case(sig)
    2'b00:begin 
            data0 = rData0[0];
            data1 = rData1[0];
          end
    2'b01:begin 
            data0 = rData0[1];
            data1 = rData1[1];
          end
    2'b10:begin
            data0 = rData0[2];
            data1 = rData1[2];
          end
    2'b11:begin
            data0 = rData0[3];
            data1 = rData1[3];
          end
    endcase

endmodule
