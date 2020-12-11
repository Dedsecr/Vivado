`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 15:36:33
// Design Name: 
// Module Name: InputNum
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


module InputNum(
    Num, Input
    );
    input [7:0]Num;
    output [7:0]Input;
    reg [7:0]RegNum;
    reg [3:0]Number;
    reg [7:0]Input;
    //assign Input[7] = 0;
    //assign Input[8] = 0;
    reg LOCKED;
    initial
        begin
            Input = 0;
            Number = 0;
            RegNum = 0;
            LOCKED = 0;
        end
    always #1
        begin
            Number = 0;
            #1 RegNum = Num;
            if(RegNum & 10'b1000_000_000)
                Number = Number + 1;
            if(RegNum & 10'b0100_000_000)
                Number = Number + 1;
            if(RegNum & 10'b0010_000_000)
                Number = Number + 1;
            if(RegNum & 10'b0001_000_000)
                Number = Number + 1;
            if(RegNum & 10'b0000_100_000)
                Number = Number + 1;
            if(RegNum & 10'b0000_010_000)
                Number = Number + 1;
            if(RegNum & 10'b0000_001_000)
                Number = Number + 1;
            if(RegNum & 10'b0000_000_100)
                Number = Number + 1;
            if(RegNum & 10'b0000_000_010)
                Number = Number + 1;
            if(RegNum & 10'b0000_000_001)
                Number = Number + 1;
            if(Number == 1 && LOCKED == 0)
                begin
                    Input = Num;
                    LOCKED = 1;
                    #5 Input = 0;
                end
            if(Number == 0)
                begin
                    LOCKED = 0;
                end
        end
endmodule
