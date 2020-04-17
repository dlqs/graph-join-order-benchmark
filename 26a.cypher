MATCH (cc:     Complete_cast),
      (cct1:   Comp_cast_type),
      (cct2:   Comp_cast_type),
      (chn:    Char_name),
      (ci:     Cast_info),
      (it:     Info_type),
      (k:      Keyword),
      (kt:     Kind_type),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title)
WHERE cct1.kind = 'cast'
  AND cct2.kind =~ '.*complete.*'
  AND chn.name IS NOT NULL
  AND (chn.name =~ '.*man.*'
       OR chn.name =~ '.*Man.*')
  AND it.info = 'rating'
  AND k.keyword IN ['superhero',
                    'marvel-comics',
                    'based-on-comic',
                    'tv-special',
                    'fight',
                    'violence',
                    'magnet',
                    'web',
                    'claw',
                    'laser']
  AND kt.kind = 'movie'
  AND mi_idx.info > '7.0'
  AND t.production_year > 2000
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)
RETURN MIN(chn.name) AS character_name,
       MIN(mi_idx.info) AS rating,
       MIN(n.name) AS playing_actor,
       MIN(t.title) AS complete_hero_movie;
