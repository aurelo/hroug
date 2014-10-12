create or replace type kontekst_naplate_ot
   as object
(
/*******************************************************************************
 Tip koji sadrzi informaciju o algoritmu naplate koji se koristi u naplati po
 prioritetu.
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
   strategija_naplate strategija_naplate_ot,
   member function kreiraj_instancu_strategije (
      p_potrazivanje   in out potrazivanje_ot
   )
   return strategija_naplate_ot
)
/
