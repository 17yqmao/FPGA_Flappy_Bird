module statemachine(
						input logic Clk,
						input logic start,
						input logic Reset,
						input logic bird_killed,
						output logic [1:0] state_num,
						output logic killed_out
						);
		
	enum logic [1:0] {pause, alive, dead} state, next_state;
								
	always_ff @ (posedge Clk)
		begin
			if(Reset)
				state <= pause;
			else
				state <= next_state;
		end
		
	always_comb
		begin
			next_state = state; //never run
			unique case(state)
				pause:
					if(start == 1'b1)
						next_state = alive;
				   else
						next_state = pause;
				alive:
					if(bird_killed == 1'b1)
						next_state = dead;
					else
						next_state = alive;
				dead:
					if(start == 1'b1)
						begin
							next_state = pause;
						end
					else
						begin
							next_state = dead;
						end
				default : 
					next_state = pause;
			endcase
			
		 case(state)
			pause:
				begin
					killed_out = 1'b0;
					state_num = 0;
				end
			alive:
				begin
					killed_out = 1'b0;
					state_num = 1;
			   end
			dead:
				begin
					killed_out = 1'b1;
					state_num = 2;
				end
				
			default: 
				begin
					killed_out = 1'b0;
					state_num = 0;
				end
				
		endcase
		
	end
endmodule
						
		