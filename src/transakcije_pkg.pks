create or replace package transakcije_pkg
as
/*******************************************************************************
 Mock transakcijskog servisa koji je zaduzan za knjizenja.
 Prilikom knjizenja servis dize event.
 Koristi se u primjeru naplate potraživanja prema prioritetu naplate.
 Koristi se u primjeru asinhronih dizanja domenskih dogadjaja koristeci
 oracle Advanced queuing API.
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
knjizi:
 Mock knjizenja koji pretpostavlja da je racun uplatio iznos.
 Dize event nakon knjizenja.

%param  p_racun     Identifikator racuna koji radi transakciju
%param  p_iznos     Iznos koji je racun uplatio za transakciju
------------------------------------------------------------------------------*/
    procedure knjizi(
     p_racun           in    varchar2
    ,p_iznos           in    number
    );
    
end transakcije_pkg;
/
