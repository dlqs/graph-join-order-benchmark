MATCH (ci: Cast_info),
      (cn: Company_name),
      (k:  Keyword),
      (mc: Movie_company),
      (n:  Name),
      (t:  Title)
WHERE cn.country_code = '[us]'
  AND k.keyword = 'character-name-in-title'
  AND n.name =~ 'B.*'
MATCH (n)<-[ :NAME_OF ]-(:Aka_name)-[ :CAST_AS ]->(ci)
MATCH (ci)-[ :CAST_IN ]->(t)
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn) 
RETURN MIN(n.name) AS member_in_charnamed_american_movie,
       MIN(n.name) AS a1;
