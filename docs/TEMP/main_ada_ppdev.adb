-- File	: main_ada_ppdev.adb
-- Date	: Sat 12 Dec 2020 01:32:03 PM +08
-- Env	: Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38 
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- AppIDE: /usr/bin/gnat-gps 
-- GPS 19.2 (@GPS_DATE@) hosted on x86_64-linux-gnu) 
-- GNAT 9.3.0 the GNAT Programming Studio (c) 2001-2019.2 AdaCore

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Interfaces.C; use  Interfaces.C; 
with Interfaces.C.Extensions; use  Interfaces.C.Extensions;
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Real_Time; use Ada.Real_Time;

-- ADA STRING MANIPULATION
-- Ada has three(3) types of strings:
-- fixed length, bounded length, unbounded.
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Bounded;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Command_Line;

-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;
-- with pkg_ada_ppdev; -- FOR main_ada_test2.adb
with pkg_aada_ppdev;   -- FOR main_ada_test2.adb

procedure main_ada_ppdev is
   
   -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package IFaceC  renames Interfaces.C;
   package IFaceCE renames Interfaces.C.Extensions;
   package ACal    renames Ada.Calendar;
   package ACalF   renames Ada.Calendar.Formatting;
   package ART     renames Ada.Real_Time;
   
   -- RENAMING ADA STRING PACKAGES
   package AS     renames Ada.Strings;
   package ASF    renames Ada.Strings.Fixed;
   package ASB    renames Ada.Strings.Bounded;
   package ASU    renames Ada.Strings.Unbounded;
   package ASUTIO renames Ada.Strings.Unbounded.Text_IO;
   package ACL    renames Ada.Command_Line;  
   
   -- RENAMING WRY CREATED PACKAGES
   package PADTS    renames pkg_ada_dtstamp;
   -- package PAPPDEV renames pkg_ada_ppdev;  -- FOR main_ada_test2.adb
   package PAAPPDEV renames pkg_aada_ppdev;   -- FOR main_ada_test1.adb
   

-- VARIABLES USED FOR PACKAGE Interfaces.C	    
   port          : IFaceC.char_array := "/dev/parport0";
   fd            : IFaceC.int := 999; -- Just for initialization
   fd_attrib     : IFaceC.int := 999; -- Just for initialization
  
-- CONSTANTS DEFINED IN /usr/src/linux-5.4.66/include/uapi/asm-generic/fcntl.h
-- FOR FILE DESCRIPTOR ATTRIBUTES fd_attrib
   O_RDONLY  : IFaceC.int    := 0; -- HEx= 0x00  BIN= 00000000
   O_WRONLY  : IFaceC.int    := 1; -- HEx= 0x01  BIN= 00000001
   O_RDWR    : IFaceC.int    := 2; -- HEx= 0x02  BIN= 00000010
   O_ACCMODE : IFaceC.int    := 3; -- HEx= 0x03  BIN= 00000011
   
   ret01  : IFaceC.int := 999; ret02  : IFaceC.int := 999;
   ret03  : IFaceC.int := 999; ret04  : IFaceC.int := 999; 
   ret05  : IFaceC.int := 999; ret06  : IFaceC.int := 999; 
   ret07  : IFaceC.int := 999; ret08  : IFaceC.int := 999;
   ret09  : IFaceC.int := 999; ret10  : IFaceC.int := 999;
   ret11  : IFaceC.int := 999; ret12  : IFaceC.int := 999;
   ret13  : IFaceC.int := 999; ret14  : IFaceC.int := 999;
   ret15  : IFaceC.int := 999; ret16  : IFaceC.int := 999; 
   ret17  : IFaceC.int := 999; ret18  : IFaceC.int := 999; 
   ret19  : IFaceC.int := 999; ret20  : IFaceC.int := 999;
   ret21  : IFaceC.int := 999; ret22  : IFaceC.int := 999;
   ret23  : IFaceC.int := 999; ret24  : IFaceC.int := 999;
   
   the_ppmodes   : IFaceC.int := 999;
   modetoset     : IFaceC.int := 999;
   flagstoset    : IFaceC.int := 999; 
   phasetoset    : IFaceC.int := 999; 
   
   PPDATADIR_OUT : IFaceC.int := 0;   -- (0 for OUT, 1 for IN)
   datadirection : IFaceC.int := 999;
   datatowrite   : IFaceC.int := 999; -- VALID RANGE [0..255] 
   
   controltowrite   : IFaceC.int := 999; 
   the_interrupt    : IFaceC.int := 999; 
   
   stream_datatowrite : IFaceC.char_array := "Bismillah 3 times WRY.";
   
   -- RTNow : ART.Time;
   -- datestring : ASU.Unbounded_String; -- no initialization needed, default empty
   -- timestring : ASU.Unbounded_String; -- no initialization needed, default empty
   
