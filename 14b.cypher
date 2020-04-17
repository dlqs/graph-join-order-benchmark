MATCH (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (kt:     Kind_type),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE it1.info = 'countries'
  AND it2.info = 'rating'
  AND k.keyword IN ['murder',
                    'murder-in-title']
  AND kt.kind = 'movie'
  AND mi.info IN ['Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American']
  AND mi_idx.info > '6.0'
  AND t.production_year > 2010
  AND (t.title =~ '.*murder.*'
       OR t.title =~ '.*Murder.*'
       OR t.title =~ '.*Mord.*')
MATCH (t)-[ :IS_KIND_TYPE ]->(kt)
MATCH (t)<-[ :KEYWORD_OF ]-(k) 
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
RETURN MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_dark_production;
