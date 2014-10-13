 <meta charset="UTF-8"> 
#Oracle objektni tipovi - gdje, zašto i kako

Na [19. HROUG](http://www.hroug.hr/) konferenciji održan je govor uz koji ide ovaj primjer koda. 

Tema govora su Oracle Objektni tipovi, te primjeri obrađuju teme AnyData objektnog tipa, Oracle Advanced Queuing API-ja, te implementacije obrasca strategije (strategy pattern).

##Instalacija
Primjere instalirati u Oracle 11g ili višu verziju baze.
Preporuka je instalirati primjere u za to predviđenu schemu, pa dropati cijelu schemu kada primjeri nisu potrebni.

1. Kreacija scheme/usera:
  a) Logirati se kao system
  b) Pokrenuti skriptu create_user.sql i slijediti upute
2. Instalacija primjera:
  a) Logirati se kao user kreiran u koraku 1
  b) Pokrenuti skriptu install.sql

###Instalacija testova
Uz primjer dolaze testovi rađeni pomoću [utPlsql](http://sourceforge.net/projects/utplsql/files/) frameworka čija je instalacija potrebna da bi testovi radili.

Instalacija testova nije nužna.

1. Logirati se user kreiran u instalacijskom koraku 1
2. Pokrenuti skriptu install_tests.sql
3. Pokrenuti testove:
```
  set serveroutput on size 1000000;
  exec hroug_test_suite_pkg.create_test_suite;
  exec hroug_test_suite_pkg.run_tests;
```

##Upute
Primjer klijenta je dan u proceduri: `klijent_primjer`

Ideja primjera dolazi iz bankarske domene. Nakon ugovaranja kredita klijenti imaju dogovanja raznih tipova koje je po uplati potrebno zatvarati prema prioritetu naplate.
U tu svrhu služi *servis naplate* koji zove klijent iz primjera.

Da bi dobio redoslijed potraživanja, servis za naplatu konzultira servis *prioriteta naplata* koji koristi **implementaciju obrasca strategije**.

Servis za naplatu zatim knjiži prema dobivenom prioritetu koristeći *transakcijski servis*.

*Transakcijski servis* prilikom knjiženja diže **domenski događaj** koristeći **Oracle Advanced Queuing API**.

Događaju osluškuju dva pretplatnika. *SMS pretplatnik* i *pretplatnik koji ispunjava zahtjeve regulatora*. Regulator traži prijavu svih transakcija iznad određenog iznosa. Da bi pročitao o kojem se iznosu radi, koristi se *APP* struktura u kojoj su vrijednosti parametara zapisani kao **AnyData Objektni tip**.
