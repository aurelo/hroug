create or replace type strategija_naplate_ot as object
(
/*******************************************************************************
 Apstraktni tip koji enkapsulira algoritme za odredjivanje prioriteta naplate
 potraživanja.
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
   potrazivanje potrazivanje_ot,   
/**-----------------------------------------------------------------------------
usporedi:
 Order funkcija koja usporedjuje trenutnu instancu sa predanom

%param  p_druga_instanca   instanca sa kojom želimo usporediti trenutnu
%note   order funkcije nije dopusteno nadvladavati, stoga je zaobilazno rjesenje
        da se implementacija usporedbe u podtipovima radi u obicnoj member 
        funkciji (implementacija usporedbe), a order funkcija samo prosljeduje 
        zahtjev implementaciji uspredbe
------------------------------------------------------------------------------*/
   order member function usporedi (
      p_druga_instanca strategija_naplate_ot
   )
   return integer,
/**-----------------------------------------------------------------------------
implementacija_usporedbe:
 Sadrzi znanje koje potrazivanje ima prioritet u naplati za konkretan algoritam
 naplate

%param  p_druga_instanca   instanca sa kojom želimo usporediti trenutnu
------------------------------------------------------------------------------*/  
   not instantiable not final member function implementacija_usporedbe (
      p_druga_instanca    strategija_naplate_ot
   )
   return integer,
/**-----------------------------------------------------------------------------
kreiraj_instancu:
 Svaki podtip strategije naplate se mora znati kreirati iz potrazivanja

%param  p_potrazivanje  instanca jednog od otvorenih potrazivanja
------------------------------------------------------------------------------*/      
   not instantiable member function kreiraj_instancu (
      p_potrazivanje   in potrazivanje_ot
   )
   return strategija_naplate_ot
)
not instantiable not final;
/
