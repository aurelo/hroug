create or replace package body ut_naplata_po_starosti_ot
as
   g_kamata_1      potrazivanje_ot;
   g_kamata_2      potrazivanje_ot;
   g_kamata_3      potrazivanje_ot;
   g_glavnica_1    potrazivanje_ot;
   g_glavnica_2    potrazivanje_ot;
   g_glavnica_3    potrazivanje_ot;
   
   procedure ut_setup
   is
   begin
       g_kamata_1      := potrazivanje_ot(1, 155, interval '15' day, 'KAMATA');
       g_kamata_2      := potrazivanje_ot(2, 188, interval '45' day, 'KAMATA');
       g_kamata_3      := potrazivanje_ot(3, 188, interval '100' day, 'KAMATA');
       g_glavnica_1    := potrazivanje_ot(4, 1564, interval '150' day, 'GLAVNICA');
       g_glavnica_2    := potrazivanje_ot(5, 3265.55, interval '550' day, 'GLAVNICA');
       g_glavnica_3    := potrazivanje_ot(6, 188, interval '100' day, 'GLAVNICA');
   end;
   
   procedure ut_teardown
   is
   begin
      null;
   end;
   
   procedure ut_kreacija
   is
   begin
      utAssert.this('Moguce je kreirati instancu bez potrazivanja',  naplata_po_starosti_ot is not null and naplata_po_starosti_ot.prazna_instanca is not null);
      utAssert.this('Moguce je kreirati instancu sa potrazivanjem',  naplata_po_starosti_ot(g_glavnica_1) is not null and naplata_po_starosti_ot().kreiraj_instancu(g_glavnica_1) is not null);
   end;
   
   procedure ut_usporedba
   is     
   begin
      utAssert.this('Veci broj dana starosti potrazivanja znaci visi prioritet u naplati po starosti'
                  , naplata_po_starosti_ot(g_glavnica_2) > naplata_po_starosti_ot(g_glavnica_1)
                    and 
                    naplata_po_starosti_ot(g_glavnica_1) > naplata_po_starosti_ot(g_kamata_2)
                    and 
                    naplata_po_starosti_ot(g_kamata_2) >  naplata_po_starosti_ot(g_kamata_1)
                    );
      utAssert.this('Isti broj dana starosti znaci jednakost u prioritetu naplate'
                  , naplata_po_starosti_ot(g_glavnica_3) = naplata_po_starosti_ot(g_kamata_3));
      utAssert.this('Ne znam usporedjivati prazne instance i instance inicijalizirane potrazivanjem'
                  , (naplata_po_starosti_ot.prazna_instanca = naplata_po_starosti_ot(g_kamata_3)) is null
                    and
                    (naplata_po_starosti_ot.prazna_instanca != naplata_po_starosti_ot(g_kamata_3)) is null
                    );
   end;
   
end;
/
