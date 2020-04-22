`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/30 21:21:02
// Design Name: 
// Module Name: test_match
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


module test_match;

reg rst,clk;
wire out;
wire [9:0]loc1,loc2;

BWT_Match m(.rst(rst),.clk(clk),.loc1(loc1),.loc2(loc2),.out(out));



always #1 clk = ~clk;

initial
begin
    clk = 0;
    rst = 0; #20;
    rst = 1; #2000;
    rst = 0;
end
endmodule
