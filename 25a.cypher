MATCH (ci:     Cast_info),
      (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title)
WHERE ci.note IN ['(writer)',
                  '(head writer)',
                  '(written by)',
                  '(story)',
                  '(story editor)']
  AND it1.info = 'genres'
  AND it2.info = 'votes'
  AND k.keyword IN ['murder',
                    'blood',
                    'gore',
                    'death',
                    'female-nudity']
  AND mi.info = 'Horror'
  AND n.gender = 'm'
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS male_writer,
       MIN(t.title) AS violent_movie_title;
