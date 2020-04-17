MATCH (cc:     Complete_cast),
      (cct1:   Comp_cast_type),
      (cct2:   Comp_cast_type),
      (ci:     Cast_info),
      (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title) 
WHERE cct1.kind = 'cast'
  AND cct2.kind = 'complete+verified'
  AND ci.note IN ['(writer)',
                  '(head writer)',
                  '(written by)',
                  '(story)',
                  '(story editor)']
  AND it1.info = 'genres'
  AND it2.info = 'votes'
  AND k.keyword IN ['murder',
                    'violence',
                    'blood',
                    'gore',
                    'death',
                    'female-nudity',
                    'hospital']
  AND mi.info IN ['Horror',
                  'Action',
                  'Sci-Fi',
                  'Thriller',
                  'Crime',
                  'War']
  AND n.gender = 'm'
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS complete_violent_movie;
