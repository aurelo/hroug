SET VERIFY OFF
SET TERMOUT ON

------------                       CREATE TABLES                      ----------
PROMPT Creating tables...
@@src/app_tables.sql


------------                       CREATE PACKAGE SPECS               ----------
PROMPT Creating package specs
@@src/app_pkg.pks

------------                       CREATE TYPES                       ----------
@@src/potrazivanje_ot.tps
@@src/potrazivanje_ot.tpb
@@src/strategija_naplate_ot.tps
@@src/strategija_naplate_ot.tpb
@@src/naplata_po_starosti_ot.tps
@@src/naplata_po_starosti_ot.tpb
@@src/naplata_po_namjeni_ot.tps
@@src/naplata_po_namjeni_ot.tpb

------------                       CREATE VIEWS                       ----------
@@src/app_env_param_vw.sql


------------                       CREATE PACKAGE BODY                ----------
PROMPT Creating package bodies
@@src/app_pkg.pkb

PROMPT Done.