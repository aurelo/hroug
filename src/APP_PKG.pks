create or replace package app_pkg
is
/*******************************************************************************
 Paket za rad sa infrastrukturom aplikacijskih parametara
 U paketu se pokazuje rad sa Oracle Any tipovima
 <p>
 Paket se distribuira kao primjer koda za prezentaciju Oracle Objektni tipovi
 danu na 19. HROUG (@link www.hroug.hr) konferenciji

%author Zlatko Gudasic

CHANGE HISTORY (last one on top!)

When         Who
dd.mm.yyyy   What
================================================================================
13.08.2014   Zlatko Gudasic
             Incijalna kreacija

*******************************************************************************/

   function get_number(
     p_anydata in anydata 
   ) 
   return number; 
   
   function get_date(
     p_anydata in anydata 
   )
   return date; 
   
   function get_varchar2(
     p_anydata in anydata 
   ) 
   return varchar2;
   
   function get_param_value(
    p_param_name     in   app_param.name%type
   )
   return anydata;
   
end;
/
