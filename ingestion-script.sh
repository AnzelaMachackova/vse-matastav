# script for creating external tables in BigQuery from Google Sheets
bq mkdef \
   --autodetect \
   --source_format='GOOGLE_SHEETS' \
   'https://docs.google.com/spreadsheets/d/id' > /tmp/t_kontrakty_test

bq mk \
--external_table_definition=/tmp/t_kontrakty_test \
L0.t_kontrakty_test

# script for creating external tables in BigQuery from multiple Google Sheets 
DATASET="L0"

declare -a sheets=(
    "https://docs.google.com/spreadsheets/d/id1"
    "https://docs.google.com/spreadsheets/d/id2"
    "https://docs.google.com/spreadsheets/d/id3"
)

declare -a tables=(
    "t_kontrakty"
    "t_kategorie_zakazniku"
    "t_faktury_vydane"
    "t_vydaje_zdroje_skutecnost"
    "t_zakaznici"
    "t_prijmy_plan"
    "pomZaplaceno"
    "t_PSC"
    "t_vydaje_osobni_skutecnost"
    "t_pomden"
    "t_Okresy"
    "t_funkce"
    "t_typy_zdroju"
    "t_pobocky"
    "t_vydaje_rezie_skutecnost"
    "t_ukoly"
    "pomSkut"
    "t_spokojenost"
    "t_vydaje_rezie_plan"
    "t_vydaje_mzdy_skutecnost"
    "t_vydaje_osobni_plan"
    "pomOper"
    "t_vydaje_najem_skutecnost"
    "t_vydaje_najem_plan"
    "t_vydaje_zdroje_plan"
    "pomMesic"
    "pomTok"
    "t_prijmy_skutecnost"
    "t_zdroje"
    "t_Kraje"
    "pomVcas"
    "t_vydaje_mzdy_plan"
    "t_zamestnanci"
)

array_length=${#sheets[@]}

for (( i=0; i<${array_length}; i++ )); do
    bq mkdef --autodetect --source_format='GOOGLE_SHEETS' "${sheets[$i]}" > "/tmp/${tables[$i]}_def"
    
    bq mk --external_table_definition="/tmp/${tables[$i]}_def" "${DATASET}.${tables[$i]}"
done

