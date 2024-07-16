-- zakaznici
CREATE OR REPLACE TABLE L2.L2_zakaznici AS
SELECT zak.id_zak,
       zak.kredit,
       zak.nazev,
       zak.psc,
       zak.mesto,
       kat.nazev AS kategorie,
       kat.sleva
FROM `L1.L1_zakaznik` zak
LEFT JOIN `L1.L1_kategorie_zak` kat 
ON zak.id_kat = kat.id_kat;

-- zamestnanci
CREATE OR REPLACE TABLE L2.L2_zamestnanci AS
SELECT zam.id_zam,
       zam.jmeno,
       zam.prijmeni,
       zam.plat,
       fce.nazev AS funkce,
       fce.ohodnoceni
FROM `L1.L1_zamestnanec` zam
LEFT JOIN `L1.L1_funkce` fce
ON zam.id_fce = fce.id_fce;

-- transakce
CREATE OR REPLACE TABLE L2.L2_transakce AS
SELECT tr.id_polozka,
       IFNULL(CAST(pob.zkratka AS STRING), "(not set)") AS pobocka,
       tr.datum,
       IFNULL(CAST(tr.id_kontrakt AS STRING), "(not set)") AS id_kontrakt,
       IFNULL(vyd.oper, "Příjem") AS typ_vydaje,
       ps.skut as plan_skut,
       IFNULL(CAST(tr.id_zam AS STRING), "(not set)") AS id_zam,
       tok.tok as typ_toku,
       tr.castka,
       IFNULL(zdr.nazev, "(not set)") AS nazev_zdroje,
       IFNULL(CAST(zdr.naklady AS STRING), "(not set)") AS naklady_zdroje,
       IFNULL(CAST(zdr.cena AS STRING), "(not set)") AS cena_zdroje,
       IFNULL(typ.typ,"(not set)") AS typ_zdroje
FROM `L1.L1_transakce` tr
LEFT JOIN `L1.L1_pobocka` pob 
ON tr.id_pobocka = pob.id_pobocka
LEFT JOIN `L1.L1_typ_vydaje` vyd
ON vyd.id_oper = tr.id_typ_vydaje
LEFT JOIN `L1.L1_plan_skut` ps
ON ps.id_skut = tr.id_plan_skut
LEFT JOIN `L1.L1_tok` tok
ON tok.id_tok = tr.id_tok
LEFT JOIN `L1.L1_zdroje` zdr
ON zdr.id_zdroje = tr.id_zdroje
LEFT JOIN `L1.L1_typ_zdroje` typ
ON zdr.id_typ_zdroje = typ.id_typ_zdroje;


-- kontrakty 
CREATE OR REPLACE TABLE L2.L2_kontrakty AS
SELECT kontr.id_zam,
       kontr.id_kontrakt,
       kontr.id_zak,
       zdr.nazev AS nazev_zdroje,
       zdr.naklady AS naklady_zdroje,
       zdr.cena AS cena_zdroje,
       typ.typ AS typ_zdroje,
       vcas.vcas,
       zaplac.zaplaceno,
       kontr.datum_od,
       kontr.datum_do,
       TIMESTAMP_DIFF(kontr.datum_do, kontr.datum_od, DAY) AS datum_rozdil,
       kontr.cena_kontrakt,
       kontr.cena_faktura,
       kontr.naklady_celkem,
       kontr.NPS AS nps
FROM `L1.L1_kontrakt` kontr
LEFT JOIN `L1.L1_vcas` vcas
ON kontr.id_vcas = vcas.id_vcas
LEFT JOIN `L1.L1_zaplaceno` zaplac
ON zaplac.id_zaplaceno = kontr.id_zaplaceno
LEFT JOIN `L1.L1_zdroje` zdr
ON zdr.id_zdroje = kontr.id_zdroje
LEFT JOIN `L1.L1_typ_zdroje` typ
ON zdr.id_typ_zdroje = typ.id_typ_zdroje;
