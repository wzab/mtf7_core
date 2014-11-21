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
module axi_chip2chip_v4_2_phy_calib
#(
   parameter DDR_MODE   = 1,
   parameter DW         = 18,
   parameter DIS_DESKEW = 0,
   parameter GRPS       = 4,
   parameter GRPW       = 4,
   parameter LOGGRPW    = 2,
   parameter LASTGRPW   = 6,

   parameter DN0        = 4'h 5,
   parameter DN1        = 4'h 6,
   parameter DN2        = 4'h 9,
   parameter DN3        = 4'h 7
)
(
   input  wire            clk,
   input  wire            reset,

   input  wire [DW-1:0]   data_in,
   input  wire [DW-1:0]   data_neg_in,
   output reg  [DW-1:0]   data_out,

   input  wire            calib_start,
   output reg             calib_done,
   output reg             calib_error,
   output reg  [DW-1:0]   delay_load,
   output reg  [4:0]      delay_tap
);


//-----------------------------------------------------
// output d pins and global vars
//-----------------------------------------------------
reg             next_calib_done;
reg             next_calib_error;

reg  [DW-1:0]   data_dly;
reg  [3:0]      p0_val;
reg  [3:0]      p1_val;
reg  [3:0]      p2_val;
(* keep="true" *) reg  [3:0]      p3_val;
reg  [3:0]      f0_val;
reg  [3:0]      f1_val;
reg  [3:0]      f2_val;
(* keep="true" *) reg  [3:0]      f3_val;
reg  [2:0]      count;
reg  [2:0]      pat_count;
reg             flip_type;

reg  [2:0]      next_count;
reg  [2:0]      next_pat_count;
reg             next_flip_type;

reg             pat_valid;
reg             count_2;
reg             count_7;
reg             pat_count_7;
wire [DW-1:0]   unalign_data;
//-----------------------------------------------------
// define calib patterns
//-----------------------------------------------------
localparam DW_M4      = (DW/4) + 1;
localparam DW_R4      = DW_M4*4;
wire [DW_R4-1:0] pat0 = { DW_M4 { DN0 } }; // 'h 555555
wire [DW_R4-1:0] pat1 = { DW_M4 { DN1 } }; // 'h 666666
wire [DW_R4-1:0] pat2 = { DW_M4 { DN2 } }; // 'h 999999
wire [DW_R4-1:0] pat3 = { DW_M4 { DN3 } }; // 'h 777777


//-----------------------------------------------------
// generate unaligned data
// in sdr mode it is negedge data from input module
// in ddr it is half cycle shift
//-----------------------------------------------------
genvar loop;
generate if ( DDR_MODE == 1 )
begin : ddr_data_gen
   always @ ( posedge clk )
   begin : ddr_data_in_dly_gen
      data_dly <= data_in;
   end
   //-----------------------------------------------------
   // DDR data mapping
   // posedge data moves to negedge and vice versa.
   // data mapping is even bits of data are sent on posedge
   // and odd bits are sent in negedge. to create unalign,
   // map delayed data odd bits to even and current data even bits as odd
   // data outputs
   //-----------------------------------------------------
   for ( loop = 0; loop < DW; loop = loop + 2 )
   begin : ddr_udata_blk
      assign unalign_data[loop]   = data_dly[loop+1]; // negedge bits become posedge
      assign unalign_data[loop+1] = data_in[loop];    // posedge bits become negedge
   end
end
else
begin : sdr_data_gen
   assign unalign_data =  data_neg_in;
end
endgenerate

//-----------------------------------------------------
// normal pattern
//-----------------------------------------------------
// p0 p0d1 p0d2 p0d3  // 55
//    p1   p1d1 p1d2  // 66
//         p2   p2d1  // 99
//              p3    // 77
//-----------------------------------------------------
wire  data_det = ( p3_val[0] & p2_val[1] & p1_val[2] & p0_val[3] );
//-----------------------------------------------------
// flip pattern
//-----------------------------------------------------
wire  flip_det = ( f3_val[0] & f2_val[1] & f1_val[2] & f0_val[3] );

