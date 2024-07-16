-- funkce
CREATE OR REPLACE TABLE `L1.L1_funkce` AS
SELECT 
    idfce AS id_fce, 
    nazev, 
    ohodnoceni
FROM `L0.t_funkce`;

-- kategorie_zak
CREATE OR REPLACE TABLE `L1.L1_kategorie_zak` AS
SELECT
    idkat AS id_kat,
    Nazev AS nazev,
    Sleva AS sleva
FROM `L0.t_kategorie_zakazniku`;


-- plan_skut
CREATE OR REPLACE TABLE `L1.L1_plan_skut` AS
SELECT
    idskut AS id_skut,
    skut
FROM `L0.pomSkut`;

-- pobocka
CREATE OR REPLACE TABLE `L1.L1_pobocka` AS
SELECT 
    idpob AS id_pobocka, 
    Zkratka AS zkratka,
    Nazev AS nazev, 
    Mesto AS mesto, 
    Najem AS najem
FROM `L0.t_pobocky`;

-- tok
CREATE OR REPLACE TABLE `L1.L1_tok` AS
SELECT 
    idtok AS id_tok, 
    tok
FROM `L0.pomTok`;

-- zaplaceno
CREATE OR REPLACE TABLE `L1.L1_zaplaceno` AS
SELECT 
      idzaplaceno AS id_zaplaceno,
      zaplaceno 
FROM `L0.pomZaplaceno`;

-- typ vydaje
CREATE OR REPLACE TABLE `L1.L1_typ_vydaje` AS
SELECT
    idoper AS id_oper,
    oper
FROM `L0.pomOper`;

-- typ zdroje
CREATE OR REPLACE TABLE `L1.L1_typ_zdroje` AS
SELECT 
    idtypzdroje AS id_typ_zdroje, 
    Typ AS typ
FROM `L0.t_typy_zdroju`;

-- vcas
CREATE OR REPLACE TABLE `L1.L1_vcas` AS
SELECT 
    idvcas AS id_vcas, 
    vcas
FROM `L0.pomVcas`;

-- zdroje
CREATE OR REPLACE TABLE `L1.L1_zdroje` AS
SELECT 
    idzdroje AS id_zdroje, 
    Nazev AS nazev, 
    naklady, 
    cena, 
    idtypzdroje AS id_typ_zdroje
FROM `L0.t_zdroje`;

-- zakaznik - chybi tu okres, kraj dle číselníku
CREATE OR REPLACE TABLE `L1.L1_zakaznik` AS
SELECT 
    idzak AS id_zak, 
    Kredit AS kredit, 
    Nazev AS nazev, 
    PSC AS psc, 
    Mesto AS mesto, 
    idkat AS id_kat
FROM `L0.t_zakaznici`;

-- zamestnanec
CREATE OR REPLACE TABLE `L1.L1_zamestnanec` AS
SELECT 
    idzam AS id_zam, 
    Prijmeni AS prijmeni, 
    Jmeno AS jmeno, 
    Plat AS plat, 
    idfce AS id_fce
FROM `L0.t_zamestnanci`;

-- transakce
-- vydaje
CREATE OR REPLACE TABLE `L1.L1_transakce` AS
-- mzdy
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    null AS id_kontrakt, 
    3 AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    idzam AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_mzdy_plan`
UNION ALL
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    null AS id_kontrakt, 
    3 AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    idzam AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_mzdy_skutecnost`
UNION ALL
-- najem
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum,
    null AS id_kontrakt, 
    1 AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_najem_skutecnost`
UNION ALL
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum, 
    null AS id_kontrakt, 
    1 AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_najem_plan`
