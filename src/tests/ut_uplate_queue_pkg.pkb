create or replace package body ut_uplate_queue_pkg
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
   
   procedure ut_create
   is
   begin
       uplate_queue_pkg.create_and_start_uplate_queue;
       utassert.this('Should create queue', uplate_queue_pkg.uplate_queue_exists);
       utassert.this('Should create queue table', uplate_queue_pkg.uplate_queue_table_exists);
   end;
   
   
   procedure ut_idempotent_create
   is
   begin
       uplate_queue_pkg.create_and_start_uplate_queue;
       utassert.this('Should create queue', uplate_queue_pkg.uplate_queue_exists);
       utassert.this('Should create queue table', uplate_queue_pkg.uplate_queue_table_exists);
       
       uplate_queue_pkg.create_and_start_uplate_queue;
       utassert.this('Queue should exists after repeated create operation', uplate_queue_pkg.uplate_queue_exists);
       utassert.this('Queue table should exists after repeated create operation', uplate_queue_pkg.uplate_queue_table_exists);
   end;
   
   procedure ut_drop
   is
   begin
       uplate_queue_pkg.drop_uplate_queue;
       utassert.this('Queue should not exists', not uplate_queue_pkg.uplate_queue_exists);
       utassert.this('Queue table should not exists', not uplate_queue_pkg.uplate_queue_table_exists);
   end;
   
   procedure ut_create_drop_create
   is
   begin
       uplate_queue_pkg.create_and_start_uplate_queue;
       utassert.this('Create should create queue', uplate_queue_pkg.uplate_queue_exists);
       utassert.this('Create should create queue table', uplate_queue_pkg.uplate_queue_table_exists);
       
       uplate_queue_pkg.drop_uplate_queue;
       utassert.this('After drop queue should not exists', not uplate_queue_pkg.uplate_queue_exists);
       utassert.this('After drop queue table should not exists', not uplate_queue_pkg.uplate_queue_table_exists);
       
       uplate_queue_pkg.create_and_start_uplate_queue;
       utassert.this('After recreate queue should exists again', uplate_queue_pkg.uplate_queue_exists);
       utassert.this('After recreate queue table should exists again', uplate_queue_pkg.uplate_queue_table_exists);
   end;
   
   procedure ut_idempotent_sub_creation
   is
   begin
       uplate_queue_pkg.create_queue_subscribers;
       utassert.this('Queue subscriber should exists'
                   , uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_sms_sub_name)
                 and uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_regulator_check_sub_name)
                   );
                   
       uplate_queue_pkg.create_queue_subscribers;
       utassert.this('Queue subscriber should also exists after recreation'
                   , uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_sms_sub_name)
                 and uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_regulator_check_sub_name)
                   );
         
       uplate_queue_pkg.drop_queue_subscribers;
       utassert.this('Queue subscriber should NOT exists after drop'
                   , not uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_sms_sub_name)
                 and not uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_regulator_check_sub_name)
                   );
                 
                   
       uplate_queue_pkg.create_queue_subscribers;
       utassert.this('Queue subscriber should exists after new creation'
                   , uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_sms_sub_name)
                 and uplate_queue_pkg.uplate_queue_sub_exists(uplate_queue_pkg.get_regulator_check_sub_name)
                   );
   end;
   

end;
/
