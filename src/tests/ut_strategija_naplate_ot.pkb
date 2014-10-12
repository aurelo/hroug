create or replace package body ut_strategija_naplate_ot
as
   g_kamata_1      potrazivanje_ot;
   g_glavnica_1    potrazivanje_ot;
   
   procedure ut_setup
   is
   begin
       g_kamata_1      := potrazivanje_ot(1, 155, interval '15' day, 'KAMATA');
       g_glavnica_1    := potrazivanje_ot(2, 1550, interval '150' day, 'GLAVNICA');
    end;
   
   procedure ut_teardown
   is
   begin
      null;
   end;
   
   procedure ut_usporedba
   is
       v_po_namjeni_kamata_1     strategija_naplate_ot;
       v_po_namjeni_glavnica_1   strategija_naplate_ot;
       v_po_starosti_kamata_1    strategija_naplate_ot;
       v_po_starosti_glavnica_1  strategija_naplate_ot;
       
   begin
       v_po_namjeni_kamata_1     := naplata_po_namjeni_ot(g_kamata_1);
       v_po_namjeni_glavnica_1   := naplata_po_namjeni_ot(g_glavnica_1);
       v_po_starosti_kamata_1    := naplata_po_starosti_ot(g_kamata_1);
       v_po_starosti_glavnica_1  := naplata_po_starosti_ot(g_glavnica_1);
   
      utAssert.this('Ne znam usporedjivati razlicite strategije naplate'
      ,(v_po_namjeni_kamata_1 = v_po_starosti_kamata_1) is null
       and
       (v_po_namjeni_kamata_1 != v_po_starosti_kamata_1) is null
       and
       (v_po_namjeni_kamata_1 = v_po_starosti_glavnica_1) is null
       and
       (v_po_namjeni_kamata_1 != v_po_starosti_glavnica_1) is null
       and
       (v_po_namjeni_glavnica_1 = v_po_starosti_kamata_1) is null
       and
       (v_po_namjeni_glavnica_1 != v_po_starosti_kamata_1) is null
       and
       (v_po_namjeni_glavnica_1 = v_po_starosti_glavnica_1) is null
       and
       (v_po_namjeni_glavnica_1 != v_po_starosti_glavnica_1) is null
      );
   end;
end;
/
