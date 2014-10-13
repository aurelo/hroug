create or replace package hroug_utils_pkg
/*******************************************************************************
 Usluzni paket.
 Sadrzi funkcije i procedure koje su po svrsi sporedne glavnim primjerima, ali 
 su nuzne radi cijelovitosti primjera
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
as
  NULL_ARGUMENT_EXCEPTION constant pls_integer := -20191;
  
  type stack_data_rec is record (
   owner            all_objects.object_name%type
  ,object_name      all_objects.object_name%type
  ,object_type      all_objects.object_name%type
  ,line_number      number
  );
  
  type stack_data_tab_type is table of stack_data_rec 
  index by binary_integer;
  

/**-----------------------------------------------------------------------------
assert:
 Funkcija koja provjerava trvrdnju 
 
%param   p_condition       Uvijet za provjeru
%param   p_poruka          Poruka ako uvijet nije istinit
%param   p_error_id        Custom identifikator za dignutu gresku
------------------------------------------------------------------------------*/
    procedure assert(
     p_condition        in    boolean
    ,p_poruka          in    varchar2
    ,p_error_id         in    pls_integer
    );

/**-----------------------------------------------------------------------------
require:
 Funkcija koja provjerava preduvijet (uvijet pod kojima je poziv procedure 
 legitiman)

%param   p_condition       Uvijet za provjeru
%param   p_poruka         Poruka ako uvijet nije istinit
%param   p_error_id        Custom identifikator za dignutu gresku
------------------------------------------------------------------------------*/
    procedure require(
     p_condition        in    boolean
    ,p_poruka          in    varchar2
    ,p_error_id         in    pls_integer
    );
    
    
/**-----------------------------------------------------------------------------
ensure:
 Funkcija koja provjerava postuvijet (uvijet koji se mora ispuniti prilikom
 povratka iz funkcije ili procedure)

%param   p_condition       Uvijet za provjeru
%param   p_poruka          Poruka ako uvijet nije istinit
%param   p_error_id        Custom identifikator za dignutu gresku
------------------------------------------------------------------------------*/
    procedure ensure(
     p_condition        in    boolean
    ,p_poruka          in    varchar2
    ,p_error_id         in    pls_integer
    )
    ;
    
    
/**-----------------------------------------------------------------------------
log:
 Logira poruku u hroug_log tablicu. Funkcija se koristi u kontekstu primjera 
 gdje mijenja pravu implementaciju i daje nacin testiranja procedure (na nacin
 da se provjerava je li procedura popunila ovu tablicu).  

%param   p_poruka         Poruka koju je potrebno logirati
%param   p_plsql_unit      plsql unit koji je pozvao logiranje
%param   p_plsql_line      linija iz plsql unit-a iz koje je pozvano logiranje
------------------------------------------------------------------------------*/
    procedure log(
      p_poruka      in   varchar2
     ,p_plsql_unit   in   varchar2
     ,p_plsql_line   in   integer
    );
    
    
/**-----------------------------------------------------------------------------
clear_log_tab:
 brise redove iz hroug_log logirajuce tablice
------------------------------------------------------------------------------*/
    procedure clear_log_tab;


/**-----------------------------------------------------------------------------
log_tab_count:
 Vraca broj redova u hroug_log tablici

%return number of rows in hroug_log table
------------------------------------------------------------------------------*/
    function log_tab_count
    return   pls_integer;
    
    
/**-----------------------------------------------------------------------------
log_tab_filled_from:
 Provjerava je li hroug_log tablica punjena iz plsql unit-a

%param   p_plsql_unit      plsql unit za provjeriti
%return  true ako je tablica punjena iz upitnog programa, false inace
------------------------------------------------------------------------------*/
    function log_tab_filled_from(
     p_plsql_unit     in    varchar2
    )
    return boolean;
    
    
/**-----------------------------------------------------------------------------
log_tab_contains:
 Provjerava sadrzi li hroug_log tablica odredjenu poruku

%param   p_poruka         Poruka za provjeru
%return  true ako sadrzi poruku, false inace
------------------------------------------------------------------------------*/
    function log_tab_contains(
     p_poruka     in    varchar2
    )
    return boolean;
    
    
    
/**-----------------------------------------------------------------------------
who_called_me:
 By default, returns the name of the package or standalone one level further up
 in the call stack, which represents the caller of the routine that called this
 function. When called indirectly by another layer in the framework, the stack
 level needs to be increased from the default to find out who the real 
 caller's caller is.

%credit Tom Kyte.

%param i_stack_level The depth in the stack to look for caller info.
------------------------------------------------------------------------------*/
  function who_called_me(p_stack_level in pls_integer default 1)  
  return   stack_data_tab_type;

  
/**-----------------------------------------------------------------------------
create_uplate_queue:
 Stvara uplate queue za dizanje domenskih poruka prilikom uplata.
 Zove se u instalacijskoj skripti
------------------------------------------------------------------------------*/  
  procedure create_uplate_queue;
  
/**-----------------------------------------------------------------------------
insert_app_regulator_param:
 Insertira vrijednost za REGULATOR_CHECK_THRESHOLD parametar u strukturu za
 aplikacijske parametre
------------------------------------------------------------------------------*/    
  procedure insert_app_regulator_param;  
    
end hroug_utils_pkg;
/
