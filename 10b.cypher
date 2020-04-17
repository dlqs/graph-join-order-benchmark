// NULL
MATCH (chn: Char_name),
      (ci:  Cast_info),
      (cn:  Company_name),
      (ct:  Company_type),
      (mc:  Movie_company),
      (rt:  Role_type),
      (t:   Title)
WHERE ci.note =~ '.*(producer).*'
  AND cn.country_code = '[ru]'
  AND rt.role = 'actor'
  AND t.production_year > 2010
MATCH (ci)-[ :CAST_IN ]->(t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
RETURN MIN(chn.name) AS character,
       MIN(t.title) AS russian_mov_with_actor_producer;
