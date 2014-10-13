create or replace package body ut_app_pkg
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
   
   procedure ut_null
   is
   begin
      utAssert.this('Null anydata parametar mora vratiti null vrijednost za broj', app_pkg.get_number(null) is null);
      utAssert.this('Null anydata parametar mora vratiti null vrijednost za date', app_pkg.get_date(null) is null);
      utAssert.this('Null anydata parametar mora vratiti null vrijednost za varchar2', app_pkg.get_varchar2(null) is null);            
   end;
   
end;
/
