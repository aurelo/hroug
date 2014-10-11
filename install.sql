SET VERIFY OFF
SET TERMOUT ON

------------                       CREATE TABLES                      ----------
PROMPT Creating tables...
@@src/app_tables.sql


------------                       CREATE PACKAGE SPECS               ----------
PROMPT Creating package specs
@@src/app_pkg.pks

------------                       CREATE TYPES                       ----------

------------                       CREATE VIEWS                       ----------
@@src/app_env_param_vw.sql


------------                       CREATE PACKAGE BODY                ----------
PROMPT Creating package bodies
@@src/app_pkg.pkb

PROMPT Done.