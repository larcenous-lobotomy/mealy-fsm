module MealyFSM(input CLK, RST, IN, output OUT, output reg [1:0] STATE);
    reg [1:0] state, next_state;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

    //Sequential Register Logic 
    always @(posedge CLK, posedge RST)
        if(RST) begin
            state <= S0;
            STATE <= S0;
        end
        else begin
            state <= next_state;
            STATE <= next_state;
        end

    //Combinational Next-State Logic
    always @(*) 
        case(state)
            S0 : next_state = (IN) ? S2 : S1;
            S1 : next_state = (IN) ? S2 : S1;
            S2 : next_state = (IN) ? S2 : S1;
            default : next_state = S0;
        endcase

    //Combinational Output Logic
    assign OUT =  ((state == S1) && IN) || ((state == S2) && !IN); 

endmodule

`timescale 1ns/1ps
module testbench;
    reg CLK, RST, IN;
    wire out;
    wire [1:0] STATE;

    MealyFSM UUT(.CLK(CLK), .RST(RST), .IN(IN), .OUT(OUT), .STATE(STATE));
    

    always begin
    #20;
    CLK = ~CLK;
    end

    always begin 
    #80;
    IN = ~IN;    
    end 

    always begin
    #20;
    RST = ~RST;
    #30;
    RST = ~RST;
    #70;
    RST = ~RST;
    #90;
    RST = ~RST;
    end 


    initial
    begin
    $dumpfile ("FSM.vcd"); 
	$dumpvars(0, testbench);
    CLK = 0;
    RST = 0;
    IN = 0;
    end

endmodule
