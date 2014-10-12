create or replace package ut_prioriteti_naplate_pkg
as
   g_rezultat_sortiranja_tab   potrazivanja_tt;
   g_ocekivani_rezultat_tab    potrazivanja_tt;

   procedure ut_setup;
   procedure ut_teardown;
   
   procedure ut_null_arguments;
   procedure ut_bez_potrazivanja;
   
   procedure ut_sort_po_starosti;
   procedure ut_sort_po_namjeni;
end;
/
