create or replace package body naplata_pkg
as
/*******************************************************************************
 Servis za zatvaranje potrazivanja nakon uplate
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
--------------------------------------------------------------------------------
-- PRIVATE FUNCTIONS AND PROCEDURES
--------------------------------------------------------------------------------
     function kolekcija_je_inicijalizirana(
      p_potrazivanja_tab    in     potrazivanja_tt
     )
     return boolean
     is
/**-----------------------------------------------------------------------------
kolekcija_je_inicijalizirana:
 Provjerava je li kolekcija inicijalizirana (nije joj dodjeljena null referenca)
 
%param  p_potrazivanja_tab  kolekcija koju je potrebno provjeriti
------------------------------------------------------------------------------*/
     begin
         return p_potrazivanja_tab is not null;
     end;



     function kolekcija_je_prazna(
      p_potrazivanja_tab    in     potrazivanja_tt
     )
     return boolean
     is
/**-----------------------------------------------------------------------------
kolekcija_je_prazna:
 Provjerava ima li predana kolekcija clanova

%param  p_potrazivanja_tab  kolekcija koju je potrebno provjeriti
------------------------------------------------------------------------------*/
     begin
         return kolekcija_je_inicijalizirana(p_potrazivanja_tab)
         and    p_potrazivanja_tab.count = 0;
     end;


     function filtriraj_za_zatvaranje(
      p_iznos_uplate               in     number
     ,p_sortirana_potrazivanja     in     potrazivanja_tt
     )
     return potrazivanja_tt
     is
/**-----------------------------------------------------------------------------
filtriraj_za_zatvaranje:
 Iz potencijalne liste otvorenih potrazivanja vraca listu koje se moze zatvoriti
 pripadajucom uplatom. Moguce je parcijalno zatvaranje
 
%param   p_iznos_uplate           Iznos sa kojim raspolazemo za zatvaranje
%param   p_sortirana_potrazivanja Lista otvorenih potrazivanja
%return  Listu potrazivanja koju mogu zatvoriti predanom uplatom
------------------------------------------------------------------------------*/
         v_za_zatvaranje_tab       potrazivanja_tt := potrazivanja_tt();
         v_preostali_iznos         number := p_iznos_uplate;
         v_iznos_za_naplatu        number := 0;
     begin
         if  p_iznos_uplate <= 0
         or  kolekcija_je_prazna(p_sortirana_potrazivanja)
         then
            return v_za_zatvaranje_tab;
         end if;

         for i in p_sortirana_potrazivanja.first..p_sortirana_potrazivanja.last
         loop
             v_iznos_za_naplatu := least(p_sortirana_potrazivanja(i).iznos, v_preostali_iznos);
             exit when v_iznos_za_naplatu <= 0;

             v_za_zatvaranje_tab.extend;
             v_za_zatvaranje_tab(v_za_zatvaranje_tab.count) := p_sortirana_potrazivanja(i);
             v_za_zatvaranje_tab(v_za_zatvaranje_tab.count).iznos := v_iznos_za_naplatu;

             v_preostali_iznos := v_preostali_iznos - v_iznos_za_naplatu;
         end loop;

         return v_za_zatvaranje_tab;
     end;


--------------------------------------------------------------------------------
-- PUBLIC FUNCTIONS AND PROCEDURES
--------------------------------------------------------------------------------
     function potrazivanja_mogu_zatvoriti(
      p_iznos_uplate             in     number
     ,p_kontekst_naplate         in     kontekst_naplate_ot
     ,p_otvorena_potrazivanja    in     potrazivanja_tt
     )
     return   potrazivanja_tt
     is
         v_sorted_receivables       potrazivanja_tt;
         v_empty_receivables_tab    potrazivanja_tt;
     begin
         hroug_utils_pkg.require(kolekcija_je_inicijalizirana(p_otvorena_potrazivanja)
                               , 'Neinicijalizirana kolekcija otvorenih potrazivanja!'
                               , hroug_utils_pkg.NULL_ARGUMENT_EXCEPTION);


         v_empty_receivables_tab := potrazivanja_tt();

         if   kolekcija_je_prazna(p_otvorena_potrazivanja)
         then
            return v_empty_receivables_tab;
         end if;

         if p_iznos_uplate <=0
         then
            return v_empty_receivables_tab;
         end if;


         v_sorted_receivables := prioriteti_naplate_pkg.sortiraj(
             p_kontekst_naplate       => p_kontekst_naplate
            ,p_potrazivanja_tab       => p_otvorena_potrazivanja
         );

         return filtriraj_za_zatvaranje(
           p_iznos_uplate
          ,v_sorted_receivables
         );
     end;


--------------------------------------------------------------------------------
     procedure zatvori_potrazivanja(
      p_racun                    in     varchar2
     ,p_iznos_uplate             in     number
     ,p_kontekst_naplate         in     kontekst_naplate_ot
     ,p_otvorena_potrazivanja    in     potrazivanja_tt
     )
     is
         potrazivanja_za_zatvaranje_tab  potrazivanja_tt;
     begin
         hroug_utils_pkg.require(kolekcija_je_inicijalizirana(p_otvorena_potrazivanja)
                               , 'Uninitialized receivables collection!'
                               , hroug_utils_pkg.NULL_ARGUMENT_EXCEPTION);

         potrazivanja_za_zatvaranje_tab := potrazivanja_mogu_zatvoriti(
           p_iznos_uplate
          ,p_kontekst_naplate
          ,p_otvorena_potrazivanja
         );


         if   kolekcija_je_prazna(potrazivanja_za_zatvaranje_tab)
         then
             hroug_utils_pkg.log('All receivables are already closed'
                      ,$$plsql_unit
                      ,$$plsql_line
                      );
            return;
         end if;

         for i in potrazivanja_za_zatvaranje_tab.first..potrazivanja_za_zatvaranje_tab.last
         loop
            transakcije_pkg.knjizi(p_racun, potrazivanja_za_zatvaranje_tab(i).iznos);
         end loop;

     end;

end;
/
