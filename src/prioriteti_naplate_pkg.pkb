create or replace package body prioriteti_naplate_pkg
as
-------------------------------------------------------------------------------- 
-- PRIVATE FUNCTIONS AND PROCEDURES 
--------------------------------------------------------------------------------
   function instance_iz_potrazivanja (
      p_kontekst_naplate   in kontekst_naplate_ot,
      p_potrazivanja_tab   in potrazivanja_tt
   )
   return strategija_naplate_tt
   is
      v_potrazivanja_po_prioritetu   strategija_naplate_tt
                                        := strategija_naplate_tt ();
      v_loop_index                   pls_integer;
      v_potrazivanje_rec             potrazivanje_ot;
   begin
      for v_loop_index in p_potrazivanja_tab.first .. p_potrazivanja_tab.last
      loop
         v_potrazivanje_rec := p_potrazivanja_tab (v_loop_index);
         v_potrazivanja_po_prioritetu.extend;
         v_potrazivanja_po_prioritetu (v_potrazivanja_po_prioritetu.last) :=
            p_kontekst_naplate.kreiraj_instancu_strategije (v_potrazivanje_rec);
      end loop;

      return v_potrazivanja_po_prioritetu;
   end;
-------------------------------------------------------------------------------- 
   function get_potrazivanja_po_prioritetu (
      p_potrazivanja_tab in strategija_naplate_tt
   )
   return potrazivanja_tt
   is
      v_sortirana_potrazivanja_tab   potrazivanja_tt;
   begin
      select value (tab).potrazivanje
      bulk collect into v_sortirana_potrazivanja_tab
      from table (p_potrazivanja_tab) tab
      order by value (tab) desc
      ;
      
      return v_sortirana_potrazivanja_tab;
   end;
-------------------------------------------------------------------------------- 
-- PUBLIC FUNCTIONS AND PROCEDURES 
--------------------------------------------------------------------------------
   function sortiraj (
      p_kontekst_naplate   in kontekst_naplate_ot,
      p_potrazivanja_tab   in potrazivanja_tt
   )
      return potrazivanja_tt
   is
      v_instance_strategije_naplate   strategija_naplate_tt;
      v_sortirana_potrazivanja_tab    potrazivanja_tt;
   begin
      hroug_utils_pkg.require(p_potrazivanja_tab is not null and p_kontekst_naplate is not null
                            , 'Sortiranje prema prioritetu moguce samo uz inicijaliziran kontekst i potrazivanja!'
                            , hroug_utils_pkg.NULL_ARGUMENT_EXCEPTION);   
      
      if  p_potrazivanja_tab.count = 0
      then
          return p_potrazivanja_tab;
      end if;
      
      
      -- kreiraj instance strategija naplate iz konteksta naplate i potrazivanja
      v_instance_strategije_naplate := instance_iz_potrazivanja (
         p_kontekst_naplate
        ,p_potrazivanja_tab
      );
      
      -- vrati sortirane promete
      return get_potrazivanja_po_prioritetu (v_instance_strategije_naplate);
   end;
end;
/
