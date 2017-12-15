module experimento(CLK, SW, HEX0, KEY[0], LEDG, LEDR);

input [1:0]SW; //SW[1]: entrando SW[0]: saindo
input CLK;
input [0:0]KEY;

output reg [6:0]HEX0;
output [0:0]LEDG, LEDR;
reg [1:0]STATE;

parameter S = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011, D = 3'b100, E = 3'101, F = 3'110;

initial STATE = S;
always @(posedge CLK)
begin
	case(STATE)
		 S: if(SW[1] == 1 && SW[0] == 0)  STATE <= A;
		 else if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else if(SW[1] == 1 && SW[0] == 1) STATE <= C;
		 else STATE <= S;
		 
		 A: if(KEY[0] == 1) STATE <= D;
		 else STATE <= E;
		 
		 B: STATE <= F;
		 
		 C: if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else STATE <= C;
		 
		 D: STATE <= S;
		 
		 E: STATE <= S;
		 
		 F: STATE <= S;
		 
		endcase
end

//0110000 E
//0000001 D

always @ (STATE)
begin
	case(STATE)
		S: HEX0 = 7'b1111111;
		A: HEX0 = 7'b0000001;
		B: HEX0 = 7'b0110000;
		C: HEX0 = 7'b1111111;
		D: HEX0 = 7'b1111111;
		E: HEX0 = 7'b1111111;
		F: HEX0 = 7'b0110000;
	endcase
end

/*assign LEDG[0] = (~STATE[1] && STATE[0]);
assign LEDR[0] = (STATE[1] && STATE[0]);*/

endmodule
