create or replace type body strategija_naplate_ot as 
   order member function usporedi (
      p_druga_instanca strategija_naplate_ot
   )
   return integer
   is
   begin
      return implementacija_usporedbe(p_druga_instanca);
   end;
end;
/
