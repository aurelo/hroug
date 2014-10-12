create or replace type body naplata_po_starosti_ot
as
   constructor function naplata_po_starosti_ot
      return self as result
   is
   begin
      return;
   end;
--------------------------------------------------------------------------------   
   overriding member function implementacija_usporedbe (
      p_druga_instanca    strategija_naplate_ot)
      return integer
   is
   begin                   
      -- ne znam uspoređivati različite tipove strategija
      if p_druga_instanca is not of (naplata_po_starosti_ot)
      then
         return null;
      end if;

      return sign (
                  extract (day from self.potrazivanje.starost)
                - extract (day from p_druga_instanca.potrazivanje.starost));
   end;
--------------------------------------------------------------------------------   
   overriding member function kreiraj_instancu (
      p_potrazivanje   in potrazivanje_ot)
      return strategija_naplate_ot
   is
   begin
      return new naplata_po_starosti_ot (p_potrazivanje);
   end;

--------------------------------------------------------------------------------
   static function prazna_instanca
      return strategija_naplate_ot
   is
   begin
      return new naplata_po_starosti_ot();
   end;
end;
/
