-- zakaznici
CREATE OR REPLACE TABLE L2.L2_zakaznici AS
SELECT zak.idzak,
       zak.kredit,
       zak.nazev,
       zak.psc,
       zak.mesto,
       kat.nazev as kategorie,
       kat.sleva
FROM `L1.L1_zakaznik` zak
LEFT JOIN `L1.L1_kategorie_zak` kat 
ON zak.idkat = kat.idkat;

-- zamestnanci
CREATE OR REPLACE TABLE L2.L2_zamestnanci AS
SELECT zam.idzam,
       zam.jmeno,
       zam.prijmeni,
       zam.plat,
       fce.nazev as funkce,
       fce.ohodnoceni
FROM `L1.L1_zamestnanec` zam
LEFT JOIN `L1.L1_funkce` fce
ON zam.idfce = fce.idfce;

-- transakce
CREATE OR REPLACE TABLE L2.L2_transakce AS
SELECT tr.idpol,
       IFNULL(CAST(tr.id_pobocka AS STRING), "(not set)") as id_pobocka,
       tr.datum,
       IFNULL(CAST(tr.id_kontrakt AS STRING), "(not set)") as id_kontrakt,
       IFNULL(vyd.oper, "Příjem") as typ_vydaje,
       ps.skut as plan_skut,
       IFNULL(CAST(tr.idzam AS STRING), "(not set)") as id_zam,
       tok.tok as typ_toku,
       tr.castka,
       IFNULL(zdr.nazev, "(not set)") as nazev_zdroje,
       IFNULL(CAST(zdr.naklady AS STRING), "(not set)") as naklady_zdroje,
       IFNULL(CAST(zdr.cena AS STRING), "(not set)") as cena_zdroje,
       IFNULL(typ.typ,"(not set)") as typ_zdroje
FROM `L1.L1_transakce` tr
LEFT JOIN `L1.L1_pobocka` pob 
ON tr.id_pobocka = pob.idpob
LEFT JOIN `L1.L1_typ_vydaje` vyd
ON vyd.idoper = tr.id_typ_vydaje
LEFT JOIN `L1.L1_plan_skut` ps
ON ps.idskut = tr.id_plan_skut
LEFT JOIN `L1.L1_tok` tok
ON tok.idtok = tr.id_tok
LEFT JOIN `L1.L1_zdroje` zdr
ON zdr.idzdroje = tr.id_zdroje
LEFT JOIN `L1.L1_typ_zdroje` typ
ON zdr.idtypzdroje = typ.idtypzdroje;


-- kontrakty 
CREATE OR REPLACE TABLE L2.L2_kontrakty AS
SELECT kontr.idzam,
       kontr.idkontr,
       kontr.idzak,
       zdr.nazev as nazev_zdroje,
       zdr.naklady as naklady_zdroje,
       zdr.cena as cena_zdroje,
       typ.typ as typ_zdroje,
       vcas.vcas,
       zaplac.zaplaceno,
       kontr.datumod as datum_od,
       kontr.datumdo as datum_do,
       TIMESTAMP_DIFF(kontr.datumdo, kontr.datumod, DAY) AS datum_rozdil,
       kontr.cena_kontrakt,
       kontr.cena_faktura,
       kontr.naklady_celkem,
       kontr.NPS as nps
FROM `L1.L1_kontrakt` kontr
LEFT JOIN `L1.L1_vcas` vcas
ON kontr.idvcas = vcas.idvcas
LEFT JOIN `L1.L1_zaplaceno` zaplac
ON zaplac.idzaplaceno = kontr.idzaplaceno
LEFT JOIN `L1.L1_zdroje` zdr
ON zdr.idzdroje = kontr.idzdroje
LEFT JOIN `L1.L1_typ_zdroje` typ
ON zdr.idtypzdroje = typ.idtypzdroje;
