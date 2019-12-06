//-------------------------------------------------------------------------
//    Bird.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


// modified from lab8 ball.sv

module  bird ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
									  kill_in,
					input [1:0]   state_num,
				   input [7:0]   keycode, 
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               output logic  is_Bird,             // Whether current pixel belongs to bird or background
					output logic [9:0] Bird_Y_Pos_
              );
    
    parameter [9:0] Bird_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Bird_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Bird_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Bird_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Bird_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Bird_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Bird_X_Step = 10'd0;      // Step size on the X axis
    parameter [9:0] Bird_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Bird_Size = 10'd4;        // Bird size
    
    logic [9:0] Bird_X_Pos, Bird_X_Motion, Bird_Y_Pos, Bird_Y_Motion;
    logic [9:0] Bird_X_Pos_in, Bird_X_Motion_in, Bird_Y_Pos_in, Bird_Y_Motion_in;
    
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
            Bird_X_Pos <= Bird_X_Center;
            Bird_Y_Pos <= Bird_Y_Center;
            Bird_X_Motion <= 10'd0;
            Bird_Y_Motion <= 10'd0;
        end
        else if (state_num == 0)
        begin
            Bird_X_Pos <= Bird_X_Center;
            Bird_Y_Pos <= Bird_Y_Center;
            Bird_X_Motion <= 10'd0;
            Bird_Y_Motion <= 10'd0;
        end
		  else if (state_num == 2)
		  begin
				Bird_X_Pos <= Bird_X_Center;
            Bird_Y_Pos <= Bird_Y_Center;
            Bird_X_Motion <= 10'd0;
            Bird_Y_Motion <= Bird_Y_Motion_in;
		  end
		  else
		  begin
				Bird_X_Pos <= 10'd320;
            Bird_Y_Pos <= Bird_Y_Pos_in;
            Bird_X_Motion <= 10'd0;
            Bird_Y_Motion <= Bird_Y_Motion_in;
		  end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
	 
	always_comb
    begin
        // By default, keep motion and position unchanged
		  //Bird_X_Pos_in = Bird_X_Pos;
        Bird_Y_Pos_in = Bird_Y_Pos;
        //Bird_X_Motion_in = Bird_X_Motion;
        Bird_Y_Motion_in = Bird_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
			begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Bird_Y_Pos - Bird_Size <= Bird_Y_Min 
            // If Bird_Y_Pos is 0, then Bird_Y_Pos - Bird_Size will not be -4, but rather a large positive number.
//            if( Bird_Y_Pos + Bird_Size >= Bird_Y_Max )  // Bird is at the bottom edge, BOUNCE!
//					begin
//                Bird_Y_Motion_in = (~(Bird_Y_Step) + 1'b1);  // 2's complement. 
//					 Bird_X_Motion_in = 10'd0;
//					end
//					
//            else if ( Bird_Y_Pos <= Bird_Y_Min + Bird_Size )  // Bird is at the top edge, BOUNCE!
//					begin
//                Bird_Y_Motion_in = Bird_Y_Step;
//					 Bird_X_Motion_in = 10'd0;
//					end
			
            // TODO: Add other boundary detections and handle keypress here.
//				else if ( Bird_X_Pos + Bird_Size >= Bird_X_Max )
//					begin
//					 Bird_X_Motion_in = (~(Bird_X_Step) + 1'b1);
//					 Bird_Y_Motion_in = 10'd0;
//					end
//					
//				else if ( Bird_X_Pos <= Bird_X_Min + Bird_Size )
//					begin
//					 Bird_X_Motion_in = Bird_X_Step;
//					 Bird_Y_Motion_in = 10'd0;
//					end

				if ( keycode == 8'h1A )  
					begin
						//Bird_X_Motion_in = 10'd0;
						Bird_Y_Motion_in = (~(Bird_Y_Step + 10'd3) + 1'b1);
						
					end
				
				
				
					
//				else if ( Bird_Y_Pos + 10'd16 < Bird_Y_Max && Bird_Y_Pos > 10'd10 && kill_in == 1'b0)
//					begin
//						Bird_Y_Motion_in = 10'd1 + 1'b1;
//						//Bird_X_Motion_in = 10'd0;
//						flag = 1'b0;
//					end
//					
//				else if ( Bird_Y_Pos + 10'd16 < Bird_Y_Max && Bird_Y_Pos > 10'd10 && kill_in == 1'b1)
//					begin
//						Bird_Y_Motion_in = 10'd3 + 1'b1;
//						//Bird_X_Motion_in = 10'd0;
//						flag = 1'b0;
//					end	
	
				else 
					begin
						
						//Bird_X_Motion_in = 10'd0;
						Bird_Y_Motion_in = 10'd3 + 1'b1;
					end
//				else
//					begin
//						flag = 1'b0;
//						//Bird_X_Motion_in = 10'd0;
//						Bird_Y_Motion_in = 10'd3 + 1'b1;
//					end
			
// 			   else
//					begin 		
//						case(keycode)
//							8'h1A: 
//								begin
//								Bird_X_Motion_in = 10'd0;
//								Bird_Y_Motion_in = (~(Bird_Y_Step + 10'd3) + 1'b1);
//								
//								end
//							8'h16:
//								begin
//								Bird_X_Motion_in = 10'd0;
//								Bird_Y_Motion_in = Bird_Y_Step;
//								end
//							8'h04:
//								begin
//								Bird_Y_Motion_in = 10'd0;
//								Bird_X_Motion_in = (~(Bird_X_Step) + 1'b1);
//								end
//							8'h07:
//								begin
//								Bird_Y_Motion_in = 10'd0;
//								Bird_X_Motion_in = Bird_X_Step;
//								end
//						endcase
//					end
				
            // Update the Bird's position with its motion
				
            //Bird_X_Pos_in = Bird_X_Pos + Bird_X_Motion;
            Bird_Y_Pos_in = Bird_Y_Pos + Bird_Y_Motion;
        end
		  
	end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Bird_Y_Pos is updated using Bird_Y_Motion. 
              Will the new value of Bird_Y_Motion be used when Bird_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Bird_Y_Pos_in = Bird_Y_Pos + Bird_Y_Motion;" and 
                "Bird_Y_Posin = Bird_Y_Pos + Bird_Y_Motion_in;"?
              How will this impact behavior of the Bird during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/

    
    // Compute whether the pixel corresponds to Bird or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
	 int temp_X, temp_Y;
    assign DistX = DrawX - Bird_X_Pos;
	 always_comb 
		begin
			if(DrawX >= Bird_X_Pos)
				temp_X = DistX;
			else
				temp_X = ~DistX + 1'b1;
		end
	 
    assign DistY = DrawY - Bird_Y_Pos;
	 always_comb 
		begin
			if(DrawY >= Bird_Y_Pos)
				temp_Y = DistY;
			else
				temp_Y = ~DistY + 1'b1;
		end
	 
    assign Size = 10'd20;
	 
    always_comb  
		begin
        if (temp_X <= 10'd20 && temp_Y <= 10'd20)
            is_Bird = 1'b1;
        else
            is_Bird = 1'b0;
		end
        /* The Bird's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
		assign Bird_Y_Pos_ = Bird_Y_Pos;
    
endmodule
