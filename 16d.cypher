MATCH (an: Aka_name),
      (ci: Cast_info),
      (cn: Company_name),
      (k:  Keyword),
      (mc: Movie_company),
      (n:  Name),
      (t:  Title)
WHERE cn.country_code = '[us]'
  AND k.keyword = 'character-name-in-title'
  AND 5 <= t.episode_nr < 100
MATCH (n)<-[ :NAME_OF ]-(an)-[ :CAST_AS ]->(ci)
MATCH (ci)-[ :CAST_IN ]->(t)
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn) 
RETURN MIN(an.name) AS cool_actor_pseudonym,
       MIN(t.title) AS series_named_after_char; 
