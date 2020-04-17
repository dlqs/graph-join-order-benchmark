MATCH (ci: Cast_info),
      (k:  Keyword),
      (n:  Name),
      (t:  Title)
WHERE k.keyword = 'marvel-cinematic-universe'
  AND n.name =~ '.*Downey.*Robert.*'
  AND t.production_year > 2010
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS marvel_movie;
