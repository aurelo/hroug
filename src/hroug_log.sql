PROMPT Creating table HROUG_LOG...
create table hroug_log
(
 id              number
,datum_kreacije  timestamp not null
,poruka          varchar2(4000)
,plsql_unit      varchar2(30)
,plsql_line      integer
)
;
alter table hroug_log add (
  constraint hroug_log_pk primary key (id)
)
;
create sequence hroug_log_seq;
create or replace trigger hroug_log_bir
before insert on hroug_log
for each row
begin
  :new.id             := hroug_log_seq.nextval;
  :new.datum_kreacije := systimestamp; 
end;
/
