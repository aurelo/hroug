create or replace type body kontekst_naplate_ot
as
   member function kreiraj_instancu_strategije (
      p_potrazivanje   in out potrazivanje_ot)
      return strategija_naplate_ot
   is
      strategija_naplate   strategija_naplate_ot;
   begin
      return self.strategija_naplate.kreiraj_instancu (p_potrazivanje);
   end;
end;
/
