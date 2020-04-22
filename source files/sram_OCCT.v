//`timescale 1ns / 100ps
//`include "macro.h"
`timescale  1 ns / 100 ps
module sram_OCCT
(
wData,
rData0,
rData1,
wEn,
rEn,
wAddr,
rAddr0,
rAddr1,
clk
);
parameter DEPTH = 18; 
parameter WIDTHS = 1920; 
parameter ADDR_WIDTH = 5; 

output reg [WIDTHS-1:0] rData0,rData1;

input [WIDTHS-1:0] wData;
input clk;
input wEn, rEn;
input [ADDR_WIDTH-1:0] wAddr;
input [ADDR_WIDTH-1:0] rAddr0, rAddr1;
reg [WIDTHS-1:0] memreg [0:DEPTH-1];
//integer k;
always @ (posedge clk) begin
  if (wEn) begin
    memreg[wAddr] <= wData;
  end
  
  if (rEn) begin
    rData0 <= memreg[rAddr0];
    rData1 <= memreg[rAddr1];
 end
end


initial
begin
  $readmemb("C:/Users/yujie/Desktop/zyj_work/exact_match/exact_match/OCCT.txt",memreg);
end

endmodule
