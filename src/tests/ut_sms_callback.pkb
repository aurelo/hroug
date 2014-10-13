create or replace package body ut_sms_callback
as
   procedure ut_setup
   is
   begin
      hroug_utils_pkg.clear_log_tab;
   end;
   
   procedure ut_teardown
   is
   begin
      null;
   end;
   
   procedure ut_is_called
   is
   begin
      transakcije_pkg.knjizi('11887766', 354.48);
      --sys.dbms_lock.sleep(3);-- pricekaj 3 sekunde da se pozove sms_callback
      --utAssert.this('Knjizenje dize event koji okida kod u sms_callback', hroug_utils_pkg.log_tab_filled_from('SMS_CALLBACK'));
   end;
end;
/
