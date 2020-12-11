`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 15:40:20
// Design Name: 
// Module Name: Lock
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


module Lock(
    CLK, Input, Figure1, Figure2, ChangeButton, LockButton, DN0, DN1, Status, Open, CheckRes, Block_Start
    );
    input CLK;
    input [7:0]Input;
    input LockButton;
    input ChangeButton;
    output [6:0]Figure1;
    output [6:0]Figure2;
    output [3:0]DN0;
    output [3:0]DN1;
    output [7:0]Status;
    output Open, CheckRes;
    output Block_Start;
    reg [7:0]Num1;
    reg [7:0]Num2;
    reg [7:0]Num3;
    reg [7:0]Num4;
    reg [9:0]Num5;
    reg [9:0]Num6;
    reg [3:0]Epoch;
    reg [7:0]Base;
    reg [7:0]Status;
    reg [7:0]PWD1;
    reg [7:0]PWD2;
    reg [7:0]PWD3;
    reg [7:0]PWD4;
    reg Open, ToLow, ChangePWDMode, Determine2Open, Changed, SecurityMode_Start, Block_Start;
    wire CLK_1ms_CLK, CheckRes, CLK_1s_CLK, BlockTimeUp, SecurityModeTimeUp;
    wire [9:0]BlockTime;
    wire [9:0]SecurityModeTime1;
    wire [9:0]SecurityModeTime2; 
    Clock_1ms CLK1ms(CLK, CLK_1ms_CLK);
    Clock_1s CLK1s(CLK, CLK_1s_CLK);
    DisplayNum DpNm(CLK, Num1, Num2, Num3, Num4, Num5, Num6, Figure1, Figure2, DN0, DN1);
    CheckPWD CPWD(Num1, Num2, Num3, Num4, PWD1, PWD2, PWD3, PWD4, CheckRes);
    Block Bl(CLK_1s_CLK, CLK_1ms_CLK, Block_Start, BlockTimeUp, BlockTime);
    SecurityMode SeM(CLK_1s_CLK, CLK_1ms_CLK, SecurityMode_Start, SecurityModeTimeUp, SecurityModeTime1, SecurityModeTime2);
    initial
    begin
        Num1 = 1;
        Num2 = 1;
        Num3 = 1;
        Num4 = 1;
        Num5 = 0;
        Num6 = 0;
        Epoch = 0;
        Changed = 0;
        Base = 0;
        Open = 1;
        PWD1 = 1;
        PWD2 = 1;
        PWD3 = 1;
        PWD4 = 1;
        ChangePWDMode = 0;
        SecurityMode_Start = 0;
        ToLow = 0;
        Determine2Open = 0;
        Block_Start = 0;
    end
    always@(negedge CLK_1ms_CLK)
    begin
        if(Input - Base > 0)
            Changed = 1;
        else 
        begin
           Changed = 0;
        end
        Status = Input;
    end
    always@(posedge CLK_1ms_CLK)
    begin
        if(Determine2Open)
        begin
            if(CheckRes)
                Open = 1;
            else 
                SecurityCounter = SecurityCounter + 1;
            Determine2Open = 0;
        end
        if(Block_Start && BlockTimeUp)
        begin
            Block_Start = 0;
            SecurityCounter = SecurityCounter + 1;
            Epoch = 0;
        end
        if(!Changed)
            ToLow = 0; 
        if(Changed && !ToLow && !ChangePWDMode)
        begin
            if(!Open)
            begin
                if(Epoch == 0)
                begin
                    Num1 <= Input;
                    Block_Start = 1;
                end
                else if(Epoch == 1)
                    Num2 <= Input;
                else if(Epoch == 2)
                    Num3 <= Input;
                else if(Epoch == 3)
                    Num4 <= Input;
                Epoch = Epoch + 1;
                ToLow = 1;
                if(Epoch == 4)
                begin
                    Epoch = 0;
                    Determine2Open = 1;
                    Block_Start = 0;
                end
            end
        end
        else if(Changed && !ToLow && ChangePWDMode)
        begin
            if(Epoch == 0)
            begin
                Num1 <= Input;
                PWD1 <= Input;
            end
            else if(Epoch == 1)
            begin
                Num2 <= Input;
                PWD2 <= Input;
            end
            else if(Epoch == 2)
            begin
                Num3 <= Input;
                PWD3 <= Input;
            end
            else if(Epoch == 3)
            begin
                Num4 <= Input;
                PWD4 <= Input;
            end
            Epoch = Epoch + 1;
            ToLow = 1;
            if(Epoch == 4)
            begin
                Epoch = 0;
                ChangePWDMode = 0;
            end
        end
        else if(LockButton)
            Open = 0;
        else if(CheckRes && Open && ChangeButton)
            ChangePWDMode = 1;
        
    end
    always@(posedge CLK_1ms_CLK)
    begin
        if(Block_Start)
        begin
            Num5 <= 1;
            Num6 <= BlockTime;
        end
        else
        begin
            Num5 <= 1;
            Num6 <= 1;
        end
    end
    //always@(posedge ChangeButton)
    //    if(CheckRes && Open)
    //        ChangePWDMode = 1;
    /*always@(posedge CLK_1ms_CLK)
    begin
        if(ChangePWDMode)
            if(Epoch == 4)
            begin
                Epoch = 0;
                ChangePWDMode = 0;
            end
            else
            begin
                if(Epoch == 0)
                begin
                    Num1 <= Input;
                    PWD1 <= Input;
                end
                else if(Epoch == 1)
                begin
                    Num2 <= Input;
                    PWD2 <= Input;
                end
                else if(Epoch == 2)
                begin
                    Num3 <= Input;
                    PWD3 <= Input;
                end
                else if(Epoch == 3)
                begin
                    Num4 <= Input;
                    PWD4 <= Input;
                end
                Epoch = Epoch + 1;
            end
    end*/
endmodule
