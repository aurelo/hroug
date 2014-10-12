create or replace type body naplata_po_namjeni_ot
as
   constructor function naplata_po_namjeni_ot
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
      if  p_druga_instanca is not of (naplata_po_namjeni_ot)
      or  potrazivanje is null
      or  p_druga_instanca.potrazivanje is null
      then
         return null;
      end if;
      
      if    self.potrazivanje.namjena = 'KAMATA' 
      and   p_druga_instanca.potrazivanje.namjena != 'KAMATA' 
         then return 1; 
      elsif self.potrazivanje.namjena != 'KAMATA' 
      and   p_druga_instanca.potrazivanje.namjena = 'KAMATA' 
         then return -1;
      else return 0; 
      end if;
   end;
--------------------------------------------------------------------------------   
   overriding member function kreiraj_instancu (
      p_potrazivanje   in potrazivanje_ot)
      return strategija_naplate_ot
   is
   begin
      return new naplata_po_namjeni_ot (p_potrazivanje);
   end;

--------------------------------------------------------------------------------
   static function prazna_instanca
      return strategija_naplate_ot
   is
   begin
      return new naplata_po_namjeni_ot();
   end;
end;
/
