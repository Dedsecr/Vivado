`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/12 11:11:12
// Design Name: 
// Module Name: Alarm
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


module Alarm(
    CLK, Alarm_Start, Alarm_Out
    );
    input Alarm_Start, CLK;
    output Alarm_Out;
    wire Alarm_Out;
    reg [3:0]AlarmCounter;
    reg Available, Alarm_CLK;
    reg [31:0]Counter;
    assign Alarm_Out = Available & AlarmCounter[0];
    initial
    begin
        Counter = 0;
        Alarm_CLK = 0;
        AlarmCounter = 0;
        Available = 0;
    end
    always@(posedge CLK)
    begin
        if(Counter == 20000000)
        begin
            Counter = 0;
            Alarm_CLK = Alarm_CLK ^ 1;
        end
        else
            Counter = Counter + 1;
    end
    always@(posedge Alarm_CLK)
    begin
        AlarmCounter = AlarmCounter + 1;
        if(!Available)
            AlarmCounter = 0;
    end
    always@(posedge Alarm_Start or posedge AlarmCounter[2])
    begin
        if(Alarm_Start)
            Available = 1;
        if(AlarmCounter[2])
            Available = 0;
    end
endmodule
