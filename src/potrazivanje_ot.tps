create or replace type potrazivanje_ot as object ( 
/*******************************************************************************
 Sadrži osnovne informacije za potraživanje.
 Koristi se u primjeru naplate potraživanja prema prioritetu naplate.
 <p>
 Tip se distribuira kao primjer koda za prezentaciju Oracle Objektni tipovi
 danu na 19. HROUG (@link www.hroug.hr) konferenciji

%author Zlatko Gudasic

CHANGE HISTORY (last one on top!)

When         Who
dd.mm.yyyy   What
================================================================================
13.08.2014   Zlatko Gudasic
             Incijalna kreacija

*******************************************************************************/
  id          number 
 ,iznos       number 
 ,starost     interval day(9) to second(0) 
 ,namjena     varchar2(16) 
 ,member function  to_string
  return varchar2
 ,final member procedure output
 ,map member  function id_usporedba return integer
)
/
