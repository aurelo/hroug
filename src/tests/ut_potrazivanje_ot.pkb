create or replace package body ut_potrazivanje_ot
as

   procedure ut_setup
   is
   begin
      null;
   end;
   
   
   procedure ut_teardown
   is
   begin
      null;
   end;
   
   
   procedure ut_usporedba
   is
     v_potrazivanje_1  potrazivanje_ot;
     v_potrazivanje_2  potrazivanje_ot;
     v_potrazivanje_3  potrazivanje_ot;
     v_potrazivanje_1b potrazivanje_ot;
     
   begin
     v_potrazivanje_1  := new potrazivanje_ot(1, 100, interval '2' day, 'GLAVNICA');
     v_potrazivanje_1b := new potrazivanje_ot(1, 100, interval '2' day, 'GLAVNICA');
     v_potrazivanje_2  := new potrazivanje_ot(2, 100, interval '20' day, 'KAMATA');
     v_potrazivanje_3  := new potrazivanje_ot(3, 100, interval '200' day, 'KAMATA');
     
     utassert.this('Jednaki identifikatori daju jednakost u usporedbi objekata', v_potrazivanje_1 = v_potrazivanje_1b);
     utassert.this('Manji identifikator daje manji objekt', v_potrazivanje_1 < v_potrazivanje_2 and v_potrazivanje_1 < v_potrazivanje_3 and v_potrazivanje_2 < v_potrazivanje_3);
   end;
  
  
   procedure ut_to_string
   is
       v_ac  potrazivanje_ot;
   begin
       v_ac  := new potrazivanje_ot(1, 435, interval '2' day, 'GLAVNICA');
       utAssert.this('Tekstualna prezentacija potrazivanja daje sve vazne informacije'
                    , v_ac.to_string like '%1%' and 
                      v_ac.to_string like '%435%' and 
                      v_ac.to_string like '%2%' and
                      v_ac.to_string like '%GLAVNICA%');
   end;
end;
/
