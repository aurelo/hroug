create or replace package body transakcije_pkg
as
--------------------------------------------------------------------------------
-- PRIVATE PROCEDURES AND FUNCTIONS
--------------------------------------------------------------------------------
      procedure digni_dogadjaj_uplate(
      p_uplata    in   uplata_ot
    )
    is
       queue_options       dbms_aq.enqueue_options_t;
       message_properties  dbms_aq.message_properties_t;
       message_id raw(16);
    begin
   
      dbms_aq.enqueue
      ( queue_name         => uplate_queue_pkg.get_uplate_queue_name
      , enqueue_options    => queue_options
      , message_properties => message_properties
      , payload            => p_uplata
      , msgid              => message_id
      );
      commit;
    end;
--------------------------------------------------------------------------------
-- PUBLIC PROCEDURES AND FUNCTIONS
--------------------------------------------------------------------------------
    procedure knjizi(
     p_racun           in    varchar2
    ,p_iznos           in    number
    )
    is
    begin
        -- logika knjizenja izostavljena, jer je prekompleksna 
        -- i nije vazna za primjer dizanja dogadjaja
        hroug_utils_pkg.log('Uplacujem: '||p_iznos||' sa: '||p_racun, $$plsql_unit, $$plsql_line);
        
        digni_dogadjaj_uplate(new uplata_ot(p_racun, p_iznos));
        
        commit;
    end;
    
end transakcije_pkg;
/
