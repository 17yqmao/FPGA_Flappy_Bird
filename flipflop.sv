module flipflop(
					input  logic Clk, Reset, Load,
               input  logic D_in,
               output logic D_Out
					);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) 
			  D_Out <= 1'b0; 
		 else if (Load)
			  D_Out <= D_in;
    end
endmodule