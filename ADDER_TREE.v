 ///////////////////////////////////////////////////////////
 //  加法器树构成8-bit无符号乘法器
 //  data in should be positive and range from 0 to 127
 //  about 8 clk delay to get result data out 
 //  actually data_in1 could range from -128 to 127
 ///////////////////////////////////////////////////////////
 module ADDER_TREE#(parameter DATA_IN_WIDTH = 8,DATA_OUT_WIDTH = 16)
							(clk,rst_n,ena,data_in1,data_in2,data_out,done,	pipe
							);
						
 input clk,rst_n,ena;
 input [DATA_IN_WIDTH - 1:0] data_in1,data_in2;
 output [DATA_OUT_WIDTH:0] data_out;
 output done;
 reg signed done;
 reg signed [DATA_OUT_WIDTH:0] data_out;
output [6:0] pipe;

reg signed [6:0] pipe;
wire data_in2_b0,data_in2_b1,data_in2_b2,data_in2_b3,data_in2_b4,data_in2_b5,data_in2_b6,data_in2_b7;
wire [DATA_IN_WIDTH - 1:0] M_wire0,M_wire1,M_wire2,M_wire3,M_wire4,M_wire5,M_wire6,M_wire7;

reg signed  [DATA_IN_WIDTH - 1:0] M_reg0,M_reg1,M_reg2,M_reg3,M_reg4,M_reg5,M_reg6,M_reg7;
reg signed  [DATA_IN_WIDTH:0] M_reg_ls1_0,M_reg_ls1_1,M_reg_ls1_2,M_reg_ls1_3,M_reg_ls1_4,M_reg_ls1_5,M_reg_ls1_6,M_reg_ls1_7;
reg signed  [DATA_IN_WIDTH + 1:0] Adder_reg1_0,Adder_reg1_1,Adder_reg1_2,Adder_reg1_3;
reg signed  [DATA_IN_WIDTH + 3:0] Adder_reg1_ls2_0,Adder_reg1_ls2_1,Adder_reg1_ls2_2,Adder_reg1_ls2_3,Adder_reg2_0,Adder_reg2_1;
reg signed  [DATA_IN_WIDTH + DATA_IN_WIDTH - 1:0] Adder_reg2_ls4_0,Adder_reg2_ls4_1;
reg signed  [DATA_IN_WIDTH + DATA_IN_WIDTH - 1:0] Adder_reg3_1;

assign data_in2_b0 = data_in2[0];
assign data_in2_b1 = data_in2[1];
assign data_in2_b2 = data_in2[2];
assign data_in2_b3 = data_in2[3];
assign data_in2_b4 = data_in2[4];
assign data_in2_b5 = data_in2[5];
assign data_in2_b6 = data_in2[6];
assign data_in2_b7 = data_in2[7];

assign M_wire0 = data_in2_b0 ? data_in1 : 0;
assign M_wire1 = data_in2_b1 ? data_in1 : 0;
assign M_wire2 = data_in2_b2 ? data_in1 : 0;
assign M_wire3 = data_in2_b3 ? data_in1 : 0;
assign M_wire4 = data_in2_b4 ? data_in1 : 0;
assign M_wire5 = data_in2_b5 ? data_in1 : 0;
assign M_wire6 = data_in2_b6 ? data_in1 : 0;
assign M_wire7 = data_in2_b7 ? data_in1 : 0;

always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   M_reg0 <= 0;
			M_reg1 <= 0;
			M_reg2 <= 0;
			M_reg3 <= 0;
			M_reg4 <= 0;
			M_reg5 <= 0;
			M_reg6 <= 0;
			M_reg7 <= 0;
			pipe[0] <= 0;
		end
	 else
	   begin
		  if(ena)
		    begin
			   M_reg0 <= M_wire0;
				M_reg1 <= M_wire1;
				M_reg2 <= M_wire2;
				M_reg3 <= M_wire3;
				M_reg4 <= M_wire4;
				M_reg5 <= M_wire5;
				M_reg6 <= M_wire6;
				M_reg7 <= M_wire7;
				pipe[0] <= 1;
			 end
		end
  end
  
