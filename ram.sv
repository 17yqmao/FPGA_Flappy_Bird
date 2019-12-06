/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  birdram
(
        input [10:0] read_address,
        input Clk,
        output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] membird [0:1599];

initial
begin
     $readmemh("sprite_bytes/bird.txt", membird);
end


always_ff @ (posedge Clk) begin
    data_Out<= membird[read_address];
end

endmodule

module  background
(
        input [18:0] read_address,
        input Clk,
        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] membgd [0:307199];

initial
begin
     $readmemh("sprite_bytes/background.txt", membgd);
end


always_ff @ (posedge Clk) begin
    data_Out<= membgd[read_address];
end

endmodule

module  startpic
(
        input [12:0] read_address,
        input Clk,
        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memstart [0:5599];

initial
begin
     $readmemh("sprite_bytes/start.txt", memstart);
end


always_ff @ (posedge Clk) begin
    data_Out<= memstart[read_address];
end

endmodule

module  endpic
(
        input [13:0] read_address,
        input Clk,
        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memend [0:9199];

initial
begin
     $readmemh("sprite_bytes/end.txt", memend);
end


always_ff @ (posedge Clk) begin
    data_Out<= memend[read_address];
end

endmodule


module  piperam
(
		input [15:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);


logic [3:0] mempipe [0:38399];

initial
begin
	 $readmemh("sprite_bytes/pipe.txt", mempipe);
end


always_ff @ (posedge Clk) begin
	data_Out<= mempipe[read_address];
end

endmodule

