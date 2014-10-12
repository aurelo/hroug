create or replace package body uplate_queue_pkg
as
-------------------------------------------------------------------------------- 
-- PACKAGE CONSTANTS, VARIABLES, TYPES, EXCEPTIONS 
--------------------------------------------------------------------------------
    QUEUE_PAYLOAD constant user_objects.object_name%type := 'UPLATA_OT';
    QUEUE_TABLE   constant user_objects.object_name%type := 'UPLATE_QT';
    QUEUE_NAME    constant user_objects.object_name%type := 'UPLATE_EVENTS_QUEUE';
    
    
    SMS_SUBSCRIBER             constant user_objects.object_name%type := 'PAYMENT_SMS_SUBSCRIBER';
    REGULATOR_CHECK_SUBSCRIBER constant user_objects.object_name%type := 'REGULATOR_CHECK_SUBSCRIBER';
    
-------------------------------------------------------------------------------- 
-- PRIVATE FUNCTIONS AND PROCEDURES 
--------------------------------------------------------------------------------
    procedure create_queue_table
    is
    begin
       dbms_aqadm.create_queue_table
          ( queue_table         => QUEUE_TABLE
          , queue_payload_type  => QUEUE_PAYLOAD
          , multiple_consumers  => true
          , comment             => 'Obavijesti za transakcijske dogadjaje uplata'
          );
    end;
   
-------------------------------------------------------------------------------- 
    procedure create_queue
    is
    begin
          dbms_aqadm.create_queue
          ( queue_name  => QUEUE_NAME
          , queue_table => QUEUE_TABLE
          );
    end;
    
--------------------------------------------------------------------------------    
    procedure start_queue
    is
    begin
         dbms_aqadm.start_queue( queue_name => QUEUE_NAME);
    end;
    
   function uplate_queue_exists
   return   boolean
   is
       v_cnt     integer;
   begin
       select   count(*)
       into     v_cnt
       from     dual
       where  exists(
          select   null
          from     user_queues uqs
          where    uqs.name = QUEUE_NAME 
       )
       ; 
       
       return v_cnt > 0;
   end;
   
-------------------------------------------------------------------------------- 
-- PUBLIC FUNCTIONS AND PROCEDURES 
--------------------------------------------------------------------------------
   function uplate_queue_table_exists
   return   boolean
   is
       v_cnt    integer;
   begin
       select   count(*)
       into     v_cnt
       from     dual
       where  exists(
        select    null
        from      user_queue_tables t
        where     t.queue_table = QUEUE_TABLE
       );
       
       return v_cnt > 0;
   end;   
   
--------------------------------------------------------------------------------
   function get_uplate_queue_name
   return   user_objects.object_name%type
   is
   begin
       return QUEUE_NAME;
   end;
   
--------------------------------------------------------------------------------
   procedure create_and_start_uplate_queue
   is
   begin
       drop_uplate_queue;    
   
       if not uplate_queue_table_exists
       then
          create_queue_table;
       end if;
       
       if not uplate_queue_exists
       then
          create_queue;
       end if;
       
       start_queue;
   end; 
   
--------------------------------------------------------------------------------
   procedure drop_uplate_queue
   is
   begin
       if uplate_queue_table_exists
       then
           dbms_aqadm.drop_queue_table(
              queue_table => QUEUE_TABLE
             ,force => true
             );
       end if;
   
       if uplate_queue_exists
       then
           dbms_aqadm.stop_queue(
              queue_name => QUEUE_NAME
              );
           dbms_aqadm.drop_queue(
              queue_name => QUEUE_NAME
              );
       end if;
   end;
   
--------------------------------------------------------------------------------
   function uplate_queue_sub_exists(
    p_subscriber_name     in    user_objects.object_name%type
   )
   return   boolean
   is
       v_cnt   integer;
   begin
       select    count(*)
       into      v_cnt
       from      dual
       where     exists(
          select   null
          from     user_queue_subscribers uqs
          where    uqs.queue_name = QUEUE_NAME
          and      uqs.consumer_name in upper(p_subscriber_name)
       )
       ;
       
       return v_cnt > 0;
   end;  
   
--------------------------------------------------------------------------------   
   procedure create_queue_subscribers
   is
   begin
   
      if not uplate_queue_sub_exists(REGULATOR_CHECK_SUBSCRIBER)
      then
   
          dbms_aqadm.add_subscriber( 
            queue_name => QUEUE_NAME
          , subscriber => sys.aq$_agent( REGULATOR_CHECK_SUBSCRIBER, null, null )
          );
              
          dbms_aq.register
          ( sys.aq$_reg_info_list
            ( sys.aq$_reg_info
              ( QUEUE_NAME||':'||REGULATOR_CHECK_SUBSCRIBER
              , dbms_aq.namespace_aq
              , 'plsql://regulator_check_callback' -- name of the PL/SQL procedure that should be invoked to handle the message
              , hextoraw('ff')
              )
            )
          , 1
          );
      end if;
      
      
      if not uplate_queue_sub_exists(SMS_SUBSCRIBER)
      then
          dbms_aqadm.add_subscriber( 
            queue_name => QUEUE_NAME
          , subscriber => sys.aq$_agent( SMS_SUBSCRIBER, null, null )
          );
              
          dbms_aq.register
          ( sys.aq$_reg_info_list
            ( sys.aq$_reg_info
              ( QUEUE_NAME||':'||SMS_SUBSCRIBER
              , dbms_aq.namespace_aq
              , 'plsql://sms_callback' -- name of the PL/SQL procedure that should be invoked to handle the message
              , hextoraw('ff')
              )
            )
          , 1
          );
      end if;
   end;
   
--------------------------------------------------------------------------------
   procedure drop_queue_subscribers
   is
   begin
       if uplate_queue_sub_exists(SMS_SUBSCRIBER)
       then
           dbms_aqadm.remove_subscriber(
            queue_name => QUEUE_NAME
          , subscriber => sys.aq$_agent( SMS_SUBSCRIBER, null, null)
          );
       end if;
       
       if uplate_queue_sub_exists(REGULATOR_CHECK_SUBSCRIBER)
       then
           dbms_aqadm.remove_subscriber(
            queue_name => QUEUE_NAME
          , subscriber => sys.aq$_agent(REGULATOR_CHECK_SUBSCRIBER, null, null)
          );
       end if;
   end;
   
--------------------------------------------------------------------------------
   function get_sms_sub_name
   return   user_objects.object_name%type
   is
   begin
       return SMS_SUBSCRIBER;
   end; 
   
--------------------------------------------------------------------------------  
   function get_regulator_check_sub_name
   return   user_objects.object_name%type
   is
   begin
       return REGULATOR_CHECK_SUBSCRIBER;
   end; 
end;
/