begin
     
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community (20200427)");
   -- =====================================================   
      
   -- VALID FD ATTRIBUTE VALUES = {0, 1, 2, 3, ..}
   fd_attrib := 2; -- for O_RDWR; 
   PADTS.dtstamp; ret01 := PAAPPDEV.GetA_open_parport(port, fd_attrib);
   
   fd := ret01;  -- SET FILE DESCRIPTOR
   PADTS.dtstamp; ret02 := PAAPPDEV.GetA_ppclaim_parport (fd);
   PADTS.dtstamp; ret03 := PAAPPDEV.GetA_ppgetmodes_parport (fd);
   
   -- VALID PP_MODE VALUES = {1, 2, 4, 8, 16}
   modetoset := 8; -- for PARPORT_MODE_ECP; 
   PADTS.dtstamp; ret04 := PAAPPDEV.GetA_ppsetmode_parport (fd, modetoset);
   PADTS.dtstamp; ret05 := PAAPPDEV.GetA_ppgetmode_current (fd);
     
   -- VALID PP_FLAGS VALUES = {4, 8, 12, 16, 20, 24}
   flagstoset := 12; -- for PP_FASTWRITE | PP_FASTREAD 
   PADTS.dtstamp; ret06 := PAAPPDEV.GetA_ppsetflags_parport (fd, flagstoset);
   PADTS.dtstamp; ret07 := PAAPPDEV.GetA_ppgetflags_current (fd);
   
   -- VALID PP_PHASE VALUES = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
   phasetoset := 9;  -- for IEEE1284_PH_ECP_FWD_TO_REV
   PADTS.dtstamp; ret08 := PAAPPDEV.GetA_ppsetphase_parport (fd, phasetoset);
   PADTS.dtstamp; ret09 := PAAPPDEV.GetA_ppgetphase_current (fd);
   
   -- VALID PP_DATA DIRECTION VALUES = {0, 1}
   datadirection := 0; -- for PPDATADIR_OUT 
   PADTS.dtstamp; ret10 := PAAPPDEV.GetA_ppdatadir_dataport (fd, datadirection);
    
   -- VALID DATA SIGNALS = {0..255} INCLUSIVE (8-BIT DATA PORT)
   datatowrite := 138; 
   PADTS.dtstamp; ret11 := PAAPPDEV.GetA_ppwdata_writedataregister (fd, datatowrite);
   PADTS.dtstamp; ret12 := PAAPPDEV.GetA_pprdata_readdataregister (fd);
   
    -- VALID STATUS SIGNALS = {8, 16, 32, 64, 128}  READ ONLY / WRITE OBSOLETED
   PADTS.dtstamp; ret13 := PAAPPDEV.GetA_pprstatus_readstatusregister (fd);
   
   -- VALID CONTROL SIGNALS = {1, 2, 4, 8}
   controltowrite := 8; 
   PADTS.dtstamp; ret14 := PAAPPDEV.GetA_ppwcontrol_writecontrolregister (fd, controltowrite);
   PADTS.dtstamp; ret15 := PAAPPDEV.GetA_pprcontrol_readcontrolregister (fd);
   
   PADTS.dtstamp; ret16 := PAAPPDEV.GetA_ppfcontrol_frob1;
   PADTS.dtstamp; ret17 := PAAPPDEV.GetA_ppfcontrol_frob2;
   
   the_interrupt := 5; -- IRQ NUMBER FOR PARPORT 
   PADTS.dtstamp; ret18 := PAAPPDEV.GetA_ppwctlonirq_controlport (fd, the_interrupt);
   
   -- CLEAR INTERRUPT, SET IRQ = 0
   PADTS.dtstamp; ret19 := PAAPPDEV.GetA_ppclrirq_controlport (fd, the_interrupt);
   
   the_interrupt := 5; -- IRQ NUMBER FOR PARPORT - RESET IRQ AFTER CLEAR
   PADTS.dtstamp; ret18 := PAAPPDEV.GetA_ppwctlonirq_controlport (fd, the_interrupt);

   -- VALID PARPORT MODE VALUES = {1, 2, 4, 8, 16}
   modetoset := 8;  
   PADTS.dtstamp; ret20 := PAAPPDEV.GetA_ppnegot_mode (fd, modetoset);
   
   PADTS.dtstamp; ret21 := PAAPPDEV.GetA_ppyield_parport (fd);
   PADTS.dtstamp; ret22 := PAAPPDEV.GetA_ppgettime_usec_parport (fd);
    
   -- TEST WRITE STREAM DATA
   -- stream_datatowrite := "Bismillah 3 times WRY."  
   PADTS.dtstamp; ret11:= PAAPPDEV.GetA_streamdata_writedataregister (fd, stream_datatowrite);
       
   PADTS.dtstamp; ret23 := PAAPPDEV.GetA_pprelease_parport; 
   PADTS.dtstamp; ret24 := PAAPPDEV.GetA_close_parport(fd); 
-- ========================================================      
   ATIO.New_Line;
   PADTS.dtstamp; ATiO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
-- LIST OF MODES FOR PARALLEL PORT (USE DIFFERENT PACKAGE)
-- LIST OF FLAGS FOR PARALLEL PORT
-- LIST OF PHASES FOR PARALLEL PORT
   
-- ========================================================   
-- Catch every possible error using built-in package Ada.Standard
exception
	when Constraint_Error =>
		ATIO.Put_Line("Constraint_Error raised.");
	when Program_Error =>
		ATIO.Put_Line("Program_Error raised.");
	when Storage_Error =>
		ATIO.Put_Line("Storage_Error raised.");
	when Tasking_Error =>
		ATIO.Put_Line("Task_Error raised.");
	when Others =>
       ATIO.Put_Line("Others raised. Unknown error.");
      
  -- null;
end main_ada_ppdev;

