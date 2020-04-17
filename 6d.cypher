MATCH (ci: Cast_info),
      (k:  Keyword),
      (n:  Name),
      (t:  Title)
WHERE k.keyword IN ['superhero',
                    'sequel',
                    'second-part',
                    'marvel-comics',
                    'based-on-comic',
                    'tv-special',
                    'fight',
                    'violence']
  AND n.name =~ '.*Downey.*Robert.*'
  AND t.production_year > 2000
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS hero_movie; 
