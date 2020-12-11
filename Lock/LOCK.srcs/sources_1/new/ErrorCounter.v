`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/11 14:24:00
// Design Name: 
// Module Name: ErrorCounter
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


module ErrorCounter(
    CLK_1s_CLK, CLK_1ms_CLK, ErrorHappen, ErrorTimesReset, ErrorTimesUp
    );
    input CLK_1s_CLK, CLK_1ms_CLK, ErrorHappen, ErrorTimesReset;
    output ErrorTimesUp;
    reg ErrorTimesUp;
    reg [7:0]ErrorTimer;
    initial
    begin
        ErrorTimer = 0;
        ErrorTimesUp = 0;
    end
    always@(posedge ErrorHappen or posedge ErrorTimesReset)
    begin
        if(ErrorHappen)
        begin
            ErrorTimer = ErrorTimer + 1;
        end
        if(ErrorTimer == 5)
        begin
            ErrorTimesUp = 1;
        end
        if(ErrorTimesReset)
        begin
            ErrorTimesUp = 0;
            ErrorTimer = 0;
        end
    end
endmodule

