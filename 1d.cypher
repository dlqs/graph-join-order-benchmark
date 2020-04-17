MATCH (ct:Company_type),
      (it:Info_type),
      (mc:Movie_company),
      (mi_idx:Movie_info_idx),
      (t:Title)
WHERE ct.kind = 'production companies'
  AND it.info = 'bottom 10 rank'
  AND (NOT mc.note =~ '.*(as Metro-Goldwyn-Mayer Pictures).*')
  AND t.production_year > 2000
MATCH (it)<-[ :IS_INFO_TYPE ]-(mi_idx)-[ :MOVIE_INFO_IDX_OF ]->(t)<-[ :MOVIE_COMPANY_OF ]-(mc)
          -[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(mc.note) AS production_note, 
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year;
