
-- ========================================================
package pkg_ada_random 
    with SPARK_Mode => on
is
   
   procedure generate_random_integer; 
   procedure generate_random_float; 
   
   function get_random_integer (low_end, high_end : in Integer) return Integer; 
   function get_random_float   (low_end, high_end : in Float  ) return Float; 
   
-- ======================================================== 
end pkg_ada_random;


