create or replace  procedure sms_callback(
          context     in    raw
        , reginfo     in    sys.aq$_reg_info
        , descr       in    sys.aq$_descriptor
        , payload     in    raw
        , payloadl    in    number
    )
    is
/*******************************************************************************
 Pretplatnik na red (queue) uplata koji salje sms za uplatu.
 Umijesto implementacije samo logira poziv u tablicu da bi se mogao potvrditi
 poziv procedure pretplatnika.
 <p>
 Paket se distribuira kao primjer koda za prezentaciju Oracle Objektni tipovi
 danu na 19. HROUG (@link www.hroug.hr) konferenciji

%author Zlatko Gudasic

CHANGE HISTORY (last one on top!)

When         Who 
dd.mm.yyyy   What
================================================================================
13.08.2014   Zlatko Gudasic         
             Initial creation
             
*******************************************************************************/    
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
      ---------------------------------------------------------
      hroug_utils_pkg.log('SMS CALLBACK: racun=>'||message.racun||' iznos=>'||message.iznos, $$plsql_unit, $$plsql_line);
      commit;
end;
/
