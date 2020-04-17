MATCH (ci:     Cast_info),
      (cn:     Company_name),
      (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title)
WHERE ci.note IN ['(writer)',
                  '(head writer)',
                  '(written by)',
                  '(story)',
                  '(story editor)']
  AND cn.name =~ 'Lionsgate.*'
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
                  'Thriller']
  AND n.gender = 'm'
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
RETURN MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS violent_liongate_movie;
