MATCH (ct:     Company_type),
      (it:     Info_type),
      (mc:     Movie_company),
      (t:      Title),
      (mi_idx: Movie_info_idx)
WHERE ct.kind = 'production companies'
  AND it.info = 'top 250 rank'
  AND NOT mc.note =~ '.*(as Metro-Goldwyn-Mayer Pictures).*'
  AND (mc.note =~ '.*(co-production).*'
         OR mc.note =~ '.*(presents).*')
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(mc.note) AS production_note, 
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year;
