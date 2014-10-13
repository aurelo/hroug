create or replace package uplate_queue_pkg
as
/*******************************************************************************
 Sadrzi infrastrukturu za stvaranje reda (queue) uplata, kao i nekoliko 
 pretplatnika na red.
 Paket se koristi da demonstrira Oracle Advanced Queuing API i koristi ga 
 transakcijski servis (transakcije_pkg)
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
/**-----------------------------------------------------------------------------
uplate_queue_exists:
 Provjerava postoji li red uplata
------------------------------------------------------------------------------*/
   function uplate_queue_exists
   return   boolean;
   
/**-----------------------------------------------------------------------------
uplate_queue_table_exists:
 Provjerava postoji li tablica reda uplata
------------------------------------------------------------------------------*/
   function uplate_queue_table_exists
   return   boolean;   
   
/**-----------------------------------------------------------------------------
get_uplate_queue_name:
 Vraca ime reda uplate
------------------------------------------------------------------------------*/
   function get_uplate_queue_name
   return   user_objects.object_name%type;   
   
/**-----------------------------------------------------------------------------
create_and_start_uplate_queue:
 Stvara i starta red (queue) uplata koji se koristi u transakcijskom servisu
------------------------------------------------------------------------------*/
   procedure create_and_start_uplate_queue;   
   
/**-----------------------------------------------------------------------------
drop_uplate_queue:
 Dropa red(queue) uplata queue i infrastrukturu podrske
------------------------------------------------------------------------------*/
   procedure drop_uplate_queue;   
   
/**-----------------------------------------------------------------------------
uplate_queue_sub_exists:
 Provjerava postoji li pretplatnik na red uplata
 
%param p_subscriber_name  ime pretplatnika za kojeg zelimo provjeriti postojanje
------------------------------------------------------------------------------*/   
   function uplate_queue_sub_exists(
    p_subscriber_name     in    user_objects.object_name%type
   )
   return   boolean;   
   
/**-----------------------------------------------------------------------------
create_queue_subscribers:
 Registrira pretplatnike na red uplata
------------------------------------------------------------------------------*/   
   procedure create_queue_subscribers;   
   
/**-----------------------------------------------------------------------------
drop_queue_subscribers:
 Dropa pretplatnike na redu(queue) uplata
------------------------------------------------------------------------------*/   
   procedure drop_queue_subscribers;   
   
/**-----------------------------------------------------------------------------
get_sms_sub_name:
 Vraca ime sms pretplatnika na red(queue) uplata
------------------------------------------------------------------------------*/
   function get_sms_sub_name
   return   user_objects.object_name%type;   
   
/**-----------------------------------------------------------------------------
get_regulator_check_sub_name:
 Vraca ime pretplatnika na red (queue) uplata koji kontrolira transakcije
 prema uputama regulatora
------------------------------------------------------------------------------*/   
   function get_regulator_check_sub_name
   return   user_objects.object_name%type;   
end;
/
