-- File: pkg_ada_random.adb

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;

-- ========================================================
package body pkg_ada_random 
--   with SPARK_Mode => on
is
 
    package ATIO   renames Ada.Text_IO;
 
    -- ==================================================== 
   procedure generate_random_integer 	is
      
      type RandomIntRange is new Integer range 1 .. 100;
      package RandomInt is new Ada.Numerics.Discrete_Random(RandomIntRange);
      use RandomInt;

      GenInt  : Generator;
      RandInt : RandomIntRange;
      
	begin
	   Reset(GenInt);
	   RandInt := Random(GenInt);
       ATIO.Put_line("Random integer (1..100) = " & RandomIntRange'Image(RandInt));
      
   end generate_random_integer;
   
    -- ==================================================== 
    procedure generate_random_float is
      	   
      GenFloat  : Ada.Numerics.Float_Random.Generator;
      RndFloat  : Float;
      
   begin
      -- RESET Generator
      Ada.Numerics.Float_Random.Reset(GenFloat);
      
      -- NOTE: RndFloat is in the range 0.0 .. 1.0,
      RndFloat := Ada.Numerics.Float_Random.Random (GenFloat);
	   
      ATIO.Put_line("Random float (0.0 .. 1.0) = " & Float'Image(RndFloat));
    end generate_random_float;

   -- =====================================================
   function get_random_integer (low_end, high_end : in Integer) return Integer
   is
      
      type RandomIntRange is new Integer range low_end .. high_end;
      package RandomInt is new Ada.Numerics.Discrete_Random(RandomIntRange);
      use RandomInt;

      GenInt  : Generator;
      RandInt : RandomIntRange;
      
   begin
    
      Reset(GenInt);
      RandInt := Random(GenInt);
            
      return (Integer(RandInt));
   end get_random_integer;
   
      
   -- =====================================================   
   function get_random_float (low_end, high_end : in Float  ) return Float 
   is
      GenFloat  : Ada.Numerics.Float_Random.Generator;
      RndFloat  : Float;
      
      the_range      : Float;
      the_rand_float : Float;
      
   begin
   
      Ada.Numerics.Float_Random.Reset(GenFloat);
      -- NOTE: RndFloat is in the range 0.0 .. 1.0,
      RndFloat := Ada.Numerics.Float_Random.Random (GenFloat);
      
      the_range      := (high_end - low_end);
      the_rand_float := (RndFloat * the_range) + low_end;  
   
      return (the_rand_float);
   end get_random_float;
      
-- ========================================================
begin
    null;
end pkg_ada_random; 
-- ========================================================
