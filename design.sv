module cb
  #(parameter WIDTH = 8)
  (clk, rst_n, s0_val, s0_dst, s0_data, s0_rdy, m0_val, m0_src, m0_data, m0_rdy, m1_data, m1_rdy, s1_val, s1_dst, s1_rdy, s1_data, i);

  input clk;
  input rst_n;
  input reg s0_val;
  input reg s1_val;
  input s0_dst;
  input s1_dst;
  input [WIDTH-1:0] s0_data;
  input [WIDTH-1:0] s1_data;
  input m0_rdy;
  input m1_rdy;

  output reg s0_rdy;
  output reg s1_rdy;
  output m0_val;
  output m0_src;
  output reg[WIDTH-1:0] m0_data;
  output reg[WIDTH-1:0] m1_data;
  output reg i;

  always @(posedge clk)
    begin
      if(s0_val==1'b1)
        begin
          case(s0_dst)
            1'b0:begin
              if(m0_rdy==1'b1)
                begin
                  s0_rdy<=1'b1;
                  m0_data<=s0_data;
                end

              else s0_rdy<=1'b0;
            end
            1'b1:begin
              if(m1_rdy==1'b1)
                begin
                s0_rdy<=1'b1;
                  m1_data<=s0_data;
                end
              else s0_rdy<=1'b0;
            end
          endcase
        end else s0_rdy<=1'b0;

     if(s1_val==1'b1)
       begin
         if(s0_dst==s1_dst)
           begin
            i <= ~s1_dst ;
             case(i)
                1'b0:begin
              if(m0_rdy==1'b1)
                begin
                  s1_rdy<=1'b1;
                  m0_data<=s1_data;
                end else s1_rdy<=1'b0;
            end
            1'b1:begin
                if(m1_rdy==1'b1)
                  begin
                    s1_rdy<=1'b1;
                    m1_data<=s1_data;
                  end else s1_rdy<=1'b0;
            end
           endcase
           end
         else begin case(s1_dst)
            1'b0:begin
              if(m0_rdy==1'b1)
                begin
                  s1_rdy<=1'b1;
                  m0_data<=s1_data;
                end else s1_rdy<=1'b0;
            end
            1'b1:begin
                if(m1_rdy==1'b1)
                  begin
                    s1_rdy<=1'b1;
                    m1_data<=s1_data;
                  end else s1_rdy<=1'b0;
            end
           endcase
          end
       end


      if(rst_n==1'b1)
        begin
          m0_data<=0;
          m1_data<=0;
        end
    end

endmodule