always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   M_reg_ls1_0 <= 0;
			M_reg_ls1_1 <= 0;
			M_reg_ls1_2 <= 0;
			M_reg_ls1_3 <= 0;
			M_reg_ls1_4 <= 0;
			M_reg_ls1_5 <= 0;
			M_reg_ls1_6 <= 0;
			M_reg_ls1_7 <= 0;
			pipe[1] <= 0;
		end
	 else
	   begin
		  if(pipe[0])
		    begin
			   M_reg_ls1_0 <= M_reg0;
				M_reg_ls1_1 <= {M_reg1[7:0],1'b0};
				M_reg_ls1_2 <= M_reg2;
				M_reg_ls1_3 <= {M_reg3[7:0],1'b0};
				M_reg_ls1_4 <= M_reg4;
				M_reg_ls1_5 <= {M_reg5[7:0],1'b0};
				M_reg_ls1_6 <= M_reg6;
				M_reg_ls1_7 <= {M_reg7[7:0],1'b0};
				pipe[1] <= 1;
			 end
		end
  end
  
always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   Adder_reg1_0 <= 0;
			Adder_reg1_1 <= 0;
			Adder_reg1_2 <= 0;
			Adder_reg1_3 <= 0;
			pipe[2] <= 0;
		end
	 else
	   begin
		  if(pipe[1])
		    begin
			   Adder_reg1_0 <= M_reg_ls1_0 + M_reg_ls1_1;
				Adder_reg1_1 <= M_reg_ls1_2 + M_reg_ls1_3;
				Adder_reg1_2 <= M_reg_ls1_4 + M_reg_ls1_5;
				Adder_reg1_3 <= M_reg_ls1_6 + M_reg_ls1_7;
				pipe[2] <= 1;
			 end
		end
  end
  
always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   Adder_reg1_ls2_0 <= 0;
			Adder_reg1_ls2_1 <= 0;
			Adder_reg1_ls2_2 <= 0;
			Adder_reg1_ls2_3 <= 0;
			pipe[3] <= 0;
		end
	 else
	   begin
		  if(pipe[2])
		    begin
			   Adder_reg1_ls2_0 <= Adder_reg1_0;
				Adder_reg1_ls2_1 <= {Adder_reg1_1[9:0],2'b0};
				Adder_reg1_ls2_2 <= Adder_reg1_2;
				Adder_reg1_ls2_3 <= {Adder_reg1_3[9:0],2'b0};
				pipe[3] <= 1;
			 end
		end
  end
  
 always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   Adder_reg2_0 <= 0;
			Adder_reg2_1 <= 0;
			pipe[4] <= 0;
		end
	 else
	   begin
		  if(pipe[3])
		    begin
			   Adder_reg2_0 <= Adder_reg1_ls2_0 + Adder_reg1_ls2_1;
				Adder_reg2_1 <= Adder_reg1_ls2_2 + Adder_reg1_ls2_3;
				pipe[4] <= 1;
			 end
		end
  end
  
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   Adder_reg2_ls4_0 <= 0;
		   Adder_reg2_ls4_1 <= 0;
			pipe[5] <= 0;
		end
	 else
	   begin
		  if(pipe[4])
		    begin
				Adder_reg2_ls4_0 <= Adder_reg2_0;
				Adder_reg2_ls4_1 <= {Adder_reg2_1[11:0],4'b0};
				pipe[5] <= 1;
			 end
		end
  end

 always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		   Adder_reg3_1 <= 0;
			pipe[6] <= 0;
		end
	 else
	   begin
		  if(pipe[5])
		    begin
			   Adder_reg3_1 <= Adder_reg2_ls4_0 + Adder_reg2_ls4_1;
				pipe[6] <= 1;
			 end
		end
  end
always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		  data_out <= 0;
		  done <= 0; 
		end
	 else
	   begin
		  if(pipe[6])
		    begin
			  data_out <= Adder_reg3_1;
			  done <= 1'b1;
			 end
		end
  end
 endmodule 