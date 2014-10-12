create or replace type body potrazivanje_ot as 
  member function  to_string
  return varchar2
  is
  begin
    return 'potrazivanje id: '||self.id
         ||' tipa: '||self.namjena
         ||' iznosa: '||self.iznos
         ||' je staro: '||extract (DAY from self.starost)||' dan(a)';
  end;
  
--------------------------------------------------------------------------------  
  final member procedure output
  is
  begin
     dbms_output.put_line(to_string);
  end;
  
--------------------------------------------------------------------------------
  map member function id_usporedba 
  return integer
  is
  begin
     return id;
  end;
end;
/
