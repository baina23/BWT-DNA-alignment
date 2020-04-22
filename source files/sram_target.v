`timescale  1 ns / 100 ps
module sram_target
(
wData,
rData,
wEn,
rEn,
wAddr,
rAddr,
clk
);
parameter DEPTH = 18; 
parameter WIDTHS = 1920; 
parameter ADDR_WIDTH = 5; 

output reg [WIDTHS-1:0] rData;

input [WIDTHS-1:0] wData;
input clk;
input wEn, rEn;
input [ADDR_WIDTH-1:0] wAddr;
input [ADDR_WIDTH-1:0] rAddr;
reg [WIDTHS-1:0] memreg [0:DEPTH-1];
//integer k;
always @ (posedge clk) begin
  if (wEn) begin
    memreg[wAddr] <= wData;
  end
  
  if (rEn) begin
    rData <= memreg[rAddr];
 end
end

initial
begin
  $readmemb("C:/Users/yujie/Desktop/zyj_work/GenerateSequence/GenerateSequence/Target.txt",memreg);
end

endmodule
