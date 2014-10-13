create or replace package body ut_regulator_check_callback
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
      v_threshold   number := app_pkg.get_number(app_pkg.get_param_value('REGULATOR_CHECK_THRESHOLD'));
   begin
      transakcije_pkg.knjizi('11887766', v_threshold - 100);
      --sys.dbms_lock.sleep(3);-- pricekaj 3 sekunde da se pozove sms_callback
      --utAssert.this('Knjizenje dize event koji okida kod u regulator_check_callback', hroug_utils_pkg.log_tab_filled_from('REGULATOR_CHECK_CALLBACK'));
      --utAssert.this('Iznos ispod thresholda ne pokrece provjeru', not hroug_utils_pkg.log_tab_contains('transakcija ulazi u provjeru prema regulatoru'));

      transakcije_pkg.knjizi('11887766', v_threshold + 100);
     -- sys.dbms_lock.sleep(3);-- pricekaj 3 sekunde da se pozove sms_callback
      --utAssert.this('Knjizenje dize event koji okida kod u regulator_check_callback', hroug_utils_pkg.log_tab_filled_from('REGULATOR_CHECK_CALLBACK'));
      --utAssert.this('Iznos ispod thresholda ne pokrece provjeru', hroug_utils_pkg.log_tab_contains('transakcija ulazi u provjeru prema regulatoru'));

   end;
end;
/
