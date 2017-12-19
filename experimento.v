module experimento(CLK, SW, HEX0, KEY[0], LEDG, LEDR);

input [1:0]SW; //SW[1]: entrando SW[0]: saindo
input CLK;
input [0:0]KEY; //sensor

output reg [6:0]HEX0; //Visor para mostrar sentido do giro
output [0:0]LEDG; //Led verde
output [1:0] LEDR; //LEDR[1]: luz vermelha e LEDR[0]: sinal soonoro 
reg [1:0]STATE; //estados

parameter I = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011, D = 3'b100, E = 3'101;

initial STATE = S;
always @(posedge CLK)
begin
	case(STATE)
		 I: if(SW[1] == 1 && SW[0] == 0)  STATE <= A;
		 else if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else if(SW[1] == 1 && SW[0] == 1) STATE <= C;
		 else STATE <= I;
		 
		 A: if(KEY[0] == 1) STATE <= D;
		 else STATE <= E;
		 
		 B: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <=B
		 
		 C: if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else STATE <= C;
		 
		 D: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <= D;
		 
		 E: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <= E;
		 
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
		E: HEX0 = 7'b0000001;
		
	endcase
end

assign LEDG[0] = (!STATE[1] & STATE[0]) | (STATE[1] & !STATE[0]); //VERDE 
assign LEDR[0] = (SATATE[1] & STATE[0]) | (STATE[2] & !STATE[0]); //VERMELHO
assign LEDR[1] = STATE[2] & STATE[0] //SOM

endmodule
