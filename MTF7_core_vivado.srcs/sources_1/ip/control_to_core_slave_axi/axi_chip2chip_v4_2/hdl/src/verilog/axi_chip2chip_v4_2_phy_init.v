/******************************************************************************

File name:
Rev:
Description:

-- (c) Copyright 1995 - 2010 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
*******************************************************************************/
`timescale 1ns/1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module axi_chip2chip_v4_2_phy_init
#(
    parameter   C_AXI_MASTER_PHY      = 1,
    parameter   C_SYNC_STAGE          = 2,
    parameter   C_PHY_SELECT          = 0,
    parameter   C_AXI_PHY_CTRL_WIDTH  = 3,
    parameter   C_AXI_PHY_DATA_WIDTH  = 32,
    parameter   C_AXI_TDM_CTRL_WIDTH  = 4,
    parameter   C_AXI_TDM_DATA_WIDTH  = 25,
    parameter   C_COMMON_CLK          = 0
)
(
  input  wire                             axi_aclk,
  input  wire                             axi_reset_n,

  input  wire                             aurora_rst_in,
  output wire                             aurora_rst_out,

  input  wire                             phy_clk,
  input  wire                             phy_reset,
  input  wire [15:0]                      config_id,
  input  wire                             channel_up,
  input  wire                             rx_user_data_valid,
  input  wire [C_AXI_PHY_DATA_WIDTH-1:0]  rx_user_data,
  output reg  [C_AXI_PHY_CTRL_WIDTH-1:0]  tx_phy_ctrl,
  output reg                              tx_phy_ready,
  output reg                              rx_phy_ready,

  input  wire                             calib_done,
  input  wire                             calib_error,
  output reg                              calib_start,

  output wire                             calib_done_out,
  output wire                             calib_error_out,
  output wire                             phy_error_out,
  output wire                             link_error_out
);

localparam PAT_DONE  = 4'h 3;
localparam CW        = C_AXI_TDM_CTRL_WIDTH-3;
localparam DW        = C_AXI_TDM_DATA_WIDTH;

localparam SW           = 8;
localparam IDLE         = 8'h 1;
localparam WAIT_DLY     = 8'h 2;
// master calib
localparam WAIT_SLAVE   = 8'h 4;
localparam MASTER_CALIB = 8'h 8;
localparam MASTER_ACK   = 8'h 10;
localparam MASTER_READY = 8'h 20;
localparam MASTER_DONE  = 8'h 40;
localparam MASTER_ERROR = 8'h 80;
// slave calib
localparam SLAVE_CALIB  = 8'h 4;
localparam SLAVE_ACK    = 8'h 8;
localparam WAIT_MASTER  = 8'h 10;
localparam SLAVE_DONE   = 8'h 20;
localparam SLAVE_READY  = 8'h 40;
localparam SLAVE_ERROR  = 8'h 80;
// aurora init
localparam CALIB        = 7'h 2;
localparam PAT0         = 7'h 4;
localparam PAT1         = 7'h 8;
localparam RX_READY     = 7'h 10;
localparam PHY_ERROR    = 7'h 20;

// pat1, pat0, ch0, calib_en
localparam SEND_INIT  = 3'b 001;
localparam SEND_ACK   = 3'b 011;
localparam SEND_CALIB = 3'b 101;
localparam SEND_NACK  = 3'b 111;
localparam SEND_DATA  = 3'b 000;

localparam SEND_PAT0  = 3'b 001;
localparam SEND_PAT1  = 3'b 111;

//----------------------------------------------------------
// compte nibble rounded of data widths
//----------------------------------------------------------
localparam C_AXI_PHY_DATA_WIDTH_D4 = (C_AXI_PHY_DATA_WIDTH/4) + 1;
localparam C_AXI_PHY_DATA_WIDTH_R4 = C_AXI_PHY_DATA_WIDTH_D4*4;

//----------------------------------------------------------
// tx_phy_ctrl[0]   - select control slot s0
// tx_phy_ctrl[2:1] - data type for training
//----------------------------------------------------------
reg  [C_AXI_PHY_CTRL_WIDTH-1:0]  next_tx_phy_ctrl;
reg                              next_tx_phy_ready;
reg                              next_rx_phy_ready;
reg                              next_calib_start;
reg                              calib_done_flop;
reg                              calib_error_flop;
reg                              phy_error_flop;
reg                              next_calib_done_out;
reg                              next_calib_error_out;
reg                              next_phy_error_out;
reg  [SW-1:0]                    state;
reg  [SW-1:0]                    next_state;
reg  [3:0]                       pat_count;
reg  [3:0]                       next_pat_count;
wire                             pat0_match;
wire                             pat1_match;
reg                              pat0_valid;
reg                              pat0_valid_dly;
reg                              pat1_valid_dly;
reg                              pat1_valid;
wire                             pat_done;
wire                             wait_done;
reg [1:0]                        slot_id_flop;
reg                              ctrl_slot_det;
reg [12:0]                        wait_count;
reg [12:0]                        next_wait_count;

(*ASYNC_REG = "TRUE"*)(*DONT_TOUCH = "TRUE"*) reg aurora_rst_out_cdc_to;
(*ASYNC_REG = "TRUE"*)(*DONT_TOUCH = "TRUE"*) reg aurora_rst_out_r1;
(*ASYNC_REG = "TRUE"*)(*DONT_TOUCH = "TRUE"*) reg aurora_rst_out_r2;
//----------------------------------------------------------
// 48 bit of pattern is defined (max pins in IO)
// rest of bits are not supported
//----------------------------------------------------------
wire [47:0] pat0  = { { 28-CW { 1'b 0 } } , config_id, 1'b 0, 1'b 1, { CW { 1'b 1 } }, 2'b 0 };
wire [47:0] pat1  = { { 28-CW { 1'b 0 } } , config_id, 1'b 1, 1'b 1, { CW { 1'b 1 } }, 2'b 0 };

generate if ( ( C_AXI_PHY_DATA_WIDTH > 48 ) & ( C_PHY_SELECT == 1 ) )
begin: data_gt_48_gen
   assign pat0_match = ( rx_user_data[47:CW+2] == pat0[47:CW+2] ) & ( rx_user_data[1:0] == 2'b 0 );
   assign pat1_match = ( rx_user_data[47:CW+2] == pat1[47:CW+2] ) & ( rx_user_data[1:0] == 2'b 0 );
end
else if ( C_PHY_SELECT == 1 )
begin: data_lte_48_gen
   assign pat0_match = ( rx_user_data[C_AXI_PHY_DATA_WIDTH-1:CW+2] == pat0[C_AXI_PHY_DATA_WIDTH-1:CW+2] ) & ( rx_user_data[1:0] == 2'b 0 );
   assign pat1_match = ( rx_user_data[C_AXI_PHY_DATA_WIDTH-1:CW+2] == pat1[C_AXI_PHY_DATA_WIDTH-1:CW+2] ) & ( rx_user_data[1:0] == 2'b 0 );
end
else
begin
   assign pat0_match = 1'b 0;
   assign pat1_match = 1'b 0;
end
endgenerate

//----------------------------------------------------------
// async reset for control signals that go back to logic
// to avoid any initilization problems
//----------------------------------------------------------
always @ ( posedge phy_clk or posedge phy_reset )
begin
   if ( phy_reset )
   begin
      tx_phy_ctrl     <= ( C_PHY_SELECT == 0 ) ? SEND_INIT : SEND_PAT0;
      tx_phy_ready    <= 1'b 0;
      rx_phy_ready    <= 1'b 0;
      calib_done_flop <= 1'b 0;
   end
   else
   begin
      tx_phy_ctrl     <= next_tx_phy_ctrl;
      tx_phy_ready    <= next_tx_phy_ready;
      rx_phy_ready    <= next_rx_phy_ready;
      calib_done_flop <= next_calib_done_out;
   end
end

//----------------------------------------------------------
// control machine flops
//----------------------------------------------------------
generate if ( C_PHY_SELECT == 0 )
begin
   assign aurora_rst_out = 1'b0;

   always @ ( posedge phy_clk )
   begin
      if ( phy_reset )
      begin
         calib_error_flop <= 1'b 0;
         calib_start      <= 1'b 0;
         slot_id_flop     <= 2'b 0;
         ctrl_slot_det    <= 1'b 0;
         pat_count        <= 4'b 0;
         state            <= IDLE;

         phy_error_flop   <= 1'b 0;
         pat0_valid       <= 1'b 0;
         pat1_valid       <= 1'b 0;
         pat0_valid_dly   <= 1'b 0;
         pat1_valid_dly   <= 1'b 0;
      end
      else
      begin
         calib_error_flop <= next_calib_error_out;
         calib_start      <= next_calib_start;
         slot_id_flop     <= rx_user_data[1:0];
         ctrl_slot_det    <= ( slot_id_flop != 2'b 00 ) & ( rx_user_data == { C_AXI_PHY_DATA_WIDTH { 1'b 0 } } );
         pat_count        <= next_pat_count;
         state            <= next_state;

         phy_error_flop   <= 1'b 0;
         pat0_valid       <= 1'b 0;
         pat1_valid       <= 1'b 0;
         pat0_valid_dly   <= 1'b 0;
         pat1_valid_dly   <= 1'b 0;
      end
   end
end
else
begin
   assign aurora_rst_out = aurora_rst_out_r2;

   always @ ( posedge phy_clk )
   begin
      if ( phy_reset || aurora_rst_in )
      begin
         calib_error_flop <= 1'b 0;
         calib_start      <= 1'b 0;

         phy_error_flop   <= 1'b 0;
         pat0_valid       <= 1'b 0;
         pat1_valid       <= 1'b 0;
         pat0_valid_dly   <= 1'b 0;
         pat1_valid_dly   <= 1'b 0;
         pat_count        <= 4'b 0;
         wait_count       <= 13'b 0;
         slot_id_flop     <= 2'b 0;
         ctrl_slot_det    <= 1'b 0;
         state            <= IDLE;
      end
      else
      begin
         calib_error_flop <= 1'b 0;
         calib_start      <= 1'b 0;

         phy_error_flop   <= next_phy_error_out;
         pat0_valid       <= ( pat0_match & rx_user_data_valid );
         pat1_valid       <= ( pat1_match & rx_user_data_valid );
         pat0_valid_dly   <= pat0_valid;
         pat1_valid_dly   <= pat1_valid;
         pat_count        <= next_pat_count;
         wait_count       <= next_wait_count;
         slot_id_flop     <= rx_user_data[1:0];
         ctrl_slot_det    <= ( slot_id_flop != 2'b 00 ) & ( rx_user_data[1:0] == 2'b 00 );
         state            <= next_state;
      end
   end
end
endgenerate


generate if ( ( C_PHY_SELECT == 0 ) & ( C_AXI_MASTER_PHY == 1 ) )
begin: sio_mast_calib_fsm
   wire [C_AXI_PHY_DATA_WIDTH_R4-1:0] ack_data  = { C_AXI_PHY_DATA_WIDTH_D4 { 4'b 1111 } }; 
   wire [C_AXI_PHY_DATA_WIDTH_R4-1:0] nack_data = { C_AXI_PHY_DATA_WIDTH_D4 { 4'b 1100 } }; 
   reg  slave_ack;
   reg  slave_nack;
 
   always @ ( posedge phy_clk )
   begin
      slave_ack  <= ( rx_user_data ==  ack_data[C_AXI_PHY_DATA_WIDTH-1:0] );
      slave_nack <= ( rx_user_data == nack_data[C_AXI_PHY_DATA_WIDTH-1:0] );
   end

   
   always @ ( channel_up       or
              tx_phy_ctrl      or
              tx_phy_ready     or
              rx_phy_ready     or
              calib_start      or
              calib_done       or
              slave_ack        or
              slave_nack       or
              calib_done       or
              calib_error      or
              calib_error_flop or
              calib_done_flop  or
              ctrl_slot_det    or
              pat_count        or
              state          )
   begin
      next_tx_phy_ctrl     = tx_phy_ctrl;
      next_tx_phy_ready    = tx_phy_ready;
      next_rx_phy_ready    = rx_phy_ready;
      next_calib_start     = 1'b 0;
      next_calib_error_out = calib_error_flop;
      next_calib_done_out  = calib_done_flop;
      next_pat_count       = pat_count;
      next_state           = state;
   
      case ( state )
         IDLE:
         begin
            next_tx_phy_ctrl        = SEND_ACK;
            next_tx_phy_ready       = channel_up;
            next_rx_phy_ready       = 1'b 0;

            if ( channel_up )
            begin
               next_state           = WAIT_DLY;
            end
            else
            begin
               next_state           = IDLE;
            end
         end
         WAIT_DLY:
         begin
            next_tx_phy_ctrl        = SEND_ACK;
            next_pat_count          = pat_count + 1'b 1;

            if ( pat_count == 4'b 1111 )
               next_state           = WAIT_SLAVE;
            else
               next_state           = WAIT_DLY;
         end
         WAIT_SLAVE:
         begin
            next_tx_phy_ctrl        = SEND_CALIB;

            case ( { slave_ack, slave_nack } )
               2'b 10 : next_state  = MASTER_CALIB;
               2'b 01 : next_state  = MASTER_ERROR;
               default: next_state  = WAIT_SLAVE;
            endcase
         end
         MASTER_CALIB:
         begin
            next_tx_phy_ctrl        = SEND_NACK;
            next_calib_start        = ~slave_ack;

            case ( { calib_done, calib_error } )
               2'b 10 : next_state   = MASTER_ACK;
               2'b 01 : next_state   = MASTER_ERROR;
               default: next_state   = MASTER_CALIB;
            endcase
         end 
         MASTER_ACK:
         begin
            next_tx_phy_ctrl        = SEND_ACK;
            next_state              = MASTER_READY;
         end
         MASTER_READY:
         begin
            next_tx_phy_ctrl        = SEND_INIT;
            if ( slave_ack )
               next_state           = MASTER_DONE;
            else
               next_state           = MASTER_READY;
         end
         MASTER_ERROR:
         begin
            next_tx_phy_ctrl        = SEND_INIT;
            next_rx_phy_ready       = 1'b 0;
            next_calib_error_out    = 1'b 1;
            next_calib_done_out     = 1'b 0;
            next_state              = MASTER_ERROR;
         end
         MASTER_DONE:
         begin
            next_tx_phy_ctrl        = SEND_DATA;
            next_rx_phy_ready       = 1'b 1;
            next_calib_error_out    = 1'b 0;
            next_calib_done_out     = 1'b 1;
            next_state              = MASTER_DONE;
         end
      endcase
   end
end
else if ( ( C_PHY_SELECT == 0 ) & ( C_AXI_MASTER_PHY == 0 ) )
begin: sio_slav_calib_fsm

   wire [C_AXI_PHY_DATA_WIDTH_R4-1:0] ack_data  = { C_AXI_PHY_DATA_WIDTH_D4 { 4'b 1111 } }; 
   wire [C_AXI_PHY_DATA_WIDTH_R4-1:0] nack_data = { C_AXI_PHY_DATA_WIDTH_D4 { 4'b 1100 } }; 
   reg  master_ack;
   reg  master_nack;
   reg  master_init;

   always @ ( posedge phy_clk )
   begin
      master_ack  <= ( rx_user_data ==  ack_data[C_AXI_PHY_DATA_WIDTH-1:0] );
      master_nack <= ( rx_user_data == nack_data[C_AXI_PHY_DATA_WIDTH-1:0] );
      master_init <= ( rx_user_data == { C_AXI_PHY_DATA_WIDTH { 1'b 0 } }  );
   end

   always @ ( channel_up        or
              tx_phy_ctrl       or
              tx_phy_ready      or
              rx_phy_ready      or
              calib_start       or
              calib_done        or
              master_ack        or
              master_nack       or
              master_init       or
              calib_done        or
              calib_error       or
              calib_error_flop  or
              calib_done_flop   or
              ctrl_slot_det     or
              pat_count         or
              state             )
   begin
      next_tx_phy_ctrl     = tx_phy_ctrl;
      next_tx_phy_ready    = tx_phy_ready;
      next_rx_phy_ready    = rx_phy_ready;
      next_calib_start     = 1'b 0;
      next_calib_error_out = calib_error_flop;
      next_calib_done_out  = calib_done_flop;
      next_pat_count       = pat_count;
      next_state           = state;
   
      case ( state )
         IDLE:
         begin
            next_tx_phy_ctrl        = SEND_INIT;
            next_rx_phy_ready       = 1'b 0;

            if ( channel_up & master_ack ) // atlease one ack must be sampled
            begin
               next_state           = WAIT_DLY;
               next_tx_phy_ready    = 1'b 1;
            end
            else
            begin
               next_state           = IDLE;
               next_tx_phy_ready    = 1'b 0;
            end
         end
         WAIT_DLY:
         begin
            next_tx_phy_ctrl        = SEND_INIT;
            next_pat_count          = pat_count + 1'b 1;

            if ( pat_count == 4'b 1111 )
               next_state           = SLAVE_CALIB;
            else
               next_state           = WAIT_DLY;
         end
         SLAVE_CALIB:
         begin
            next_tx_phy_ctrl        = SEND_INIT;
            next_calib_start        = 1'b 1;

            case ( { calib_done, calib_error } )
               2'b 10 : next_state   = SLAVE_ACK;
               2'b 01 : next_state   = SLAVE_ERROR;
               default: next_state   = SLAVE_CALIB;
            endcase
         end 
         SLAVE_ACK:
         begin
            next_tx_phy_ctrl        = SEND_ACK;

            if ( master_nack )
            begin
               next_state           = WAIT_MASTER;
            end
            else
            begin
               next_state           = SLAVE_ACK;
            end
         end
         WAIT_MASTER:
         begin
            next_tx_phy_ctrl        = SEND_CALIB;

            case ( { master_ack, master_init  } )
               2'b 10 : next_state  = SLAVE_READY;
               2'b 01 : next_state  = SLAVE_ERROR;
               default: next_state  = WAIT_MASTER;
            endcase
         end
         SLAVE_ERROR:
         begin
            next_tx_phy_ctrl        = SEND_NACK;
            next_rx_phy_ready       = 1'b 0;
            next_calib_error_out    = 1'b 1;
            next_calib_done_out     = 1'b 0;
            next_state              = SLAVE_ERROR;
         end
         SLAVE_READY:
         begin
            next_tx_phy_ctrl        = SEND_ACK;
            next_state              = SLAVE_DONE;
         end
         SLAVE_DONE:
         begin
            next_tx_phy_ctrl        = SEND_DATA;
            next_rx_phy_ready       = 1'b 1;
            next_calib_error_out    = 1'b 0;
            next_calib_done_out     = 1'b 1;
            next_state              = SLAVE_DONE;
         end
      endcase
   end
end
else
begin: auro_phy_init
   //assign pat_done        = ( C_AXI_MASTER_PHY == 1 ) ? ( pat0_valid_dly & pat1_valid ) | ( pat1_valid_dly & ~pat1_valid ) :
                                                        //( pat_count == PAT_DONE );
   assign pat_done          = ( pat_count == PAT_DONE );
   assign wait_done         = ( wait_count[12] == 1'b 1 );
   always @ ( channel_up      or
              tx_phy_ctrl     or
              tx_phy_ready    or
              rx_phy_ready    or
              pat0_valid      or
              pat1_valid      or
              pat_count       or
              pat_done        or
              wait_count      or
              ctrl_slot_det   or
              phy_error_flop  or
              calib_done_flop or
	          wait_done       or
              state           )
   begin
      next_tx_phy_ctrl    = tx_phy_ctrl;
      next_tx_phy_ready   = tx_phy_ready;
      next_rx_phy_ready   = rx_phy_ready;
      next_pat_count      = pat_count;
      next_wait_count     = wait_count;
      next_phy_error_out  = phy_error_flop;
      next_calib_done_out = calib_done_flop;
      next_state          = state;
   
      case ( state )
         IDLE:
         begin
            next_tx_phy_ctrl        = SEND_PAT0;
            next_pat_count          = 4'b 0;
            next_wait_count         = 13'b 0;
            next_rx_phy_ready       = 1'b 0;
            next_phy_error_out      = 1'b 0;
            if ( channel_up )
            begin
               next_state           = PAT0;
               next_tx_phy_ready    = 1'b 1;
            end
            else
            begin
               next_state           = IDLE;
               next_tx_phy_ready    = 1'b 0;
            end
         end
         PAT0:
         begin
            case ( { pat_done, pat0_valid } )
               2'b 11 : next_pat_count = 4'b 0;
               2'b 10 : next_pat_count = 4'b 0;
               2'b 01 : next_pat_count = pat_count + 1'b 1;
               default: next_pat_count = 4'b 0;
            endcase
   
            next_tx_phy_ctrl        = SEND_PAT0;
            next_rx_phy_ready       = 1'b 0;
            if(C_AXI_MASTER_PHY == 0) begin
               next_wait_count         = 13'd0;
            end else begin
               next_wait_count         = wait_count + 1'b 1;
            end

            case ( { wait_done, pat_done } )
               2'b 01, 2'b 11:
               begin
                  next_wait_count   = 13'b 0;
                  next_state        = PAT1;
               end
               2'b 00:
               begin
                  next_state        = PAT0;
               end
               2'b 10:
               begin
                  next_state        = PHY_ERROR;
               end
            endcase
         end
         PAT1:
         begin
            case ( { pat_done, pat1_valid } )
               2'b 11 : next_pat_count = 4'b 0;
               2'b 10 : next_pat_count = 4'b 0;
               2'b 01 : next_pat_count = pat_count + 1'b 1;
               default: next_pat_count = 4'b 0;
            endcase
   
            next_tx_phy_ctrl        = SEND_PAT1;
            next_rx_phy_ready       = 1'b 0;
            if(C_AXI_MASTER_PHY == 0) begin
               next_wait_count         = 13'd0;
            end else begin
               next_wait_count         = wait_count + 1'b 1;
            end

            case ( { wait_done, pat_done } )
               2'b 01, 2'b 11:
               begin
                  next_wait_count   = 13'b 0;
                  next_state        = RX_READY;
               end
               2'b 00:
               begin
                  next_state        = PAT1;
               end
               2'b 10:
               begin
                  next_state        = PHY_ERROR;
               end
            endcase
         end
         RX_READY:
         begin
            next_tx_phy_ctrl        = SEND_DATA;
            next_rx_phy_ready       = 1'b 1;
   
            if ( channel_up )
            begin
               next_state           = RX_READY;
               next_calib_done_out     = 1'b 1;
            end
            else
            begin
               if(C_AXI_MASTER_PHY == 0) begin
                   next_state   = IDLE;
               end else begin
                   next_calib_done_out     = 1'b 0;
                   next_state   = IDLE;
               end
            end
         end
         PHY_ERROR:
         begin
            next_tx_phy_ctrl        = SEND_PAT1;
            next_rx_phy_ready       = 1'b 0;
            next_calib_done_out     = 1'b 0;
            next_phy_error_out      = 1'b 1;
            next_state              = PHY_ERROR;
         end
      endcase
   end

   always@(posedge phy_clk or negedge axi_reset_n)
   begin
       if(!axi_reset_n) begin
           aurora_rst_out_cdc_to <= 1'b1;
           aurora_rst_out_r1 <= 1'b1;
           aurora_rst_out_r2 <= 1'b1;
       end else begin
           aurora_rst_out_cdc_to <= 1'b0;
           aurora_rst_out_r1 <= aurora_rst_out_cdc_to;
           aurora_rst_out_r2 <= aurora_rst_out_r1;
       end
   end
end
endgenerate



//----------------------------------------------------------
// syncronize the status to axi_aclk - always
//----------------------------------------------------------
axi_chip2chip_v4_2_sync_cell
#(
    .SYNC_TYPE     ( 0 ),
    .C_SYNC_STAGE  ( C_SYNC_STAGE ),
    .C_DW          ( 3 )
) axi_chip2chip_sync_cell_inst
   (
  .src_clk   ( phy_clk ),
  .src_data  ( { calib_done_flop, calib_error_flop, phy_error_flop } ),
  .dest_clk  ( axi_aclk ),
  .dest_data ( { calib_done_out, calib_error_out, phy_error_out } )
);

//----------------------------------------------------------
// link_error detection - logic will be run on axi_aclk
// since phy_clk may not be running.
//----------------------------------------------------------
generate if ( C_AXI_MASTER_PHY == 1 )
begin: link_error_gen
   reg calib_done_dly;
   reg link_error_flop;

   always @ ( posedge axi_aclk or negedge axi_reset_n )
   begin
      if ( axi_reset_n == 1'b 0 )
      begin
        calib_done_dly  <= 1'b 0;
        link_error_flop <= 1'b 0;
      end
      else 
      begin
        calib_done_dly  <= calib_done_out;

        if ( ~calib_done_out & calib_done_dly )
           link_error_flop <= 1'b 1;
        else
           link_error_flop <= link_error_flop;
      end
   end

   assign link_error_out = link_error_flop;
end
else
begin
   assign link_error_out = 1'b 0;
end
endgenerate

endmodule
