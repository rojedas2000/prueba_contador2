module nibble_encoder(
	input clk,
	input [3:0] nibble_in,
	output [7:0] disp_code_out
);

//wire [3:0] nibble;
reg [7:0] disp_code;
//assign nibble = nibble_in;


always@(posedge clk)begin

	case(nibble_in)
	
	  4'd0:    disp_code <= 8'b1_1000000; // 0
      4'd1:    disp_code <= 8'b1_1111001; // 1
      4'd2:    disp_code <= 8'b1_0100100; // 2
      4'd3:    disp_code <= 8'b1_0110000; // 3
      4'd4:    disp_code <= 8'b1_0011001; // 4
      4'd5:    disp_code <= 8'b1_0010010; // 5
      4'd6:    disp_code <= 8'b1_0000010; // 6
      4'd7:    disp_code <= 8'b1_1111000; // 7
      4'd8:    disp_code <= 8'b1_0000000; // 8
      4'd9:    disp_code <= 8'b1_0010000; // 9
        default: disp_code <= 8'b1_1111111; // Apagado
	
	endcase
	
	
end

assign disp_code_out = disp_code;


endmodule

