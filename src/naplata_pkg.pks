create or replace package naplata_pkg
as
/*******************************************************************************
 Servis za zatvaranje potrazivanja nakon uplate.
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

/**-----------------------------------------------------------------------------
potrazivanja_mogu_zatvoriti:
 Iz liste otvorenih potrazivanja vraca listu potrazivanja koje se mogu zatvoriti
 uz danu uplatu, te pripadajucu strategiju naplate

%param  p_iznos_uplate           Uplaceni iznos koji ce se koristiti za naplatu
%param  p_kontekst_naplate       Kontekst koji sadrzi strategiju naplate 
                                 potrazivanja
%param  p_otvorena_potrazivanja  Lista otvorenih potrazivanja iz koje vracamo
                                 one koje je moguce naplatiti
------------------------------------------------------------------------------*/
     function potrazivanja_mogu_zatvoriti(
      p_iznos_uplate             in     number
     ,p_kontekst_naplate         in     kontekst_naplate_ot
     ,p_otvorena_potrazivanja    in     potrazivanja_tt
     )
     return   potrazivanja_tt;


/**-----------------------------------------------------------------------------
zatvori_potrazivanja:
 Zatvara sva otvorena potrazivanja koja je moguce zatvoriti uzimajuci u obzir
 pripadajuci algoritam naplate i uplaceni iznos

%param  p_racun                  Racun koji je izvrsio uplatu
%param  p_iznos_uplate           Uplaceni iznos koji ce se koristiti za naplatu
%param  p_kontekst_naplate       Kontekst koji sadrzi strategiju naplate 
                                 potrazivanja
%param  p_otvorena_potrazivanja  Lista otvorenih potrazivanja iz koje vracamo
                                 one koje je moguce naplatiti
------------------------------------------------------------------------------*/
     procedure zatvori_potrazivanja(
      p_racun                    in     varchar2
     ,p_iznos_uplate             in     number
     ,p_kontekst_naplate         in     kontekst_naplate_ot
     ,p_otvorena_potrazivanja    in     potrazivanja_tt
     );


end;
/
