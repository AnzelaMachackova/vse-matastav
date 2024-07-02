-- Zakaznik
CREATE OR REPLACE TABLE report.zakaznik (
    id_zakaznik INTEGER NOT NULL,
    kredit INTEGER,
    nazev STRING,
    psc INTEGER,
    mesto STRING,
    okres STRING,
    kraj STRING,
    id_kategorie_zak INTEGER,
);

-- Kategorie zakaznika
CREATE OR REPLACE TABLE report.kategorie_zak (
    id_kategorie_zak INTEGER NOT NULL,
    nazev STRING,
    sleva FLOAT64
);

-- Vcas
CREATE OR REPLACE TABLE report.vcas (
    id_vcas INTEGER NOT NULL,
    nazev STRING
);

-- Zaplaceno
CREATE OR REPLACE TABLE report.kategorie_zak (
    id_zaplaceno INTEGER NOT NULL,
    nazev STRING 
);

-- Pobocka
CREATE OR REPLACE TABLE report.pobocka (
    id_pobocka INTEGER NOT NULL,
    nazev STRING,
    mesto STRING,
    najem FLOAT64
);


-- Kontrakt
CREATE OR REPLACE TABLE report.f_kontrakt (
    id_polozky STRING NOT NULL,
    id_kontrakt INTEGER NOT NULL, -- k.idkontr
    id_zamestnanec INTEGER, -- z.idzam -> propojit podle idzak 
    id_zakaznik INTEGER, -- k.idzak
    id_zdroj INTEGER, -- k.idzdroje
    id_vcas INTEGER, -- f.idvcas
    id_zaplaceno INTEGER, -- f.idzaplaceno
    datum_od_kontraktu TIMESTAMP, --k.datumod
    datum_do_kontraktu TIMESTAMP, --k.datumdo
    nps INTEGER, -- s.NPS -> propojit podle s.idzak a s.idkontr
    cena_kontrakt FLOAT64, --k.cena_celkem
    naklady_kontrakt FLOAT64,
    cena_faktura FLOAT64 --f.cena_celkem
);

-- Zamestnanec
CREATE OR REPLACE TABLE report.zamestnanec (
    id_zamestnanec INTEGER NOT NULL,
    prijmeni STRING,
    jmeno STRING,
    plat INTEGER,
    id_funkce INTEGER
);

-- Funkce
CREATE OR REPLACE TABLE report.funkce (
    id_funkce INTEGER NOT NULL,
    nazev STRING,
    ohodnoceni INTEGER
);

-- Datum
CREATE OR REPLACE TABLE report.datum (
    id_datum STRING NOT NULL,
    rok INT,
    mesic INT,
    den INT
);

-- Transakce
CREATE OR REPLACE TABLE report.f_transakce (
    id_transakce STRING NOT NULL,
    id_pol INTEGER NOT NULL,
    id_pobocka INTEGER,
    datum TIMESTAMP,
    id_kontrakt INTEGER,
    id_typ_vydaje INTEGER,
    id_plan_skut INTEGER,
    id_zamestnanec INTEGER,
    id_tok INTEGER,
    id_zdroje INTEGER,
    castka FLOAT64
);

-- Typ Vydaje
CREATE OR REPLACE TABLE report.typ_vydaje (
    id_typ_vydaje INTEGER NOT NULL,
    nazev STRING
);

-- Typ Zdroje
CREATE OR REPLACE TABLE report.typ_zdroje (
    id_typ_zdroje INTEGER NOT NULL,
    nazev STRING
);

-- Zdroje
CREATE OR REPLACE TABLE report.zdroje (
    id_zdroje INTEGER NOT NULL,
    nazev STRING,
    naklady_den FLOAT64,
    cena_den FLOAT64,
    id_typ_zdroje INTEGER
);

-- Plan/Skut
CREATE OR REPLACE TABLE report.plan_skut (
    id_plan_skut INTEGER NOT NULL,
    nazev STRING
);

-- Tok
CREATE OR REPLACE TABLE report.tok (
    id_tok INTEGER NOT NULL,
    nazev STRING
);
