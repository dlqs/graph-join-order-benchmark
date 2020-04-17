MATCH (it:     Info_type),
      (k:      Keyword),
      (mi_idx: Movie_info_idx),
      (t:      Title)
WHERE k.keyword =~ '.*sequel.*'
  AND it.info = 'rating'
  AND mi_idx.info > '9.0'
  AND t.production_year > 2010
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it)
RETURN MIN(mi_idx.info) AS rating,
       MIN(t.title) AS movie_title;
