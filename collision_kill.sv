module collision_kill( 
							input logic Clk, 
							input logic Reset,
							input logic [9:0] bird_y, pipe_x, pipe_y,
							output logic collision
							);
	
	
	always_ff @ (posedge Clk)
		begin
			if(Reset)
				begin
					collision <= 1'b0;
				end
			else if(pipe_x >= 10'd265 && pipe_x <= 10'd375)
				begin
					if(((bird_y + 10'd12) >= (pipe_y + 10'd40))||((bird_y - 10'd12) <= (pipe_y - 10'd40)))
						begin
							collision <= 1'b1;
						end
					else
						begin
							collision <= 1'b0;	
						end
				end
				
			else if (bird_y >= 10'd470 && bird_y <= 10'd480)
				begin
					collision <= 1'b1;
				end
				
			else if (bird_y >= 10'd0 && bird_y <= 10'd10)
				begin
					collision <= 1'b1;
				end
			else
				begin
					collision <= 1'b0;
				end
				
	end
	
endmodule