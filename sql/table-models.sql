-- funkce
INSERT INTO report.funkce (id_funkce, nazev, ohodnoceni)
SELECT idfce, nazev, ohodnoceni
FROM stage.t_funkce;

-- kategorie_zak
INSERT INTO report.kategorie_zak (id_kategorie_zak, nazev, sleva)
SELECT idkat, Nazev, Sleva
FROM stage.t_kategorie_zakazniku;

-- plan_skut
INSERT INTO report.plan_skut (id_plan_skut, nazev)
VALUES
(1, 'skutecnost'),
(2, 'plan');

-- pobocka
INSERT INTO report.pobocka (id_pobocka, nazev, mesto, najem)
SELECT idpob, Nazev, Mesto, Najem
FROM stage.t_pobocky;

-- tok
INSERT INTO report.tok (id_tok, nazev)
SELECT idtok, tok
FROM stage.pomTok;

-- typ vydaje
INSERT INTO report.typ_vydaje (id_typ_vydaje, nazev)
VALUES
(1, 'najem'),
(2, 'zdroje'),
(3, 'mzdy'),
(4, 'osobni'),
(5, 'rezie');

-- typ zdroje
INSERT INTO report.typ_zdroje (id_typ_zdroje, nazev)
SELECT idtypzdroje, Typ
FROM stage.t_typy_zdroju;

-- vcas
INSERT INTO report.vcas (id_vcas, nazev)
SELECT idvcas, vcas
FROM stage.pomVcas;

-- zdroje
INSERT INTO report.zdroje (id_zdroje, nazev, naklady_den, cena_den, id_typ_zdroje)
SELECT idzdroje, Nazev, naklady, cena, idtypzdroje
FROM stage.t_zdroje;

-- zakaznik - chybi tu okres, kraj dle číselníku
INSERT INTO report.zakaznik (id_zakaznik, kredit, nazev, psc, mesto, id_kategorie_zak)
SELECT idzak, Kredit, Nazev, PSC, Mesto, idkat
FROM stage.t_zakaznici;


-- zamestnanec
INSERT INTO report.zamestnanec (id_zamestnanec, prijmeni, jmeno, plat, id_funkce)
SELECT idzam, Prijmeni, Jmeno, Plat, idfce
FROM stage.t_zamestnanci;

-- f_transakce
-- vydaje
INSERT INTO report.f_transakce (id_transakce, id_pol, id_pobocka, datum, id_kontrakt, id_typ_vydaje, id_plan_skut, id_zamestnanec, id_tok, id_zdroje, castka)
--mzdy
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 3 as id_typ_vydaje, 2 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_mzdy_plan
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as id_pobocka, datum, null as id_kontrakt, 3 as id_typ_vydaje, 1 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_mzdy_skutecnost
UNION ALL
-- najem
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 1 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_najem_skutecnost
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, idpob, datum, null as id_kontrakt, 1 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_najem_plan
-- osobni
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 2 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_osobni_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 1 as id_plan_skut, idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_osobni_skutecnost
-- rezie 
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_rezie_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, null as id_kontrakt, 4 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, null as id_zdroje, castka
FROM stage.t_vydaje_rezie_skutecnost
-- zdroje
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, idkontr, 2 as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 2 as id_tok, idzdroje, castka
FROM stage.t_vydaje_zdroje_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, idkontr, 2 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 2 as id_tok, idzdroje, castka
FROM stage.t_vydaje_zdroje_skutecnost
UNION ALL
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, idkontr, null as id_typ_vydaje, 2 as id_plan_skut, null as idzam, 1 as id_tok, null as idzdroje, castka
FROM stage.t_prijmy_plan
UNION ALL 
SELECT GENERATE_UUID() as id_transakce, idpol, null as idpob, datum, idkontr, 2 as id_typ_vydaje, 1 as id_plan_skut, null as idzam, 1 as id_tok, null as idzdroje, castka
FROM stage.t_prijmy_skutecnost
;

-- f_kontrakt
INSERT INTO report.f_kontrakt (id_polozky, id_zamestnanec, id_kontrakt, id_zakaznik, id_zdroj, id_vcas, id_zaplaceno, datum_od_kontraktu, datum_do_kontraktu,cena_kontrakt, nps, naklady_kontrakt, cena_faktura)
SELECT GENERATE_UUID() as id_polozky, z.idzam, k.idkontr, k.idzak, k.idzdroje, f.idvcas, f.idzaplaceno, k.datumod, k.datumdo, k.cena_celkem, s.NPS, k.naklady_celkem, f.cena_celkem
FROM stage.t_kontrakty k
JOIN stage.t_faktury_vydane f ON k.idkontr = f.idkontr AND k.idzak = f.idzak
LEFT JOIN stage.t_zakaznici z ON k.idzak = z.idzak
LEFT JOIN stage.t_spokojenost s ON k.idzak = s.idzak AND k.idkontr = s.idkontr
; 