-- osobni
UNION ALL 
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    null AS id_kontrakt, 
    4 AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    idzam AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_osobni_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    null AS id_kontrakt, 
    4 AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    idzam AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_osobni_skutecnost`
-- rezie 
UNION ALL
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum,
    null AS id_kontrakt, 
    5 AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_rezie_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum,
    null AS id_kontrakt, 
    5 AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM `L0.t_vydaje_rezie_skutecnost`
-- zdroje
UNION ALL
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    idkontr AS id_kontrakt, 
    2 AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    idzdroje AS id_zdroje, 
    castka
FROM `L0.t_vydaje_zdroje_plan`
UNION ALL 
SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    null AS id_pobocka, 
    datum, 
    idkontr AS id_kontrakt, 
    2 AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    null AS id_zam, 
    2 AS id_tok, 
    idzdroje AS id_zdroje, 
    castka
FROM `L0.t_vydaje_zdroje_skutecnost`
UNION ALL
(WITH p_plan AS (
  SELECT skt.*,
         zam.idzam,
         zam.idpob
  FROM `L0.t_prijmy_plan` skt
  LEFT JOIN `L0.t_kontrakty` kontr
  ON skt.idkontr = kontr.idkontr
  LEFT JOIN `L0.t_zakaznici` zak
  ON zak.idzak = kontr.idzak
  LEFT JOIN `L0.t_zamestnanci` zam
  ON zak.idzam = zam.idzam
)

SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum, 
    idkontr AS id_kontrakt, 
    null AS id_typ_vydaje, 
    2 AS id_plan_skut, 
    idzam AS id_zam, 
    1 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM p_plan)
UNION ALL 
(WITH p_skutecnost AS (
  SELECT skt.*,
         zam.idzam,
         zam.idpob
  FROM `L0.t_prijmy_skutecnost` skt
  LEFT JOIN `L0.t_kontrakty` kontr
  ON skt.idkontr = kontr.idkontr
  LEFT JOIN `L0.t_zakaznici` zak
  ON zak.idzak = kontr.idzak
  LEFT JOIN `L0.t_zamestnanci` zam
  ON zak.idzam = zam.idzam
)

SELECT 
    GENERATE_UUID() AS id_transakce, 
    idpol AS id_polozka, 
    idpob AS id_pobocka, 
    datum, 
    idkontr AS id_kontrakt, 
    null AS id_typ_vydaje, 
    1 AS id_plan_skut, 
    idzam AS id_zam, 
    1 AS id_tok, 
    null AS id_zdroje, 
    castka
FROM p_skutecnost);

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
    GENERATE_UUID() AS id_polozka, 
    z.idzam AS id_zam, 
    k.idkontr AS id_kontrakt, 
    k.idzak AS id_zak, 
    k.idzdroje AS id_zdroje, 
    f.idvcas AS id_vcas, 
    f.idzaplaceno AS id_zaplaceno, 
    k.datumod AS datum_od, 
    k.datumdo AS datum_do, 
    k.cena_celkem AS cena_kontrakt, 
    s.NPS AS nps, 
    k.naklady_celkem, 
    f.cena_celkem AS cena_faktura
FROM `L0.t_kontrakty` k
JOIN `L0.t_faktury_vydane` f 
ON k.idkontr = f.idkontr AND k.idzak = f.idzak
LEFT JOIN `L0.t_zakaznici` z 
ON k.idzak = z.idzak
LEFT JOIN `L0.t_spokojenost` s 
ON k.idzak = s.idzak AND k.idkontr = s.idkontr;

UPDATE `L1.L1_kontrakt`
SET datum_do =  TIMESTAMP(
              CONCAT(
              CAST(EXTRACT(YEAR FROM datum_do) + 2000 AS STRING),
              SUBSTR(CAST(datum_do AS STRING), 5)
              )
          )
WHERE EXTRACT(YEAR FROM datum_do) <= 22;

UPDATE `L1.L1_kontrakt`
SET datum_od =  TIMESTAMP(
              CONCAT(
              CAST(EXTRACT(YEAR FROM datum_od) + 2000 AS STRING),
              SUBSTR(CAST(datum_od AS STRING), 5)
              )
          )
WHERE EXTRACT(YEAR FROM datum_od) <= 21;


