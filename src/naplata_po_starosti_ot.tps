create or replace type naplata_po_starosti_ot
   under strategija_naplate_ot(
/*******************************************************************************
 Jedan od algoritama sortiranja potrazivanja prema prioritetu naplate.
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
   constructor function naplata_po_starosti_ot
      return self as result,
--------------------------------------------------------------------------------      
   overriding member function implementacija_usporedbe (
      p_druga_instanca    strategija_naplate_ot
      )
      return integer,
--------------------------------------------------------------------------------      
   overriding member function kreiraj_instancu (
      p_potrazivanje   in potrazivanje_ot
      )
      return strategija_naplate_ot,
/**-----------------------------------------------------------------------------
prazna_instanca:
 Oracle objektni tipovi ne dopustaju predaju objektog tipa kao parametra, stoga
 kao zamjenu koristim praznu instancu.
 Praznu instancu ce koristiti kontekst da bi na osnovu konkretnih potrazivanja
 stvarao konkretne instance, koristeci kreiraj_instancu funkciju
------------------------------------------------------------------------------*/      
   static function prazna_instanca
      return strategija_naplate_ot
)
/
