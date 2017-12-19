module PORTA(SW, HEX0, HEX1, KEY[0], LEDG, LEDR); //HEX1 é auxiliar para mostrar na placa em qual estado está

//ENTRADAS
input [2:0]SW; //SW[1]: entrando SW[0]: saindo
//input CLK; //foi substituido por key[0]
input [0:0]KEY;
//input [0:0]KEY; //sensor //foi substituido por SW[2]

//SAÍDAS
output reg [0:6]HEX0,HEX1; //Visor para mostrar sentido do giro
output [0:0]LEDG; //Led verde
output [1:0] LEDR; //LEDR[1]: luz vermelha e LEDR[0]: sinal soonoro 
reg [2:0]STATE; //estados

//Identificação dos estados
parameter I = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011, D = 3'b100, E = 3'b101;

initial STATE = I; //I é o estado inicial

//TRANSIÇÃO DOS ESTADOS
always @(posedge KEY[0]) //Repare que a borda de subida para transitar os estados é o pulso de KEY[0]
begin
	case(STATE)
		 I: if(SW[1] == 1 && SW[0] == 0)  STATE <= A;
		 else if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else if(SW[1] == 1 && SW[0] == 1) STATE <= C;
		 else STATE <= I;
		
		 A: if(SW[2] == 1) STATE <= D;
		 else STATE <= E;

		 B: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <=B;

		 C: if(SW[1] == 0 && SW[0] == 1) STATE <= B;
		 else STATE <= C;

		 D: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <= D;

		 E: if(SW[1] == 0 && SW[0] == 0) STATE <= I;
		 else STATE <= E;
		endcase
end

//no display:
//0110000 E
//0000001 D

always @ (STATE)
begin
	case(STATE)
		I: HEX0 = 7'b1111111;
		A: HEX0 = 7'b0000001;
		B: HEX0 = 7'b0110000;
		C: HEX0 = 7'b1111111;
		D: HEX0 = 7'b1111111;
		E: HEX0 = 7'b0000001;
	endcase
end

//Display auxiliar
always @ (STATE)
begin
	case(STATE)
		I: HEX1 = 7'b1000000; 
		A: HEX1 = 7'b0100000;
		B: HEX1 = 7'b0010000;
		C: HEX1 = 7'b0001000;
		D: HEX1 = 7'b0000100;
		E: HEX1 = 7'b0000010;
	endcase
end

//CIRCUITOS DE SAÍDA - precisa ser arrumado
assign LEDG[0] = (!STATE[1] & STATE[0]) | (STATE[1] & !STATE[0]); //VERDE 
assign LEDR[0] = (STATE[1] & STATE[0]) | (STATE[2] & !STATE[0]); //VERMELHO
assign LEDR[1] = STATE[2] & STATE[0]; //SOM

endmodule
