module spi_slave (
    input  logic start_i,
    input  logic mosi_i,
    input  logic sclk_i,
    output logic miso_o
);

    logic [7:0] read  = 'd0;
    logic [7:0] write = 'd0;

  initial begin
      
      forever begin
        wait (start_i != 1);
        wait (start_i == 1);
        write = read + 1;

        for (int i = 7; i >=0; i--) begin
            wait (sclk_i == 1);
            read[i] = mosi_i;
            wait (sclk_i == 0);
            //write = {write[6:0], 0};
            write = write << 1;
        end
      end
  end
  
  assign miso_o = write[7];

endmodule : spi_slave
