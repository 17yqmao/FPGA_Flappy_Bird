//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              is_pipe, is_bird, Reset, Clk,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input [9:0] Bird_Y_Pos_, Pipe_X_Pos_,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
	 logic [3:0] pipe_col, back_col, bird_col;
	 logic [10:0] bird_x, bird_y;
	 logic [18:0] back_x, back_y;
	 logic [15:0] pipe_x, pipe_y;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	
	 assign bird_x = DrawX - 10'd300;
	 assign bird_y = DrawY - Bird_Y_Pos_ + 10'd20;
	 assign pipe_x = DrawX - Pipe_X_Pos_ + 10'd40;
	 assign pipe_y = DrawY;
	 assign back_x = DrawX;
	 assign back_y = DrawY;
    
	 birdram birds_color_read(.read_address(bird_x+(bird_y*10'd40)),.Clk(Clk),.data_Out(bird_col));
	 piperam pipe_color_read(.read_address(pipe_x+(pipe_y*10'd80)),.Clk(Clk),.data_Out(pipe_col));
	 background background_color_read(.read_address(back_x+(back_y*10'd640)),.Clk(Clk),.data_Out(back_col));
    
	 // Assign color based on signals
always_comb
	begin
	 if(Reset)
		begin
			Red = 8'h80;
			Green = 8'h00;
			Blue = 8'h80;
		end

    if (is_bird == 1'b1 && is_pipe == 1'b0 ) 
		begin
			case(bird_col)
				4'b0000:
					begin
						case(back_col)
							4'b0000:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end
							4'b0001:
								begin
									Red = 8'hd7;
									Green = 8'hf5;
									Blue = 8'hd6;
								end
							4'b0010:
								begin
									Red = 8'hcf;
									Green = 8'hf2;
									Blue = 8'hd6;
								end
							4'b0011:
								begin
									Red = 8'ha0;
									Green = 8'hdf;
									Blue = 8'hd2;
								end
							4'b0100:
								begin
									Red = 8'hab;
									Green = 8'he4;
									Blue = 8'hd3;
								end
							4'b0101:
								begin
									Red = 8'h72;
									Green = 8'hce;
									Blue = 8'hcd;
								end
							4'b0110:
								begin
									Red = 8'h50;
									Green = 8'hc1;
									Blue = 8'hca;
								end
							4'b0111:
								begin
									Red = 8'h9b;
									Green = 8'hde;
									Blue = 8'hd1;
								end
							4'b1000:
								begin
									Red = 8'h5e;
									Green = 8'he2;
									Blue = 8'h70;
								end
							default:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end	
							endcase					
						end
				4'b0001:
						begin
							Red = 8'hf6;
							Green = 8'hac;
							Blue  = 8'h30;
						end
				4'b0010:
						begin
							Red = 8'hcf;
							Green = 8'hf2;
							Blue  = 8'hd6;
						end
				4'b0011:
						begin
							Red = 8'hf1;
							Green = 8'h59;
							Blue  = 8'h48;
						end
				4'b0100:
						begin
							Red = 8'h04;
							Green = 8'h04;
							Blue  = 8'h04;
						end
				4'b0101:
						begin
							Red = 8'hfb;
							Green = 8'hff;
							Blue  = 8'hfd;
						end
				4'b0110:
						begin
							Red = 8'h7b;
							Green = 8'h7c;
							Blue  = 8'h80;
						end
				
						
				default:
						begin
							case(back_col)
							4'b0000:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end
							4'b0001:
								begin
									Red = 8'hd7;
									Green = 8'hf5;
									Blue = 8'hd6;
								end
							4'b0010:
								begin
									Red = 8'hcf;
									Green = 8'hf2;
									Blue = 8'hd6;
								end
							4'b0011:
								begin
									Red = 8'ha0;
									Green = 8'hdf;
									Blue = 8'hd2;
								end
							4'b0100:
								begin
									Red = 8'hab;
									Green = 8'he4;
									Blue = 8'hd3;
								end
							4'b0101:
								begin
									Red = 8'h72;
									Green = 8'hce;
									Blue = 8'hcd;
								end
							4'b0110:
								begin
									Red = 8'h50;
									Green = 8'hc1;
									Blue = 8'hca;
								end
							4'b0111:
								begin
									Red = 8'h9b;
									Green = 8'hde;
									Blue = 8'hd1;
								end
							4'b1000:
								begin
									Red = 8'h5e;
									Green = 8'he2;
									Blue = 8'h70;
								end
							default:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end	
							endcase					
						end
					endcase
			  end
			  
			  else if(is_pipe && is_bird)
			  begin
					case(bird_col)
					4'b0000:
						begin
							case(pipe_col)
									4'b0000:
										begin
											Red = 8'h00;
											Green = 8'ha3;
											Blue = 8'h06;					
										end
									4'b0001:
										begin
											Red = 8'hd6;
											Green = 8'hff;
											Blue  = 8'h75;
										end
									4'b0010:
										begin
											Red = 8'h1a;
											Green = 8'h82;
											Blue  = 8'h00;
										end
									4'b0011:
										begin
											Red = 8'h42;
											Green = 8'hbf;
											Blue  = 8'h28;
										end
									4'b0100:
										begin
											Red = 8'h00;
											Green = 8'h51;
											Blue  = 8'h03;
										end
									4'b0101:
										begin
											Red = 8'h0e;
											Green = 8'h49;
											Blue  = 8'h00;
										end
									4'b0110:
										begin
											Red = 8'hb3;
											Green = 8'hf0;
											Blue  = 8'h5e;
										end
									default:
										begin
											Red = 8'hff;
											Green = 8'h00;
											Blue = 8'h00;					
										end
							endcase					
						end
					4'b0001:
						begin
							Red = 8'hf6;
							Green = 8'hac;
							Blue  = 8'h30;
						end
				4'b0010:
						begin
							Red = 8'hcf;
							Green = 8'hf2;
							Blue  = 8'hd6;
						end
				4'b0011:
						begin
							Red = 8'hf1;
							Green = 8'h59;
							Blue  = 8'h48;
						end
				4'b0100:
						begin
							Red = 8'h04;
							Green = 8'h04;
							Blue  = 8'h04;
						end
				4'b0101:
						begin
							Red = 8'hfb;
							Green = 8'hff;
							Blue  = 8'hfd;
						end
				4'b0110:
						begin
							Red = 8'h7b;
							Green = 8'h7c;
							Blue  = 8'h80;
						end
				default:
						begin
							Red = 8'h00;
							Green = 8'hff;
							Blue = 8'h00;					
						end
					endcase
			  end
			  
			  
			  else if(is_pipe)
			  begin
					case(pipe_col)
					4'b0000:
						begin
							Red = 8'h00;
							Green = 8'ha3;
							Blue = 8'h06;					
						end
					4'b0001:
						begin
							Red = 8'hd6;
							Green = 8'hff;
							Blue  = 8'h75;
						end
					4'b0010:
						begin
							Red = 8'h1a;
							Green = 8'h82;
							Blue  = 8'h00;
						end
					4'b0011:
						begin
							Red = 8'h42;
							Green = 8'hbf;
							Blue  = 8'h28;
						end
					4'b0100:
						begin
							Red = 8'h00;
							Green = 8'h51;
							Blue  = 8'h03;
						end
					4'b0101:
						begin
							Red = 8'h0e;
							Green = 8'h49;
							Blue  = 8'h00;
						end
					4'b0110:
						begin
							Red = 8'hb3;
							Green = 8'hf0;
							Blue  = 8'h5e;
						end
					default:
						begin
							Red = 8'hff;
							Green = 8'h00;
							Blue = 8'h00;					
						end
					endcase
			  end
			  
			  else
			  begin
					case(back_col)
							4'b0000:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end
							4'b0001:
								begin
									Red = 8'hd7;
									Green = 8'hf5;
									Blue = 8'hd6;
								end
							4'b0010:
								begin
									Red = 8'hcf;
									Green = 8'hf2;
									Blue = 8'hd6;
								end
							4'b0011:
								begin
									Red = 8'ha0;
									Green = 8'hdf;
									Blue = 8'hd2;
								end
							4'b0100:
								begin
									Red = 8'hab;
									Green = 8'he4;
									Blue = 8'hd3;
								end
							4'b0101:
								begin
									Red = 8'h72;
									Green = 8'hce;
									Blue = 8'hcd;
								end
							4'b0110:
								begin
									Red = 8'h50;
									Green = 8'hc1;
									Blue = 8'hca;
								end
							4'b0111:
								begin
									Red = 8'h9b;
									Green = 8'hde;
									Blue = 8'hd1;
								end
							4'b1000:
								begin
									Red = 8'h5e;
									Green = 8'he2;
									Blue = 8'h70;
								end
							default:
								begin
									Red = 8'h80;
									Green = 8'h00;
									Blue = 8'h80;
								end	
							endcase						
				end

    end 
			
    
    
endmodule
