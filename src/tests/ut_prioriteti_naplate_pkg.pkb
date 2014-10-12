create or replace package body ut_prioriteti_naplate_pkg
as
   g_kamata_1      potrazivanje_ot;
   g_kamata_2      potrazivanje_ot;
   g_kamata_3      potrazivanje_ot;
   g_glavnica_1    potrazivanje_ot;
   g_glavnica_2    potrazivanje_ot;
   g_glavnica_3    potrazivanje_ot;
   
   g_potrazivanja_za_sort    potrazivanja_tt;
   
   procedure ut_setup
   is
   begin
       g_kamata_1      := potrazivanje_ot(1, 155, interval '15' day, potrazivanje_ot.KAMATA);
       g_kamata_2      := potrazivanje_ot(2, 188, interval '45' day, potrazivanje_ot.KAMATA);
       g_kamata_3      := potrazivanje_ot(3, 255, interval '1000' day, potrazivanje_ot.KAMATA);
       g_glavnica_1    := potrazivanje_ot(4, 1564, interval '150' day, potrazivanje_ot.GLAVNICA);
       g_glavnica_2    := potrazivanje_ot(5, 3265.55, interval '550' day, potrazivanje_ot.GLAVNICA);
       g_glavnica_3    := potrazivanje_ot(6, 188, interval '1350' day, potrazivanje_ot.GLAVNICA);
       
       g_potrazivanja_za_sort := potrazivanja_tt();
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_kamata_1;
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_kamata_2;
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_kamata_3;
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_glavnica_1;
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_glavnica_2;
       g_potrazivanja_za_sort.extend;
       g_potrazivanja_za_sort(g_potrazivanja_za_sort.count) := g_glavnica_3;
       
   end;
   
   procedure ut_teardown
   is
   begin
     null;
   end;
   
   procedure ut_null_arguments
   is
   begin
 utassert.throws('Illegal argument exception'
                     ,q'<
      ut_prioriteti_naplate_pkg.g_rezultat_sortiranja_tab :=
         prioriteti_naplate_pkg.sortiraj(
          p_kontekst_naplate      => new kontekst_naplate_ot(naplata_po_starosti_ot.prazna_instanca)
         ,p_potrazivanja_tab      => null
         );>'
                     ,hroug_utils_pkg.NULL_ARGUMENT_EXCEPTION
                     );
                     
      utassert.throws('Illegal argument exception'
                     ,q'<
      ut_prioriteti_naplate_pkg.g_rezultat_sortiranja_tab :=
        prioriteti_naplate_pkg.sortiraj(
          p_kontekst_naplate      => null
         ,p_potrazivanja_tab      => new potrazivanja_tt()
         );>'                     
                     ,hroug_utils_pkg.NULL_ARGUMENT_EXCEPTION
                     );
   end;
   
   procedure ut_bez_potrazivanja
   is
   begin
      g_ocekivani_rezultat_tab  := potrazivanja_tt();
      g_rezultat_sortiranja_tab :=
        prioriteti_naplate_pkg.sortiraj(
          p_kontekst_naplate      => new kontekst_naplate_ot(naplata_po_starosti_ot.prazna_instanca)
         ,p_potrazivanja_tab      => new potrazivanja_tt()
         );
      utAssert.eqcoll('Prazna otvorena potrazivanja daju prazan rezultat potrazivanja', 'ut_prioriteti_naplate_pkg.g_rezultat_sortiranja_tab', 'ut_prioriteti_naplate_pkg.g_ocekivani_rezultat_tab');
   end;
   
   procedure ut_sort_po_starosti
   is
   begin
      g_ocekivani_rezultat_tab  := potrazivanja_tt();
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_glavnica_3;
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_kamata_3;
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_glavnica_2;
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_glavnica_1;
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_kamata_2;
      g_ocekivani_rezultat_tab.extend;
      g_ocekivani_rezultat_tab(g_ocekivani_rezultat_tab.count) := g_kamata_1;
      
      
      g_rezultat_sortiranja_tab :=
        prioriteti_naplate_pkg.sortiraj(
          p_kontekst_naplate      => new kontekst_naplate_ot(naplata_po_starosti_ot.prazna_instanca)
         ,p_potrazivanja_tab      => g_potrazivanja_za_sort
         );
      utAssert.eqcoll('Najstarije potrazivanje u naplati po starosti dolazi prvo', 'ut_prioriteti_naplate_pkg.g_rezultat_sortiranja_tab', 'ut_prioriteti_naplate_pkg.g_ocekivani_rezultat_tab');         
   end;
   
   procedure ut_sort_po_namjeni
   is
   begin
      g_rezultat_sortiranja_tab :=
        prioriteti_naplate_pkg.sortiraj(
          p_kontekst_naplate      => new kontekst_naplate_ot(naplata_po_namjeni_ot.prazna_instanca)
         ,p_potrazivanja_tab      => g_potrazivanja_za_sort
         );
      utAssert.this('Kamata u naplati po namjeni dolazi prije glavnice', 
         g_rezultat_sortiranja_tab(1).namjena = potrazivanje_ot.KAMATA
         and
         g_rezultat_sortiranja_tab(2).namjena = potrazivanje_ot.KAMATA
         and
         g_rezultat_sortiranja_tab(3).namjena = potrazivanje_ot.KAMATA
         and
         g_rezultat_sortiranja_tab(4).namjena = potrazivanje_ot.GLAVNICA
         and
         g_rezultat_sortiranja_tab(5).namjena = potrazivanje_ot.GLAVNICA
         and
         g_rezultat_sortiranja_tab(6).namjena = potrazivanje_ot.GLAVNICA
       );
   end;
end;
/
