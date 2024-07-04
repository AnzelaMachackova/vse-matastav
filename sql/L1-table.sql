-- funkce
CREATE OR REPLACE TABLE L2.funkce AS
SELECT idfce, nazev, ohodnoceni
FROM L1.t_funkce;

-- kategorie_zak
CREATE OR REPLACE TABLE L2.kategorie_zak AS
SELECT idkat, Nazev, Sleva
FROM L1.t_kategorie_zakazniku;

-- plan_skut
CREATE OR REPLACE TABLE L2.plan_skut AS
VALUES
(1, 'skutecnost'),
(2, 'plan');

-- pobocka
CREATE OR REPLACE TABLE L2.pobocka AS
SELECT idpob, Nazev, Mesto, Najem
FROM L1.t_pobocky;

-- tok
CREATE OR REPLACE TABLE L2.tok AS
SELECT idtok, tok
FROM L1.pomTok;

-- typ vydaje
CREATE OR REPLACE TABLE L2.typ_vydaje AS
VALUES
(1, 'najem'),
(2, 'zdroje'),
(3, 'mzdy'),
(4, 'osobni'),
(5, 'rezie');

-- typ zdroje
CREATE OR REPLACE TABLE L2.typ_zdroje AS
SELECT idtypzdroje, Typ
FROM L1.t_typy_zdroju;

-- vcas
CREATE OR REPLACE TABLE L2.vcas AS
SELECT idvcas, vcas
FROM L1.pomVcas;

-- zdroje
CREATE OR REPLACE TABLE L2.zdroje AS
SELECT idzdroje, Nazev, naklady, cena, idtypzdroje
FROM L1.t_zdroje;

-- zakaznik - chybi tu okres, kraj dle číselníku
CREATE OR REPLACE TABLE L2.zakaznik AS
SELECT idzak, Kredit, Nazev, PSC, Mesto, idkat
FROM L1.t_zakaznici;

-- zamestnanec
CREATE OR REPLACE TABLE L2.zamestnanec AS
SELECT idzam, Prijmeni, Jmeno, Plat, idfce
FROM L1.t_zamestnanci;

-- transakce
-- vydaje
CREATE OR REPLACE TABLE L2.L2_transakce AS
-- mzdy
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 3 as id_typ_vydaje, 2 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_mzdy_plan
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 3 as id_typ_vydaje, 1 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_mzdy_skutecnost
UNION ALL
-- najem
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 1 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_najem_skutecnost
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 1 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_najem_plan
-- osobni
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 4 as id_typ_vydaje, 2 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_osobni_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 4 as id_typ_vydaje, 1 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_osobni_skutecnost
-- rezie 
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_rezie_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM L1.t_vydaje_rezie_skutecnost
-- zdroje
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, idkontr, 2 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, idzdroje, castka
FROM L1.t_vydaje_zdroje_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, idkontr, 2 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, idzdroje, castka
FROM L1.t_vydaje_zdroje_skutecnost
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, idkontr, null as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 1 as id_tok, null as idzdroje, castka
FROM L1.t_prijmy_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, idkontr, 2 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 1 as id_tok, null as idzdroje, castka
FROM L1.t_prijmy_skutecnost;

-- kontrakt
CREATE OR REPLACE TABLE L2.L2_kontrakt AS
SELECT GENERATE_UUID() as id_polozky, z.idzam, k.idkontr, k.idzak, k.idzdroje, f.idvcas, f.idzaplaceno, k.datumod, k.datumdo, k.cena_celkem, s.NPS, k.naklady_celkem, f.cena_celkem
FROM L1.t_kontrakty k
JOIN L1.t_faktury_vydane f ON k.idkontr = f.idkontr AND k.idzak = f.idzak
LEFT JOIN L1.t_zakaznici z ON k.idzak = z.idzak
LEFT JOIN L1.t_spokojenost s ON k.idzak = s.idzak AND k.idkontr = s.idkontr;


