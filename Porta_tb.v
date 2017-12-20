module Porta_tb;
	
reg[2:0] SW_tb;
reg KEY_tb;

wire[6:0] HEX0_tb, HEX1_tb;
wire[1:0] LEDR_tb; 
wire[2:0] STATE_tb;
wire LEDG_tb;	

Porta dut(SW_tb, HEX0_tb, HEX1, KEY_tb, LEDG_tb, LEDR_tb);

initial
begin
 SW_tb[2] = 0; SW_tb[1] = 0; SW_tb[0] = 0; KEY_tb = 0; #1
 SW_tb[2] = 0; SW_tb[1] = 0; SW_tb[0] = 0; KEY_tb = 1; #1
 SW_tb[2] = 0; SW_tb[1] = 0; SW_tb[0] = 1; KEY_tb = 0; #1
 SW_tb[2] = 0; SW_tb[1] = 0; SW_tb[0] = 1; KEY_tb = 1; #1
 SW_tb[2] = 0; SW_tb[1] = 1; SW_tb[0] = 0; KEY_tb = 0; #1
 SW_tb[2] = 0; SW_tb[1] = 1; SW_tb[0] = 0; KEY_tb = 1; #1
 SW_tb[2] = 0; SW_tb[1] = 1; SW_tb[0] = 1; KEY_tb = 0; #1
 SW_tb[2] = 0; SW_tb[1] = 1; SW_tb[0] = 1; KEY_tb = 1; #1
 SW_tb[2] = 1; SW_tb[1] = 0; SW_tb[0] = 0; KEY_tb = 0; #1
 SW_tb[2] = 1; SW_tb[1] = 0; SW_tb[0] = 0; KEY_tb = 1; #1
 SW_tb[2] = 1; SW_tb[1] = 0; SW_tb[0] = 1; KEY_tb = 0; #1
 SW_tb[2] = 1; SW_tb[1] = 0; SW_tb[0] = 1; KEY_tb = 1; #1
 SW_tb[2] = 1; SW_tb[1] = 1; SW_tb[0] = 0; KEY_tb = 0; #1
 SW_tb[2] = 1; SW_tb[1] = 1; SW_tb[0] = 0; KEY_tb = 1; #1
 SW_tb[2] = 1; SW_tb[1] = 1; SW_tb[0] = 1; KEY_tb = 0; #1
 SW_tb[2] = 1; SW_tb[1] = 1; SW_tb[0] = 1; KEY_tb = 1; #1;
end
endmodule

