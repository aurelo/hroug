SET VERIFY OFF
SET TERMOUT ON

------------                       CREATE PACKAGE SPECS               ----------
@@src/tests/hroug_test_suite_pkg.pks
@@src/tests/ut_potrazivanje_ot.pks
@@src/tests/ut_naplata_po_starosti_ot.pks
@@src/tests/ut_naplata_po_namjeni_ot.pks
@@src/tests/ut_strategija_naplate_ot.pks
@@src/tests/ut_uplate_queue_pkg.pks
@@src/tests/ut_prioriteti_naplate_pkg.pks
@@src/tests/ut_app_pkg.pks
@@src/tests/ut_sms_callback.pks
@@src/tests/ut_regulator_check_callback.pks

------------                       CREATE PACKAGE BODY                ----------
@@src/tests/hroug_test_suite_pkg.pkb
@@src/tests/ut_potrazivanje_ot.pkb
@@src/tests/ut_naplata_po_starosti_ot.pkb
@@src/tests/ut_naplata_po_namjeni_ot.pkb
@@src/tests/ut_strategija_naplate_ot.pkb
@@src/tests/ut_uplate_queue_pkg.pkb
@@src/tests/ut_prioriteti_naplate_pkg.pks
@@src/tests/ut_app_pkg.pkb
@@src/tests/ut_sms_callback.pkb
@@src/tests/ut_regulator_check_callback.pks

