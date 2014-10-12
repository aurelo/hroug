create or replace package body hroug_test_suite_pkg
is
   C_TEST_SUITE_NAME  constant user_objects.object_name%type := 'HROUG19 OOT Tests'; 

   procedure create_test_suite
   is
   begin
       utSuite.add (C_TEST_SUITE_NAME);
       utPackage.add (C_TEST_SUITE_NAME, 'potrazivanje_ot'); 
       utPackage.add (C_TEST_SUITE_NAME, 'naplata_po_starosti_ot'); 
       utPackage.add (C_TEST_SUITE_NAME, 'naplata_po_namjeni_ot');   
       utPackage.add (C_TEST_SUITE_NAME, 'strategija_naplate_ot');  
       utPackage.add (C_TEST_SUITE_NAME, 'prioriteti_naplate_pkg');  
       utPackage.add (C_TEST_SUITE_NAME, 'uplate_queue_pkg');  
   end;
   
   procedure run_tests
   is
   begin
       utPLSQL.testsuite(C_TEST_SUITE_NAME, recompile_in => false);
   end;
end;
/
