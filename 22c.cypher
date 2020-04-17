MATCH (cn:     Company_name),
      (ct:     Company_type),
      (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (kt:     Kind_type),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE cn.country_code <> '[us]'
  AND it1.info = 'countries'
  AND it2.info = 'rating'
  AND k.keyword IN ['murder',
                    'murder-in-title',
                    'blood',
                    'violence']
  AND kt.kind IN ['movie',
                  'episode']
  AND NOT mc.note =~ '.*(USA).*'
  AND mc.note =~ '.*(200.*).*'
  AND mi.info IN ['Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Danish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American']
  AND mi_idx.info < '8.5'
  AND t.production_year > 2005
MATCH (t)-[ :IS_KIND_TYPE ]->(kt)
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2) 
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
RETURN MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_violent_movie;
