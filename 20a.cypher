MATCH (cc:   Complete_cast),
      (cct1: Comp_cast_type),
      (cct2: Comp_cast_type),
      (chn:  Char_name),
      (ci:   Cast_info),
      (k:    Keyword),
      (kt:   Kind_type),
      (n:    Name),
      (t:    Title)
WHERE cct1.kind = 'cast'
  AND cct2.kind =~ '.*complete.*'
  AND NOT chn.name =~ '.*Sherlock.*'
  AND (chn.name =~ '.*Tony.*Stark.*'
       OR chn.name =~ '.*Iron.*Man.*')
  AND k.keyword IN ['superhero',
                    'sequel',
                    'second-part',
                    'marvel-comics',
                    'based-on-comic',
                    'tv-special',
                    'fight',
                    'violence']
  AND kt.kind = 'movie'
  AND t.production_year > 1950
MATCH (kt)<-[ :IS_KIND_TYPE ]-(t)<-[ :KEYWORD_OF ]-(k)
MATCH (ci)-[ :CAST_IN ]->(t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
MATCH (chn)-[ :CHAR_IN ]->(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(t.title) AS complete_downey_ironman_movie;
