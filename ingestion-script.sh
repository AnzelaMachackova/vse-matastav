# script for creating tables in BigQuery from bucket
BUCKET_NAME="vse-matastav-bucket"
DATASET="L0"

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
    "pomTok"
    "t_prijmy_skutecnost"
    "t_zdroje"
    "t_Kraje"
    "pomVcas"
    "t_vydaje_mzdy_plan"
)

array_length=${#tables[@]}

for (( i=0; i<${array_length}; i++ )); do
    table=${tables[i]}
    echo "Loading data into $DATASET.$table from gs://$BUCKET_NAME/raw/${table}.csv"
    bq load --autodetect --source_format=CSV "$DATASET.$table" "gs://$BUCKET_NAME/raw/${table}.csv"
done

# 
BUCKET_NAME="vse-matastav-bucket"

bq load \
--source_format=CSV \
--skip_leading_rows=1 \
--schema="idzam:INTEGER,Prijmeni:STRING,Jmeno:STRING,Titul:STRING,Plat:INTEGER,Nadrizeny:INTEGER,idpob:INTEGER,idfce:INTEGER,foto:STRING" \
L0.t_zamestnanci \
"gs://$BUCKET_NAME/raw/t_zamestnanci.csv"