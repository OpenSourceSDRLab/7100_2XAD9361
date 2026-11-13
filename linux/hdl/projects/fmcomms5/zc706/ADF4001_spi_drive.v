// ----------------------------------------------------------------------------
// Copyright (c) 2026 OpenSourceSDRLab - https://www.opensourcesdrlab.com
// SPDX-License-Identifier: Apache-2.0
//
// File        : ADF4001_spi_drive.v
// Project     : 7100_2XAD9361
// Description : 24-bit SPI write engine for the ADF4001 reference PLL.
// ----------------------------------------------------------------------------
module ADF4001_spi_drive(
// system clock and reset
    input 				clk,
    input				rst_n,
	
// status
    input 				wr_en,          // write enable, active high
    input 		[23:0]  wr_data,        // write data
    output 	reg 		wr_done,        // write done, active high
    output 	reg 		wr_start,       // write start strobe
	
// SPI interface
    output	reg 		spi_clk,
    output	reg		    spi_csn,
    output	 			spi_sdo
);

reg	   [4:0]   bit_cnt;	            // number of bits sent
reg	   [23:0]  command;
reg	   [2:0]   state;
//SPI state    
localparam     IDLE			= 0,            // idle
			   START		= 1,            // start: load the command register
			   TR			= 2,            // rising edge
			   TR_0			= 3,            // falling edge
			   DONE			= 4;

// SPI write
assign spi_sdo = command[23];
always @ (posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        state       <= IDLE;
        spi_csn     <= 0;           
        bit_cnt     <= 0;
        wr_done 	<= 0;
        spi_clk     <= 0;           // SPI idle state
    end
    else 
        case (state)
            IDLE   :   if (wr_en)                       
                            begin
                                state   <= START;
                                bit_cnt <= 5'd0;	
                                wr_done <= 1'b0;
                                spi_clk <= 0;
                                spi_csn <= 0;
                            end 

            START :     begin
                                state   <= TR;
                                wr_start<= 1'b1;
                                command <= wr_data;//{1'b0,wr_addr,wr_data};
                                spi_csn <= 1'b0;
                        end
            TR      :   if (bit_cnt <= 5'd23) 
                            begin
                                bit_cnt <= bit_cnt + 5'd1;
                                spi_clk <= 1;
                                state   <= TR_0;
                            end
                        else 
                            begin
                                spi_csn <= 1'b0;
                                bit_cnt <= 5'd0;
                                spi_clk <= 0;
                                state   <= DONE;
                            end
            
            TR_0    :   begin
                            spi_clk <= 0;
                            command <= command << 1;
                            state   <= TR;
                        end

            DONE    :   begin 
                            wr_done  <= 1'b1;
                            wr_start <= 1'b0;
                            spi_csn  <= 1'b1;
                            state <= IDLE;
                        end
            
            default :   state <= IDLE;
        endcase
end
       
endmodule