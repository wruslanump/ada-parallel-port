-- File: main_ada_parallel_port.adb
-- Date: Sun 21 Feb 2021 03:57:40 PM +08
-- Author: WRY wruslan.ump@gmail.com
-- ========================================================

-- IMPORT STANDARD ADA PACKAGES
with Ada.Text_IO;
with Ada.Real_Time; 
use  Ada.Real_Time;
with Ada.Strings.Unbounded; 
use  Ada.Strings.Unbounded;

with Interfaces.C; 
use  Interfaces.C; 
with Interfaces.C.Extensions;
use  Interfaces.C.Extensions;


-- IMPORT USER-DEFINED ADA PACKAGES
with pkg_ada_dtstamp;
with pkg_ada_ppdev;       -- FOR main_ada_test2.adb
-- with pkg_aada_ppdev;   -- FOR main_ada_test1.adb
with pkg_ada_random;                          

-- ========================================================
procedure main_ada_parallel_port
-- ========================================================
	with SPARK_Mode => on
is 

   -- RENAME STANDARD ADA PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package ART     renames Ada.Real_Time;
   package ASU     renames Ada.Strings.Unbounded;
   package IFaceC  renames Interfaces.C;
   package IFaceCE renames Interfaces.C.Extensions;
      
   -- RENAME USER-DEFINED ADA PACKAGES FOR CONVENIENCE
   package PADTS   renames pkg_ada_dtstamp;
   package PAPPDEV renames pkg_ada_ppdev;        -- FOR main_ada_test2.adb
   -- package PAAPPDEV renames pkg_aada_ppdev;   -- FOR main_ada_test1.adb
   package PAR     renames pkg_ada_random;  
   
-- CONSTANTS DEFINED IN /usr/src/linux-5.4.66/include/uapi/asm-generic/fcntl.h
-- FOR FILE DESCRIPTOR ATTRIBUTES fd_attrib
   O_RDONLY  : IFaceC.int    := 0; -- HEx= 0x00  BIN= 00000000
   O_WRONLY  : IFaceC.int    := 1; -- HEx= 0x01  BIN= 00000001
   O_RDWR    : IFaceC.int    := 2; -- HEx= 0x02  BIN= 00000010
   O_ACCMODE : IFaceC.int    := 3; -- HEx= 0x03  BIN= 00000011
   
   PPDATADIR_OUT : IFaceC.int := 0;   -- (0 for OUT, 1 for IN)
   PPDATADIR_IN  : IFaceC.int := 1;   -- (0 for OUT, 1 for IN)
   
   -- VARIABLES USED FOR PACKAGE Interfaces.C
   -- ARRANGED IN ORDER OF USAGE OR APPEARANCE
   port          : IFaceC.char_array := "/dev/parport0";
   
   -- VALID FD ATTRIBUTE VALUES = {0, 1, 2, 3, ..}
   fd_attrib     : IFaceC.int := 2;   -- for O_RDWR;  
   ret_open      : IFaceC.int := 999;
   fd            : IFaceC.int := 999; 
   ret_claim     : IFaceC.int := 999;
   
   -- VALID PP_MODE VALUES = {1, 2, 4, 8, 16}
   modetoset     : IFaceC.int := 8;   -- for PARPORT_MODE_ECP; 
   ret_setmode   : IFaceC.int := 999;   
   ret_getmode   : IFaceC.int := 999; 
   
   -- VALID PP_DATA DIRECTION VALUES = {0, 1}
   datadirection      : IFaceC.int := 0;   -- for PPDATADIR_OUT 
   ret_direction      : IFaceC.int := 999; 
   stream_datatowrite : IFaceC.char_array := "Subhanallah Walhamdulillah WallahHuakbar WRY."; 
   ret_writestream    : IFaceC.int := 999; 
   ret_release        : IFaceC.int := 999; 
   ret_close          : IFaceC.int := 999; 
   
   random_int         : Integer := 255;
   ret_inttowrite     : IFaceC.int := 999; 
   
begin
-- ========================================================   
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;   
  
   -- =====================================================   
   -- (1) Open parallel port  (Need sudo = root privileges)   
   PADTS.dtstamp; 
   ret_open := PAPPDEV.GetC_ada_ioctl_open_parport(port, fd_attrib);
   fd := ret_open; 
   
   -- (2) Parallel port - CLAIM, SETMODE, GETMODE, SET DIRECTION 
   PADTS.dtstamp; ret_claim     := PAPPDEV.GetC_ada_ioctl_ppclaim_parport (fd);
   PADTS.dtstamp; ret_setmode   := PAPPDEV.GetC_ada_ioctl_ppsetmode_parport (fd, modetoset);
   PADTS.dtstamp; ret_getmode   := PAPPDEV.GetC_ada_ioctl_ppgetmode_current (fd);
   PADTS.dtstamp; ret_direction := PAPPDEV.GetC_ada_ioctl_ppdatadir_dataport (fd, datadirection);
   
   -- (3.1) WRITE STREAM DATA TO PARALLEL PORT DATA REGISTER
   -- ATIO.New_Line;
   -- PADTS.dtstamp; 
   -- ret_writestream := PAPPDEV.GetC_ada_ioctl_streamdata_writedataregister (fd, stream_datatowrite);
   
   -- (3.2) WRITE RANDOM INTEGER DATA TO PARALLEL PORT DATA REGISTER
   ATIO.New_Line;
   ATIO.Put_Line("Parport write random integers in a loop");
   -- loop   -- TO RUN LOOP FOREVER
   for idx in 1 .. 10 loop
      random_int := PAR.get_random_integer (0, 255);
      ret_inttowrite := PAPPDEV.GetC_ada_ioctl_ppwdata_writedataregister(fd, IFaceC.int(random_int)); 
   end loop;
   
   -- (3.3) READ CNC FILE AND WRITE INTEGER DATA TO PARALLEL PORT DATA REGISTER
   
   
   -- (4) Parallel port - RELEASE AND CLOSE  
   ATIO.New_Line;
   PADTS.dtstamp; ret_release := PAPPDEV.GetC_ada_ioctl_pprelease_parport; 
   PADTS.dtstamp; ret_close := PAPPDEV.GetC_ada_ioctl_close_parport(fd); 

   ATIO.New_Line; PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
-- Catch all possible errors using built-in package Ada.Standard
-- ========================================================
exception
	when Constraint_Error => ATIO.Put_Line ("Constraint_Error raised.");
	when Program_Error    => ATIO.Put_Line ("Program_Error raised.");
	when Storage_Error    => ATIO.Put_Line ("Storage_Error raised.");
	when Tasking_Error    => ATIO.Put_Line ("Task_Error raised.");
	when Others => ATIO.Put_Line("Others raised. Unknown error.");
   -- null;   
   
-- ========================================================   
end main_ada_parallel_port;
-- ========================================================
