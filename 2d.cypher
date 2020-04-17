MATCH (cn:Company_name),
      (k:Keyword),
      (mc:Movie_company),
      (t:Title)
WHERE cn.country_code ='[us]'
  AND k.keyword ='character-name-in-title'
MATCH (k)-[ :KEYWORD_OF ]->(t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
RETURN MIN(t.title) AS movie_title;
