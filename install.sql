SET VERIFY OFF
SET TERMOUT ON

------------                       CREATE TABLES                      ----------
PROMPT Creating tables...
@@src/app_tables.sql
@@src/hroug_log.sql

------------                       CREATE PACKAGE SPECS               ----------
PROMPT Creating base package specs
@@src/app_pkg.pks
@@src/hroug_utils_pkg.pks

------------                       CREATE TYPES                       ----------
@@src/potrazivanje_ot.tps
@@src/potrazivanje_ot.tpb
@@src/potrazivanja_tt.sql
@@src/strategija_naplate_ot.tps
@@src/strategija_naplate_ot.tpb
@@src/naplata_po_starosti_ot.tps
@@src/naplata_po_starosti_ot.tpb
@@src/naplata_po_namjeni_ot.tps
@@src/naplata_po_namjeni_ot.tpb
@@src/kontekst_naplate_ot.tps
@@src/kontekst_naplate_ot.tpb
@@src/uplata_ot.tps

------------                       CREATE PACKAGE SPECS               ----------
PROMPT Creating types dependant package specs
@@src/transakcije_pkg.pks
@@src/prioriteti_naplate_pkg.pks
@@src/naplata_pkg.pks
------------                       CREATE VIEWS                       ----------
@@src/app_env_param_vw.sql


------------                       CREATE PACKAGE BODY                ----------
PROMPT Creating package bodies
@@src/app_pkg.pkb
@@src/hroug_utils_pkg.pkb
@@src/transakcije_pkg.pkb
@@src/prioriteti_naplate_pkg.pkb
@@src/naplata_pkg.pkb

PROMPT Done.