//-----------------------------------------------------
// de-skew logic disable mode - only pattern match
//-----------------------------------------------------
generate if ( DIS_DESKEW == 1 )
begin: deskew_disable_gen
   localparam SW         = 6;
   localparam ONE_HOT    = 6'b 1;
   localparam IDLE       = ONE_HOT << 0;
   localparam DET_START  = ONE_HOT << 1;
   localparam DATA_WAIT  = ONE_HOT << 2;
   localparam DATA_CHECK = ONE_HOT << 3;
   localparam ERROR      = ONE_HOT << 4;
   localparam DONE       = ONE_HOT << 5;

   reg  [SW-1:0]    state;
   reg  [SW-1:0]    next_state;
   //-----------------------------------------------------
   // pattern comparision flops (no reset)
   //-----------------------------------------------------
   always @ ( posedge clk )
   begin
      p0_val       <= { p0_val[2:0], ( data_in == pat0[DW-1:0] ) };
      p1_val       <= { p1_val[2:0], ( data_in == pat1[DW-1:0] ) };
      p2_val       <= { p2_val[2:0], ( data_in == pat2[DW-1:0] ) };
      p3_val       <= { p3_val[2:0], ( data_in == pat3[DW-1:0] ) };

      f0_val       <= { f0_val[2:0], ( unalign_data == pat0[DW-1:0] ) };
      f1_val       <= { f1_val[2:0], ( unalign_data == pat1[DW-1:0] ) };
      f2_val       <= { f2_val[2:0], ( unalign_data == pat2[DW-1:0] ) };
      f3_val       <= { f3_val[2:0], ( unalign_data == pat3[DW-1:0] ) };

      data_out     <= ( flip_type ) ? unalign_data : data_in;
   end
   //-----------------------------------------------------
   // seq blocks
   //-----------------------------------------------------
   always @ ( posedge clk )
   begin
      if ( reset )
      begin
         calib_done       <= 1'b 0;
         calib_error      <= 1'b 0;
         delay_load       <= { DW { 1'b 0 } };
         delay_tap        <= 5'b 0;

         count            <= 3'b 0;
         pat_count        <= 3'b 0;
         flip_type        <= 1'b 0;
         state            <= IDLE;
      end
      else
      begin
         calib_done       <= next_calib_done;
         calib_error      <= next_calib_error;

         count            <= next_count;
         pat_count        <= next_pat_count;
         flip_type        <= next_flip_type;
         state            <= next_state;
      end
   end
   //-----------------------------------------------------
   // fsm
   //-----------------------------------------------------
   always @ ( calib_start     or
              calib_done      or
              calib_error     or
              count           or
              pat_count       or
              flip_type       or
              data_det        or
              flip_det        or
              state           )
   begin
      next_calib_done       = calib_done;
      next_calib_error      = calib_error;
      next_count            = count;
      next_pat_count        = pat_count;
      next_flip_type        = flip_type;
      next_state            = state;
      pat_valid             = ( data_det & ~flip_type ) | ( flip_det & flip_type );
      count_7               = ( count     == 3'b 111 );
      count_2               = ( count     == 3'b 010 );
      pat_count_7           = ( pat_count == 3'b 111 );

      case ( state )
         //-------------------------------------------------------
         // POR state
         //-------------------------------------------------------
         IDLE:
         begin
            next_count             = 3'b 0;
            next_pat_count         = 3'b 0;
            if ( calib_start )
               next_state          = DET_START;
            else
               next_state          = IDLE;
         end
         //-------------------------------------------------------
         // wait 8 cycles, then check for Pat0 match in next 8
         // if pat0 not found, move to next step with fail
         // else move to checking next pattern
         //-------------------------------------------------------
         DET_START: // wait for 8 more cycles to check if atleast one data is read
         begin
            next_pat_count         = 3'b 0;
            next_flip_type         = flip_det;

            case ( { ( data_det | flip_det ), count_7 } )
               2'b 10, 2'b 11:
               begin
                  next_count       = 3'b 0;
                  next_state       = DATA_WAIT;
               end
               2'b 01:
               begin
                  next_count       = 3'b 0;
                  next_state       = ERROR;
               end
               2'b 00:
               begin
                  next_count       = count + 1'b 1;
                  next_state       = DET_START;
               end
            endcase
         end
         //-------------------------------------------------------
         // wait 3 cycles here - shf reg will get 4 patterns
         //-------------------------------------------------------
         DATA_WAIT:
         begin
            next_count             = count + 1'b 1;

            if ( count_2 )
               next_state          = DATA_CHECK;
            else
               next_state          = DATA_WAIT;
         end
         //-------------------------------------------------------
         // comes to this state when data pattern must be valid
         //-------------------------------------------------------
         DATA_CHECK:
         begin
            next_count             = 3'b 0;

            if ( pat_valid )
               next_pat_count      = pat_count + 1'b 1;
            else
               next_pat_count      = 3'b 0;

            case ( { pat_valid, pat_count_7 } )
               2'b 11 : next_state = DONE;
               2'b 10 : next_state = DATA_WAIT;
               default: next_state = ERROR;
            endcase
         end
         //-------------------------------------------------------
         // calib success - no exit, on reset goes to IDLE
         //-------------------------------------------------------
         DONE:
         begin
            next_state             = DONE;
            next_calib_error       = 1'b 0;
            next_calib_done        = 1'b 1;
         end
         //-------------------------------------------------------
         // calib error - no exit, on reset goes to IDLE
         //-------------------------------------------------------
         ERROR:
         begin
            next_state             = ERROR;
            next_calib_error       = 1'b 1;
            next_calib_done        = 1'b 0;
         end
      endcase
   end

   // synthesis translate_off
   reg [255:0] state_str;
   always @ ( state )
   begin
      case ( state )
         IDLE       : state_str = "IDLE";
         DET_START  : state_str = "DET_START";
         DATA_WAIT  : state_str = "DATA_WAIT";
         DATA_CHECK : state_str = "DATA_CHECK";
         ERROR      : state_str = "ERROR";
         DONE       : state_str = "DONE";
      endcase
   end
   // synthesis translate_on
end
else
begin: deskew_enable_gen
   //-----------------------------------------------------
   // fsm states
   //-----------------------------------------------------
   localparam SW         = 12;
   localparam ONE_HOT    = 12'b 1;
   localparam IDLE       = ONE_HOT << 0;
   localparam WAIT       = ONE_HOT << 1;
   localparam DET_START  = ONE_HOT << 2;
   localparam DATA_WAIT  = ONE_HOT << 3;
   localparam DATA_CHECK = ONE_HOT << 4;
   localparam PASS_STEP  = ONE_HOT << 5;
   localparam FAIL_STEP  = ONE_HOT << 6;
   localparam NEXT_STEP  = ONE_HOT << 7;
   localparam COMP_MID   = ONE_HOT << 8;
   localparam NEXT_GRP   = ONE_HOT << 9;
   localparam WAIT_P0    = ONE_HOT << 10;
   localparam DONE       = ONE_HOT << 11;

   //-----------------------------------------------------
   // d pins of outputs
   //-----------------------------------------------------
   reg              next_delay_load;
   reg  [4:0]       next_delay_tap;
   //-----------------------------------------------------
   // internal variables and flops
   //-----------------------------------------------------
   reg  [SW-1:0]    state;
   reg  [2:0]       step_count;
   reg  [4:0]       min_value_0;
   reg  [4:0]       min_value_1;
   reg  [4:0]       max_value_0;
   reg  [4:0]       max_value_1;
   reg              min_flip_0;
   reg              min_flip_1;
   reg  [4:0]       grp_count;
   reg              grp_flip;
   reg  [DW-1:0]    data_flip_sel;
   reg  [DW-1:0]    data_stage_sel0;
   reg  [DW-1:0]    data_stage_sel1;
   reg  [SW-1:0]    next_state;
   reg  [2:0]       next_step_count;
   reg  [4:0]       next_min_value_0;
   reg  [4:0]       next_min_value_1;
   reg  [4:0]       next_max_value_0;
   reg  [4:0]       next_max_value_1;
   reg              next_min_flip_0;
   reg              next_min_flip_1;
   reg  [4:0]       next_grp_count;
   reg              next_grp_flip;
   reg  [DW-1:0]    next_data_stage_sel0;
   reg  [DW-1:0]    next_data_stage_sel1;

   reg  [4:0]       range_0;
   reg  [4:0]       range_1;
   reg  [5:0]       sum_0;
   reg  [5:0]       sum_1;
   reg  [4:0]       mid_0;
   reg  [4:0]       mid_1;
   reg  [4:0]       sel_mid;
   reg              sel_flip;

   wire [DW-1:0]    data_stage0;
   reg  [DW-1:0]    data_stage1;
   reg  [DW-1:0]    data_stage2;
   reg              dout_p0_val;
   reg              grp_p0_val;
   reg              grp_p1_val;
   reg              grp_p3_val;
   //-----------------------------------------------------
   // define groups, based on group count
   //-----------------------------------------------------
   wire             last_grp        = ( grp_count == ( GRPS - 1 ) );
   wire [31:0]      grp_count_mul   = ( grp_count << LOGGRPW );
   wire             grp_count_done  = ( grp_count == GRPS );
   wire [DW-1:0]    grp_mask_lsb    = { GRPW     { 1'b 1 } } << grp_count_mul;
   wire [DW-1:0]    last_grp_mask   = { LASTGRPW { 1'b 1 } } << grp_count_mul;
   wire [DW-1:0]    not_grp_mask    = ~( { DW { 1'b 1 } }    << grp_count_mul );
   wire [DW-1:0]    grp_mask        = last_grp ? last_grp_mask :  grp_mask_lsb;

   wire [DW-1:0]    masked_data     = data_in      & grp_mask;
   wire [DW-1:0]    masked_udata    = unalign_data & grp_mask;
   wire [DW-1:0]    masked_pat0     = pat0[DW-1:0] & grp_mask;
   wire [DW-1:0]    masked_pat1     = pat1[DW-1:0] & grp_mask;
   wire [DW-1:0]    masked_pat2     = pat2[DW-1:0] & grp_mask;
   wire [DW-1:0]    masked_pat3     = pat3[DW-1:0] & grp_mask;
   wire [DW-1:0]    selected_data   = (  data_stage_sel1 & ~data_stage_sel0 & data_stage0 ) |  // 10 - stage 0
                                      ( ~data_stage_sel1 & ~data_stage_sel0 & data_stage1 ) |  // 00 - stage 1 def
                                      (  data_stage_sel1 &  data_stage_sel0 & data_stage2 ) ;  // 11 - stage 2
   wire [DW-1:0]    masked_dout     = selected_data & grp_mask;
   wire [DW-1:0]    not_masked_dout = selected_data & not_grp_mask;
   wire [DW-1:0]    not_masked_pat0 = pat0[DW-1:0]  & not_grp_mask;
   //-----------------------------------------------------
   // pattern comparision flops (no reset)
   //-----------------------------------------------------
   always @ ( posedge clk )
   begin
      p0_val       <= { p0_val[2:0], ( masked_data  == masked_pat0 ) };
      p1_val       <= { p1_val[2:0], ( masked_data  == masked_pat1 ) };
      p2_val       <= { p2_val[2:0], ( masked_data  == masked_pat2 ) };
      p3_val       <= { p3_val[2:0], ( masked_data  == masked_pat3 ) };

      f0_val       <= { f0_val[2:0], ( masked_udata == masked_pat0 ) };
      f1_val       <= { f1_val[2:0], ( masked_udata == masked_pat1 ) };
      f2_val       <= { f2_val[2:0], ( masked_udata == masked_pat2 ) };
      f3_val       <= { f3_val[2:0], ( masked_udata == masked_pat3 ) };

      dout_p0_val  <= ( not_masked_dout == not_masked_pat0 );
      grp_p0_val   <= ( masked_dout == masked_pat0 );
      grp_p1_val   <= ( masked_dout == masked_pat1 );
      grp_p3_val   <= ( masked_dout == masked_pat3 );
      data_stage1  <= data_stage0;
      data_stage2  <= data_stage1;
      data_out     <= selected_data;
   end
   //-----------------------------------------------------
   // group wise data stage0 selection
   //-----------------------------------------------------
   assign data_stage0 = ( DDR_MODE == 1 ) ? ( ( data_flip_sel & unalign_data ) | ( ~data_flip_sel & data_dly ) ) :
                                            ( ( data_flip_sel & unalign_data ) | ( ~data_flip_sel & data_in  ) ) ;
   //-----------------------------------------------------
   // seq blocks
   //-----------------------------------------------------
   always @ ( posedge clk )
   begin
      if ( reset )
      begin
         calib_done       <= 1'b 0;
         calib_error      <= 1'b 0;
         delay_load       <= { DW { 1'b 0 } };
         delay_tap        <= 5'b 0;

         count            <= 3'b 0;
         pat_count        <= 3'b 0;
         step_count       <= 3'b 0;
         min_value_0      <= 5'b 0;
         min_value_1      <= 5'b 0;
         max_value_0      <= 5'b 0;
         max_value_1      <= 5'b 0;
         min_flip_0       <= 1'b 0;
         min_flip_1       <= 1'b 0;
         flip_type        <= 1'b 0;
         grp_count        <= { 5 { 1'b 0 } };
         grp_flip         <= 1'b 0;
         state            <= IDLE;
         data_flip_sel    <= { DW { 1'b 0 } };
         data_stage_sel0  <= { DW { 1'b 0 } };
         data_stage_sel1  <= { DW { 1'b 0 } };
      end
      else
      begin
         calib_done       <= next_calib_done;
         calib_error      <= next_calib_error;
         delay_load       <= { DW { next_delay_load } } & grp_mask;
         delay_tap        <= next_delay_tap;

         count            <= next_count;
         pat_count        <= next_pat_count;
         step_count       <= next_step_count;
         min_value_0      <= next_min_value_0;
         min_value_1      <= next_min_value_1;
         max_value_0      <= next_max_value_0;
         max_value_1      <= next_max_value_1;
         min_flip_0       <= next_min_flip_0;
         min_flip_1       <= next_min_flip_1;
         flip_type        <= next_flip_type;
         grp_count        <= next_grp_count;
         grp_flip         <= next_grp_flip;
         state            <= next_state;
         data_flip_sel    <= ( ( { DW { grp_flip } } & grp_mask ) | data_flip_sel );
         data_stage_sel0  <= next_data_stage_sel0;
         data_stage_sel1  <= next_data_stage_sel1;
      end
   end

   //-----------------------------------------------------
   // fsm
   //-----------------------------------------------------
   always @ ( data_in         or
              calib_start     or
              calib_done      or
              calib_error     or
              delay_load      or
              delay_tap       or
              count           or
              pat_count       or
              step_count      or
              min_value_0     or
              min_value_1     or
              max_value_0     or
              max_value_1     or
              min_flip_0      or
              min_flip_1      or
              flip_type       or
              data_det        or
              flip_det        or
              grp_count       or
              grp_flip        or
              grp_count_done  or
              last_grp        or
              data_stage_sel0 or
              data_stage_sel1 or
              grp_mask        or
              not_grp_mask    or
              dout_p0_val     or
              grp_p0_val      or
              grp_p1_val      or
              grp_p3_val      or
              state           )
   begin
      next_calib_done       = calib_done;
      next_calib_error      = calib_error;
      next_delay_load       = 1'b 0;
      next_delay_tap        = delay_tap;
      next_count            = count;
      next_pat_count        = pat_count;
      next_step_count       = step_count;
      next_min_value_0      = min_value_0;
      next_min_value_1      = min_value_1;
      next_max_value_0      = max_value_0;
      next_max_value_1      = max_value_1;
      next_min_flip_0       = min_flip_0;
      next_min_flip_1       = min_flip_1;
      next_flip_type        = flip_type;
      next_grp_count        = grp_count;
      next_grp_flip         = 1'b 0;
      next_data_stage_sel0  = data_stage_sel0;
      next_data_stage_sel1  = data_stage_sel1;
      next_state            = state;

      pat_valid             = ( data_det & ~flip_type ) | ( flip_det & flip_type );
      count_7               = ( count     == 3'b 111 );
      count_2               = ( count     == 3'b 010 );
      pat_count_7           = ( pat_count == 3'b 111 );
      //-------------------------------------------------------
      // compute mid steps and ranges
      //-------------------------------------------------------
      range_0               = max_value_0 - min_value_0;
      range_1               = max_value_1 - min_value_1;
      sum_0                 = min_value_0 + max_value_0;
      sum_1                 = min_value_1 + max_value_1;
      mid_0                 = sum_0 >> 1;
      mid_1                 = sum_1 >> 1;
      //-------------------------------------------------------
      // decide which window to use.
      //-------------------------------------------------------
      if ( range_0 >= range_1 )
      begin
        sel_mid             = mid_0;
        sel_flip            = min_flip_0;
      end
      else
      begin
        sel_mid             = mid_1;
        sel_flip            = min_flip_1;
      end

      case ( state )
         //-------------------------------------------------------
         // POR state
         //-------------------------------------------------------
         IDLE:
         begin
            next_delay_load        = calib_start;
            next_delay_tap         = 5'b 0;
            next_count             = 3'b 0;
            next_pat_count         = 3'b 0;

            if ( calib_start )
               next_state          = WAIT;
            else
               next_state          = IDLE;
         end
         //-------------------------------------------------------
         // gaurd band, 8 clocks for logic to settle
         //-------------------------------------------------------
         WAIT:
         begin
            next_count             = count + 1'b 1;
            next_pat_count         = 3'b 0;
            if ( count_7 )
               next_state          = DET_START;
            else
               next_state          = WAIT;
         end
         //-------------------------------------------------------
         // wait 8 cycles, then check for Pat0 match in next 8
         // if pat0 not found, move to next step with fail
         // else move to checking next pattern
         //-------------------------------------------------------
         DET_START: // wait for 8 more cycles to check if atleast one data is read
         begin
            next_pat_count         = 3'b 0;
            next_flip_type         = flip_det & ~data_det;

            case ( { ( data_det | flip_det ), count_7 } )
               2'b 10, 2'b 11:
               begin
                  next_count       = 3'b 0;
                  next_state       = DATA_WAIT;
               end
               2'b 01:
               begin
                  next_count       = 3'b 0;
                  next_state       = FAIL_STEP;
               end
               2'b 00:
               begin
                  next_count       = count + 1'b 1;
                  next_state       = DET_START;
               end
            endcase
         end
         //-------------------------------------------------------
         // wait 3 cycles here - shf reg will get 4 patterns
         //-------------------------------------------------------
         DATA_WAIT:
         begin
            next_count             = count + 1'b 1;

            if ( count_2 )
               next_state          = DATA_CHECK;
            else
               next_state          = DATA_WAIT;
         end
         //-------------------------------------------------------
         // comes to this state when data pattern must be valid
         //-------------------------------------------------------
         DATA_CHECK:
         begin
            next_count             = 3'b 0;

            if ( pat_valid )
               next_pat_count      = pat_count + 1'b 1;
            else
               next_pat_count      = 3'b 0;

            case ( { pat_valid, pat_count_7 } )
               2'b 11 : next_state = PASS_STEP;
               2'b 10 : next_state = DATA_WAIT;
               default: next_state = FAIL_STEP;
            endcase
         end
         //-------------------------------------------------------
         // data checked passed at certain step - note step value
         // this state will determine the width of eye (range)
         //-------------------------------------------------------
         PASS_STEP:
         begin
            next_state             = NEXT_STEP;

            case ( step_count )
               3'd 0:
               begin
                  next_min_value_0 = delay_tap;
                  next_min_flip_0  = flip_type;
                  next_max_value_0 = delay_tap;
                  next_step_count  = 3'd 1;
               end
               3'd 1:
               begin
                  if ( min_flip_0 ==  flip_type )
                  begin
                     next_max_value_0 = delay_tap;
                     next_step_count  = step_count;
                  end
                  else
                  begin
                     next_min_value_1 = delay_tap;
                     next_min_flip_1  = flip_type;
                     next_max_value_1 = delay_tap;
                     next_step_count  = 3'd 3;
                  end
               end
               3'd 2:
               begin
                  next_min_value_1 = delay_tap;
                  next_min_flip_1  = flip_type;
                  next_max_value_1 = delay_tap;
                  next_step_count  = 3'd 3;
               end
               3'd 3:
               begin
                  if ( min_flip_1 == flip_type )
                  begin
                     next_max_value_1 = delay_tap;
                     next_step_count  = step_count;
                  end
                  else
                  begin
                     next_step_count  = 3'd 4;
                  end
               end
               default:
               begin
                  next_step_count  = step_count;
               end
            endcase
         end
         //-------------------------------------------------------
         // data check failed step - marks boundary and exit conditions
         //-------------------------------------------------------
         FAIL_STEP:
         begin
            case ( step_count )
               3'd 0  : next_step_count = step_count; // no pass found
               3'd 2  : next_step_count = step_count; // 1 pass range founf
               3'd 4  : next_step_count = step_count; // found 2 ranges already
               3'd 6  : next_step_count = step_count + 1'b 1; // final loop marker
               default: next_step_count = step_count + 1'b 1; // others
            endcase

            next_state             = NEXT_STEP;
         end
         //-------------------------------------------------------
         // move to error or done or next delay step from here
         // all decisions based on delay, step count and grp_count
         //-------------------------------------------------------
         NEXT_STEP:
         begin
            if ( step_count == 3'd 7 )
            begin
               next_state          = DONE;
            end
            else if ( step_count == 3'd 6 )
            begin
               if ( grp_count == 5'd 0 ) // first group, not group skew - set to mid
               begin
                  next_state       = NEXT_GRP;
                  next_grp_count   = grp_count + 1'b 1;
               end
               else
               begin
                  next_state       = WAIT_P0;
               end
            end
            else if ( delay_tap == 5'h 1F ) // last tap
            begin
               next_state          = COMP_MID;
            end
            else
            begin
               next_state          = WAIT;
               next_delay_load     = 1'b 1;
               next_delay_tap      = delay_tap + 1'b 1;
            end
         end
         //-------------------------------------------------------
         // set delay to mid of the detected eye width
         // choose the widest eye in case 2 ranges are present
         // decsion based on step_count - move to checking data again
         //-------------------------------------------------------
         COMP_MID:
         begin
            next_step_count  = 3'd 6;
            next_state       = WAIT;
            next_delay_load  = 1'b 1;

            case ( step_count )
               3'd 0:  //failed - run one more pass with range0
               begin
                  next_delay_tap   = mid_0;
                  next_grp_flip    = min_flip_0;
               end
               3'd 1:  //full range works
               begin
                  next_delay_tap   = mid_0;
                  next_grp_flip    = min_flip_0;
               end
               3'd 2:  //one min and max
               begin
                  next_delay_tap   = mid_0;
                  next_grp_flip    = min_flip_0;
               end
               default: //3'd 3: two min and max (2nd set passes till end) 3'd 4: //two min and max (2nd set is limited)
               begin
                  next_delay_tap   = sel_mid;
                  next_grp_flip    = sel_flip;
               end
            endcase
         end
         //-------------------------------------------------------
         // group wise iteration and exit
         //-------------------------------------------------------
         NEXT_GRP:
         begin
            next_min_value_0       = 5'b 0;
            next_min_value_1       = 5'b 0;
            next_max_value_0       = 5'b 0;
            next_max_value_1       = 5'b 0;
            next_delay_tap         = 5'b 0;
            next_count             = 3'b 0;
            next_pat_count         = 3'b 0;

            if ( grp_count_done )
            begin // only one group
               next_state          = DONE;
               next_step_count     = 3'd 6;
            end
            else
            begin
               next_state          = WAIT;
               next_delay_load     = 1'b 1;
               next_step_count     = 3'd 0;
            end
         end
         //-------------------------------------------------------
         // calib success - no exit, on reset goes to IDLE
         //-------------------------------------------------------
         DONE:
         begin
            next_state             = DONE;
            next_calib_error       = ( step_count == 3'd 7 );
            next_calib_done        = ( step_count == 3'd 6 );
         end
         //-------------------------------------------------------
         // group to group skew correction state
         // waits on starting pattern on other groups
         // checks what is the pattern seen on the current group
         // decides to increase or decrease delay
         // goes to error if pattern matches are not found
         //-------------------------------------------------------
         WAIT_P0:
         begin
            case ( { dout_p0_val, grp_p0_val, grp_p1_val, grp_p3_val } )
               4'b 1100: // same delay 5,5 - no change              - sel0 & sel1 - 00 -> stage 1 sel
               begin
                  next_state           = NEXT_GRP;
                  next_grp_count       = grp_count + 1'b 1;
               end
               4'b 1010: // grp has less delay 5,6 - inc this group - sel0 & sel1 - 11 -> stage 2 sel
               begin
                  next_state           = NEXT_GRP;
                  next_grp_count       = grp_count + 1'b 1;
                  next_data_stage_sel0 = ( { DW { 1'b 1 } } & grp_mask ) | ( data_stage_sel0 & not_grp_mask ); // 1
                  next_data_stage_sel1 = ( { DW { 1'b 1 } } & grp_mask ) | ( data_stage_sel1 & not_grp_mask ); // 1
               end
               4'b 1001: // grp has more delay 5,7 - dec this group - sel0 & sel1 - 10 -> stage 0 sel
               begin
                  next_state           = NEXT_GRP;
                  next_grp_count       = grp_count + 1'b 1;
                  next_data_stage_sel0 = data_stage_sel0;
                  next_data_stage_sel1 = ( { DW { 1'b 1 } } & grp_mask ) | ( data_stage_sel1 & not_grp_mask ); // 1
               end
               4'b 1000: // error
               begin
                  next_state       = DONE;
                  next_step_count  = 3'd 7;
               end
               default : // 4'b 0xxx
               begin
                  next_state       = WAIT_P0;
               end
            endcase
         end
      endcase
   end

   // synthesis translate_off
   reg [255:0] state_str;
   always @ ( state )
   begin
      case ( state )
         IDLE       : state_str = "IDLE";
         WAIT       : state_str = "WAIT";
         DET_START  : state_str = "DET_START";
         DATA_WAIT  : state_str = "DATA_WAIT";
         DATA_CHECK : state_str = "DATA_CHECK";
         PASS_STEP  : state_str = "PASS_STEP";
         FAIL_STEP  : state_str = "FAIL_STEP";
         NEXT_STEP  : state_str = "NEXT_STEP";
         COMP_MID   : state_str = "COMP_MID";
         WAIT_P0    : state_str = "WAIT_P0";
         NEXT_GRP   : state_str = "NEXT_GRP";
         DONE       : state_str = "DONE";
      endcase
   end
   // synthesis translate_on
end
endgenerate

endmodule
