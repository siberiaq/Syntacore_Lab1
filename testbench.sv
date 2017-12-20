module test;
  parameter WIDTH = 8 ;
   reg clk;
  reg  rst_n;
  reg s0_val;
  reg s1_val;
   reg s0_dst;
  reg s1_dst;
   reg [WIDTH-1:0] s0_data;
  reg [WIDTH-1:0] s1_data;
  reg m0_rdy;
  reg m1_rdy;

   reg s0_rdy;
  reg s1_rdy;
   reg m0_val;
  reg m1_val;
   reg m0_src;
  reg m1_src;
   reg[WIDTH-1:0] m0_data;
  reg[WIDTH-1:0] m1_data;
  reg i;

  cb
  #(.WIDTH(WIDTH))
  CROSSBAR
  (.clk(clk), .rst_n(rst_n), .s0_val(s0_val), .s0_dst(s0_dst), .s0_data(s0_data), .s0_rdy(s0_rdy), .m0_val(m0_val), .m0_src(m0_src), .m0_data(m0_data),.m0_rdy(m0_rdy), .m1_data(m1_data), .m1_rdy(m1_rdy), .s1_val(s1_val), .s1_dst(s1_dst), .s1_rdy(s1_rdy), .s1_data(s1_data), .i(i));

  initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
end

  initial begin
    clk = 1'b1;
   forever #5 clk = ~clk;
  end

  initial
    begin
      s0_val = 1'b1;
      s1_val = 1'b1;
      s0_dst = 1'b0;
      s1_dst = 1'b1;
      m0_rdy = 1'b1;
      m1_rdy = 1'b1;
      s0_data = 8'b00101011;
      s1_data = 8'b00010010;
    end

  initial
    begin
      #50;
      s0_val = 1'b1;
      s1_val = 1'b1;
      s0_dst = 1'b1;
      s1_dst = 1'b1;
      m0_rdy = 1'b1;
      m1_rdy = 1'b1;
      s0_data = 34;
      s1_data = 21;
    end

  initial
    begin
      #70;
      rst_n = 1'b1;
    end


  initial
    begin
      #100
      $stop;
    end

endmodule
