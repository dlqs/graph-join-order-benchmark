MATCH (cn:     Company_name),
      (ct:     Company_type),
      (it1:    Info_type),
      (it2:    Info_type),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE cn.country_code = '[us]'
  AND ct.kind IS NOT NULL
  AND (ct.kind = 'production companies'
       OR ct.kind = 'distributors')
  AND it1.info = 'budget'
  AND it2.info = 'bottom 10 rank'
  AND t.production_year > 2000
  AND (t.title =~ 'Birdemic.*'
       OR t.title =~ '.*Movie.*')
MATCH (mi)-[ :MOVIE_INFO_OF ]->(t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)
MATCH (mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
RETURN MIN(mi.info) AS budget,
       MIN(t.title) AS unsuccsessful_movie;
