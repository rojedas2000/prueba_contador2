
module contador_display(
    input clk,          // Reloj de 50MHz
    input rst,          // Reset
    output [7:0] segmentos, 
    output [3:0] sel_seg
	 //output [7:0] contador_reg
);

//divisor de reloj
parameter CLK_MAX = 25'd6_249_999;
reg [24:0] clk_div;
reg clk_4hz;
//wire rst_n = !rst;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        clk_div <= 25'd0;
        clk_4hz <= 1'b0;
    end else if(clk_div == CLK_MAX) begin
        clk_div <= 25'd0;
        clk_4hz <= ~clk_4hz;
    end else begin
        clk_div <= clk_div + 1'b1;
    end
end

// contador
reg [7:0] bit_count;
always @(posedge clk_4hz or negedge rst) begin
    if(!rst) bit_count <= 8'd0;
    else bit_count <= bit_count + 1'b1;
end

	wire [7:0] tmp_uni, tmp_dec, tmp_cen;
	wire [3:0] uni, dec, cen;	
assign tmp_uni = (bit_count % 10); // la unidad es el sobrante de dividir entre 10
assign tmp_dec = ((bit_count / 10) % 10); //las decenas el sobrante de dividir entre 100
assign tmp_cen = (bit_count / 100); //las centenas solo son dividir entre 100

assign uni = tmp_uni [3:0];
assign dec = tmp_dec [3:0];
assign cen = tmp_cen [3:0];


// reloj 1kHz para display
reg [15:0] clk_disp;
always @(posedge clk or negedge rst) begin
    if(!rst) clk_disp <= 16'd0;
    else clk_disp <= clk_disp + 1'b1;
end
wire [1:0] sel = clk_disp[15:14];
wire [7:0] cod_uni, cod_dec, cod_cen;




nibble_encoder inst_u (
	.nibble_in(uni),
	.disp_code_out(cod_uni),
	.clk(clk)
);
nibble_encoder inst_d (
	.nibble_in(dec), 
	.disp_code_out(cod_dec), 
	.clk(clk)
);
nibble_encoder inst_c (
	.nibble_in(cen), 
	.disp_code_out(cod_cen), 
	.clk(clk)
);

reg [7:0] r_segmentos;
reg [3:0] r_sel_seg;

always @(*) begin
    case(sel)
        2'b00: begin // Unidades
            r_segmentos = cod_uni;
            r_sel_seg   = 4'b1110; // Activa primer display
        end
        2'b01: begin // Decenas
            r_segmentos = cod_dec;
            r_sel_seg   = 4'b1101; // Activa segundo display
        end
        2'b10: begin // Centenas
            r_segmentos = cod_cen;
            r_sel_seg   = 4'b1011; // Activa tercer display
        end
        default: begin
            r_segmentos = 8'hFF;   // Todo apagado
            r_sel_seg   = 4'b1111;
        end
    endcase
end

assign segmentos = r_segmentos;
assign sel_seg   = r_sel_seg;
//assign contador_reg = bit_count;


endmodule




