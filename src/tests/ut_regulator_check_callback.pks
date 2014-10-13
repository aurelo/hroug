create or replace package ut_regulator_check_callback
as
   procedure ut_setup;
   procedure ut_teardown;
   
   procedure ut_is_called;
end;
/
