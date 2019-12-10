module score_count(
						input logic [7:0] in, 
						input logic Clk,
						input logic Reset,
						input logic [9:0] pipex,
						input logic bird_killed,	
						output logic [7:0] score_out
						);
					
		
	logic [7:0] score_t;
		
	always_ff @ (posedge Clk)
		begin
			if(bird_killed)
				score_out <= 8'b00000000;
			else if(bird_killed == 1'b0 && pipex == 10'd200)
				score_out <= score_t;
			else if(bird_killed == 1'b0 && pipex <= 10'd0)
				score_out <= score_t;
			if(Reset)
				score_out <= 8'b00000000;
		end
		
	always_comb
		begin
			score_t = score_out + 8'b00000001;
		end	
		
endmodule
