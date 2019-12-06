
// modified from ball.sv from lab 8
module pipe(	
				input Clk,                // 50 MHz clock
            input Reset,              // Active-high reset signal
            input frame_clk,          // The clock indicating a new frame (~60Hz)
            input [9:0] DrawY, DrawX,  
			   input logic [1:0] state_num,
				input [1:0] input_speed,
            output logic is_Pipe,
				output logic [9:0] Pipe_Y_Pos_, Pipe_X_Pos_
				);
					
					
	 parameter [9:0] Pipe_X_Center = 10'd800;  // Center position on the X axis
    parameter [9:0] Pipe_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Pipe_X_Step = 10'd0;      // Step size on the X axis
    
	 logic [9:0] Pipe_X_Pos, Pipe_X_Motion, Pipe_Y_Pos, Pipe_Y_Motion; 
	 logic [9:0] Pipe_X_Pos_in, Pipe_X_Motion_in, Pipe_Y_Pos_in, Pipe_Y_Motion_in;
	 
    //////// Do not modify the always_ff blocks. ////////
	 
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
			begin
            Pipe_X_Pos <= 10'd800;
            Pipe_Y_Pos <= Pipe_Y_Center;
            Pipe_X_Motion <= 10'd0;
			end
		  if(state_num == 0)
			begin
				Pipe_X_Pos <= 10'd800;
            Pipe_Y_Pos <= Pipe_Y_Center;
            Pipe_X_Motion <= 10'd0;
			end
		  else if(state_num == 2)
			begin
				Pipe_X_Pos <= Pipe_X_Pos_in;
            Pipe_Y_Pos <= Pipe_Y_Pos_in;
            Pipe_X_Motion <= 10'd0;
			end
        else
			begin
            Pipe_X_Pos <= Pipe_X_Pos_in;
            Pipe_Y_Pos <= Pipe_Y_Pos_in;
            Pipe_X_Motion <= Pipe_X_Motion_in;
				Pipe_Y_Motion <= Pipe_Y_Motion_in;
			end
    end
	 
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
		begin
        Pipe_X_Pos_in = Pipe_X_Pos;
		  Pipe_Y_Pos_in = Pipe_Y_Pos;
		  Pipe_X_Motion_in = Pipe_X_Motion;
        Pipe_Y_Motion_in = Pipe_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
			begin
            
				if (Pipe_Y_Pos >= 10'd380)
					begin
						Pipe_Y_Pos_in = 10'd120;
					end
            else if( Pipe_X_Pos <= 10'd0 + input_speed ) 
						begin
						Pipe_X_Motion_in = 10'd800;
						Pipe_Y_Pos_in = Pipe_Y_Pos + 10'd45;
						end
            else
				begin
					Pipe_X_Motion_in = ~(10'd1 + input_speed + input_speed) + 1'b1;
					Pipe_Y_Motion_in = 10'd0;
					Pipe_Y_Pos_in = Pipe_Y_Pos;
				end
            Pipe_X_Pos_in = Pipe_X_Pos + Pipe_X_Motion;
			end
    end
    
    // Compute whether the pixel corresponds to PIPE or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
	 int temp_X, temp_Y;
    assign DistX = DrawX - Pipe_X_Pos;
	 
	 always_comb 
		begin
			if(DrawX >= Pipe_X_Pos)
				temp_X = DistX;
			else
				temp_X = ~DistX + 1'b1;
		end
	 
    assign DistY = DrawY - Pipe_Y_Pos;
	 
	 always_comb 
		begin
			if(DrawY >= Pipe_Y_Pos)
				temp_Y = DistY;
			else
				temp_Y = ~DistY + 1'b1;
		end
	 
    always_comb 
		begin
        if (temp_X <= 10'd40 && temp_Y >=10'd80)
            is_Pipe = 1'b1;
        else
            is_Pipe = 1'b0;
		end
		
    assign Pipe_Y_Pos_ = Pipe_Y_Pos;
	 assign Pipe_X_Pos_ = Pipe_X_Pos;
	 
endmodule