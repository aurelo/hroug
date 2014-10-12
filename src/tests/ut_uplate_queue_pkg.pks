create or replace package ut_uplate_queue_pkg
as
   procedure ut_setup;
   procedure ut_teardown;
   
   procedure ut_create;
   procedure ut_idempotent_create;
   
   procedure ut_drop;
   procedure ut_create_drop_create;
   
   procedure ut_idempotent_sub_creation;
   
end;
/
