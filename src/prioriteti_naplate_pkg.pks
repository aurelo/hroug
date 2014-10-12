create or replace package prioriteti_naplate_pkg
as
/*******************************************************************************
 Servis za sortiranje potrazivanja prema prioritetu naplate.
 Koristi se u primjeru naplate potraživanja prema prioritetu naplate. 
 <p>
 Paket se distribuira kao primjer koda za prezentaciju Oracle Objektni tipovi
 danu na 19. HROUG (@link www.hroug.hr) konferenciji

%author Zlatko Gudasic

CHANGE HISTORY (last one on top!)

When         Who
dd.mm.yyyy   What
================================================================================
13.08.2014   Zlatko Gudasic
             Initial creation

*******************************************************************************/
   function sortiraj (
      p_kontekst_naplate   in kontekst_naplate_ot,
      p_potrazivanja_tab   in potrazivanja_tt
      )
      return potrazivanja_tt;
end;
/
