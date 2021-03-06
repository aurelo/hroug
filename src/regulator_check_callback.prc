create or replace  procedure regulator_check_callback(
          context     in    raw
        , reginfo     in    sys.aq$_reg_info
        , descr       in    sys.aq$_descriptor
        , payload     in    raw
        , payloadl    in    number
    )
    is
      dequeue_options      dbms_aq.dequeue_options_t;
      message_properties   dbms_aq.message_properties_t;
      message_handle       raw(16);
      message              uplata_ot;
begin
      dequeue_options.msgid         := descr.msg_id;
      dequeue_options.consumer_name := descr.consumer_name;
      dbms_aq.dequeue
      ( queue_name           => descr.queue_name
      , dequeue_options      => dequeue_options
      , message_properties   => message_properties
      , payload              => message
      , msgid                => message_handle
      );
      -- take an action based on the message that was received from the queue
        -- -------------------------------------------------------
      hroug_utils_pkg.log('REGULATOR CHECK CALLBACK: racun=>'||message.racun||' iznos=>'||message.iznos, $$plsql_unit, $$plsql_line);
      
      if message.iznos >= app_pkg.get_number(app_pkg.get_param_value('REGULATOR_CHECK_THRESHOLD'))
      then
          hroug_utils_pkg.log('REGULATOR CHECK CALLBACK: transakcija ulazi u provjeru prema regulatoru', $$plsql_unit, $$plsql_line);
      end if;
      
      commit;
end;
/
