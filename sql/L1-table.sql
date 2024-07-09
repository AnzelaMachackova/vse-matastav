-- funkce
CREATE OR REPLACE TABLE `L1.L1_funkce` AS
SELECT 
    idfce, 
    nazev, 
    ohodnoceni
FROM `L0.t_funkce`;

-- kategorie_zak
CREATE OR REPLACE TABLE `L1.L1_kategorie_zak` AS
SELECT
    idkat,
    Nazev AS nazev,
    Sleva AS sleva
FROM `L0.t_kategorie_zakazniku`;


-- plan_skut
CREATE OR REPLACE TABLE `L1.L1_plan_skut` AS
SELECT
    idskut,
    skut
FROM `L0.pomSkut`;

-- pobocka
CREATE OR REPLACE TABLE `L1.L1_pobocka` AS
SELECT 
    idpob, 
    Nazev as nazev, 
    Mesto as mesto, 
    Najem as najem
FROM `L0.t_pobocky`;

-- tok
CREATE OR REPLACE TABLE `L1.L1_tok` AS
SELECT 
    idtok, 
    tok
FROM `L0.pomTok`;

-- zaplaceno
CREATE OR REPLACE TABLE `L1.L1_zaplaceno` AS
SELECT 
      idzaplaceno,
      zaplaceno 
FROM `vse-matastav.L0.pomZaplaceno`;

-- typ vydaje
CREATE OR REPLACE TABLE `L1.L1_typ_vydaje` AS
SELECT
    idoper,
    oper
FROM `L0.pomOper`;

-- typ zdroje
CREATE OR REPLACE TABLE `L1.L1_typ_zdroje` AS
SELECT 
    idtypzdroje, 
    Typ as typ
FROM `L0.t_typy_zdroju`;

-- vcas
CREATE OR REPLACE TABLE `L1.L1_vcas` AS
SELECT 
    idvcas, 
    vcas
FROM `L0.pomVcas`;

-- zdroje
CREATE OR REPLACE TABLE `L1.L1_zdroje` AS
SELECT 
    idzdroje, 
    Nazev as nazev, 
    naklady, 
    cena, 
    idtypzdroje
FROM `L0.t_zdroje`;

-- zakaznik - chybi tu okres, kraj dle číselníku
CREATE OR REPLACE TABLE `L1.L1_zakaznik` AS
SELECT 
    idzak, 
    Kredit as kredit, 
    Nazev as nazev, 
    PSC as psc, 
    Mesto as mesto, 
    idkat
FROM `L0.t_zakaznici`;

-- zamestnanec
CREATE OR REPLACE TABLE `L1.L1_zamestnanec` AS
SELECT 
    idzam, 
    Prijmeni as prijmeni, 
    Jmeno as jmeno, 
    Plat as plat, 
    idfce
FROM `L0.t_zamestnanci`;

-- transakce
-- vydaje
CREATE OR REPLACE TABLE `L1.L1_transakce` AS
-- mzdy
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    null as id_kontrakt, 
    3 as id_typ_vydaje, 
    2 as id_plan_skut, 
    idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_mzdy_plan`
UNION ALL
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    null as id_kontrakt, 
    3 as id_typ_vydaje, 
    1 as id_plan_skut, 
    idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_mzdy_skutecnost`
UNION ALL
-- najem
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    idpob, 
    datum,
    null as id_kontrakt, 
    1 as id_typ_vydaje, 
    1 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_najem_skutecnost`
UNION ALL
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    idpob, 
    datum, 
    null as id_kontrakt, 
    1 as id_typ_vydaje, 
    2 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_najem_plan`
-- osobni
UNION ALL 
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    null as id_kontrakt, 
    4 as id_typ_vydaje, 
    2 as id_plan_skut, 
    idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_osobni_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    null as id_kontrakt, 
    4 as id_typ_vydaje, 
    1 as id_plan_skut, 
    idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_osobni_skutecnost`
-- rezie 
UNION ALL
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    idpob, 
    datum,
    null as id_kontrakt, 
    4 as id_typ_vydaje, 
    2 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_rezie_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    idpob, 
    datum,
    null as id_kontrakt, 
    4 as id_typ_vydaje, 
    1 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    null as id_zdroje, 
    castka
FROM `L0.t_vydaje_rezie_skutecnost`
-- zdroje
UNION ALL
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    idkontr, 
    2 as id_typ_vydaje, 
    2 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    idzdroje, 
    castka
FROM `L0.t_vydaje_zdroje_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    idkontr, 
    2 as id_typ_vydaje, 
    1 as id_plan_skut, 
    null as idzam, 
    2 as id_tok, 
    idzdroje, 
    castka
FROM `L0.t_vydaje_zdroje_skutecnost`
UNION ALL
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    idkontr, 
    null as id_typ_vydaje, 
    2 as id_plan_skut, 
    null as idzam, 
    1 as id_tok, 
    null as idzdroje, 
    castka
FROM `L0.t_prijmy_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() as id_transakce, 
    idpol, 
    null as id_pobocka, 
    datum, 
    idkontr, 
    null as id_typ_vydaje, 
    1 as id_plan_skut, 
    null as idzam, 
    1 as id_tok, 
    null as idzdroje, 
    castka
FROM `L0.t_prijmy_skutecnost`;

UPDATE `L1.L1_transakce`
SET datum =  TIMESTAMP(
              CONCAT(
              CAST(EXTRACT(YEAR FROM datum) + 2000 AS STRING),
              SUBSTR(CAST(datum AS STRING), 5)
              )
          )
WHERE EXTRACT(YEAR FROM datum) <= 22;

-- kontrakt
CREATE OR REPLACE TABLE `L1.L1_kontrakt` AS
SELECT 
    GENERATE_UUID() as id_polozky, 
    z.idzam, 
    k.idkontr, 
    k.idzak, 
    k.idzdroje, 
    f.idvcas, 
    f.idzaplaceno, 
    k.datumod, 
    k.datumdo, 
    k.cena_celkem as cena_kontrakt, 
    s.NPS as nps, 
    k.naklady_celkem, 
    f.cena_celkem as cena_faktura
FROM `L0.t_kontrakty` k
JOIN `L0.t_faktury_vydane` f 
ON k.idkontr = f.idkontr AND k.idzak = f.idzak
LEFT JOIN `L0.t_zakaznici` z 
ON k.idzak = z.idzak
LEFT JOIN `L0.t_spokojenost` s 
ON k.idzak = s.idzak AND k.idkontr = s.idkontr;

UPDATE `L1.L1_kontrakt`
SET datumdo =  TIMESTAMP(
              CONCAT(
              CAST(EXTRACT(YEAR FROM datumdo) + 2000 AS STRING),
              SUBSTR(CAST(datumdo AS STRING), 5)
              )
          )
WHERE EXTRACT(YEAR FROM datumdo) <= 22;

UPDATE `L1.L1_kontrakt`
SET datumod =  TIMESTAMP(
              CONCAT(
              CAST(EXTRACT(YEAR FROM datumod) + 2000 AS STRING),
              SUBSTR(CAST(datumod AS STRING), 5)
              )
          )
WHERE EXTRACT(YEAR FROM datumod) <= 21;


