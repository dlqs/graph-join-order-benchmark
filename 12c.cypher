MATCH (cn:     Company_name),
      (ct:     Company_type),
      (it1:    Info_type),
      (it2:    Info_type),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE cn.country_code = '[us]'
  AND ct.kind = 'production companies'
  AND it1.info = 'genres'
  AND it2.info = 'rating'
  AND mi.info IN ['Drama',
                  'Horror',
                  'Western',
                  'Family']
  AND mi_idx.info > '7.0'
  AND 2000 <= t.production_year <= 2010
MATCH (mi)-[ :MOVIE_INFO_OF ]->(t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)
MATCH (mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
RETURN MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS mainstream_movie;
