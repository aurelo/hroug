create or replace procedure klijent_primjer
is
  v_potrazivanje_1    potrazivanje_ot;
  v_potrazivanje_2    potrazivanje_ot;
  
  v_potrazivanja_tab  potrazivanja_tt;
  
  po_starosti         kontekst_naplate_ot;
begin
  -- stvori tablicu otvorenih potrazivanja
  v_potrazivanje_1    := potrazivanje_ot(
          id          => 1
         ,iznos       => 100
         ,starost     => interval '200' day
         ,namjena     => potrazivanje_ot.KAMATA
                      );
  v_potrazivanje_2    := potrazivanje_ot(
          id          => 2
         ,iznos       => 100005
         ,starost     => interval '600' day
         ,namjena     => potrazivanje_ot.GLAVNICA
                      );
  v_potrazivanja_tab := potrazivanja_tt();
  v_potrazivanja_tab.extend;
  v_potrazivanja_tab(v_potrazivanja_tab.count) := v_potrazivanje_1;
  v_potrazivanja_tab.extend;
  v_potrazivanja_tab(v_potrazivanja_tab.count) := v_potrazivanje_2;
  
  
  -- odredi algoritam koji ce se koristiti u naplati po prioritetima
  po_starosti := kontekst_naplate_ot(naplata_po_starosti_ot.prazna_instanca);
  
  
  -- pozovi servis za naplatu potrazivanja, uz pretpostavku da je sjela uplata 
  -- od 7500 na racunu 12345678 
  naplata_pkg.zatvori_potrazivanja(
      p_racun                 => '12345678'
     ,p_iznos_uplate          => 107500
     ,p_kontekst_naplate      => po_starosti
     ,p_otvorena_potrazivanja => v_potrazivanja_tab
     )
     ;
  
end;
/
