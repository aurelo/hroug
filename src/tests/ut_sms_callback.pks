create or replace package ut_sms_callback
as
   procedure ut_setup;
   procedure ut_teardown;
   
   procedure ut_is_called;
end;
/
