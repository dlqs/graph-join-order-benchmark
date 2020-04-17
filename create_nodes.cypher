// Create nodes
// Note: this is a long-running script

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///aka_name.csv" as row
CREATE (an: Aka_name {
    id: toInteger(row[0]), 
    person_id: toInteger(row[1]),
    name: row[2],
    imdb_index: row[3],
    name_pcode_cf: row[4],
    name_pcode_nf: row[5],
    surname_pcode: row[6],
    md5sum: row[7]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///aka_title.csv" AS row
CREATE (at: Aka_title {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    title: row[2],
    imdb_index: row[3],
    kind_id: toInteger(row[4]),
    production_year: toInteger(row[5]),
    phonetic_code: row[6],
    episode_of_id: toInteger(row[7]),
    season_nr: toInteger(row[8]),
    episode_nr: toInteger(row[9]),
    note: row[10],
    md5sum: row[11]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///cast_info.csv" as row
CREATE (ci: Cast_info {
    id: toInteger(row[0]), 
    person_id: toInteger(row[1]), 
    movie_id: toInteger(row[2]), 
    person_role_id: toInteger(row[3]), 
    note: row[4],
    nr_order: toInteger(row[5]), 
    role_id: toInteger(row[6])
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///char_name.csv" AS row
CREATE (chn: Char_name {
    id: toInteger(row[0]),
    name: row[1],
    imdb_index: row[2],
    imdb_id: toInteger(row[3]),
    name_pcode_nf: row[4],
    surname_pcode: row[5],
    md5sum: row[6]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///comp_cast_type.csv" AS row
CREATE (cct: Comp_cast_type {
    id: toInteger(row[0]),
    kind: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///company_name.csv" AS row
CREATE (cn: Company_name {
    id: toInteger(row[0]),
    name: row[1],
    country_code: row[2],
    imdb_id: toInteger(row[3]),
    name_pcode_nf: row[4],
    name_pcode_sf: row[5],
    md5sum: row[6]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///company_type.csv" AS row
CREATE (ct: Company_type {
    id: toInteger(row[0]),
    kind: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///complete_cast.csv" AS row
CREATE (cc: Complete_cast {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    subject_id: toInteger(row[2]),
    status_id: toInteger(row[3])
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///info_type.csv" AS row
CREATE (it: Info_type {
    id: toInteger(row[0]),
    info: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///keyword.csv" AS row
CREATE (k: Keyword {
    id: toInteger(row[0]),
    keyword: row[1],
    phonetic_code: row[2]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///kind_type.csv" AS row
CREATE (kt: Kind_type {
    id: toInteger(row[0]),
    kind: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///link_type.csv" AS row
CREATE (lt:Link_type {
    id: toInteger(row[0]),
    link: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///movie_companies.csv" AS row
CREATE (mc: Movie_company {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    company_id: toInteger(row[2]),
    company_type_id: toInteger(row[3]),
    note: row[4]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///movie_info.csv" AS row
CREATE (mi: Movie_info {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    info_type_id: toInteger(row[2]),
    info: row[3],
    note: row[4]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///movie_info_idx.csv" AS row
CREATE (mi_idx: Movie_info_idx {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    info_type_id: toInteger(row[2]),
    info: row[3],
    note: row[4]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///movie_link.csv" AS row
CREATE (ml: Movie_link {
    id: toInteger(row[0]),
    movie_id: toInteger(row[1]),
    linked_movie_id: toInteger(row[2]),
    link_type_id: toInteger(row[3])
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///name.csv" AS row
CREATE (n: Name {
    id: toInteger(row[0]),
    name: row[1],
    imdb_index: row[2],
    imdb_id: toInteger(row[3]),
    gender: row[4],
    name_pcode_cf: row[5],
    name_pcode_nf: row[6],
    surname_pcode: row[7],
    md5sum: row[8]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///person_info.csv" AS row
CREATE (pi: Person_info {
    id: toInteger(row[0]),
    person_id: toInteger(row[1]),
    info_type_id: toInteger(row[2]),
    info: row[3],
    note: row[4]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///role_type.csv" AS row
CREATE (rt: Role_type {
    id: toInteger(row[0]),
    role: row[1]
});

USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///title.csv" AS row
CREATE (t: Title {
    id: toInteger(row[0]),
    title: row[1],
    imdb_index: row[2],
    kind_id: toInteger(row[3]),
    production_year: toInteger(row[4]),
    imdb_id: toInteger(row[5]),
    phonetic_code: row[6],
    episode_of_id: toInteger(row[7]),
    season_nr: toInteger(row[8]),
    episode_nr: toInteger(row[9]),
    series_years: row[10],
    md5sum: row[11]
});
