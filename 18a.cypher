MATCH (ci:     Cast_info),
      (it1:    Info_type),
      (it2:    Info_type),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title)
WHERE ci.note IN ['(producer)',
                  '(executive producer)']
  AND it1.info = 'budget'
  AND it2.info = 'votes'
  AND n.gender = 'm'
  AND n.name =~ '.*Tim.*'
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(t.title) AS movie_title;
