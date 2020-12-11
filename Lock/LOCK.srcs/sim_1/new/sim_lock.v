`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 18:32:00
// Design Name: 
// Module Name: sim_lock
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


module sim_lock(
    );
    reg [9:0]HWInput;
    wire [6:0]Figure1;
    wire [6:0]Figure2;
    wire [3:0]DN0;
    wire [3:0]DN1;
    reg CLK;
    wire Changed;
    Lock L(HWInput, Figure1, Figure2, DN0, DN1, Changed);
    initial
        begin
            HWInput = 1;
            CLK = 0;
        end
    always #1
        CLK = CLK + 1;
    always@(posedge CLK)
    begin
        HWInput = HWInput << 1;
        if(HWInput == 0)
            HWInput = 1;
    end
endmodule
