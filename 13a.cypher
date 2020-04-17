MATCH (cn:     Company_name),
      (ct:     Company_type),
      (it1:    Info_type),
      (it2:    Info_type),
      (kt:     Kind_type),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE cn.country_code = '[de]'
  AND ct.kind = 'production companies'
  AND it1.info = 'rating'
  AND it2.info = 'release dates'
  AND kt.kind = 'movie'
MATCH (mi)-[ :MOVIE_INFO_OF ]->(t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)
MATCH (mi)-[ :IS_INFO_TYPE ]->(it2)
MATCH (mi_idx)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
MATCH (t)-[ :IS_KIND_TYPE ]->(kt)
RETURN MIN(mi.info) AS release_date,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS german_movie;
