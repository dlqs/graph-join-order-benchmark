MATCH (an: Aka_name),
      (ci: Cast_info),
      (cn: Company_name),
      (mc: Movie_company),
      (n:  Name),
      (rt: Role_type),
      (t:  Title)
WHERE cn.country_code = '[us]'
  AND rt.role = 'costume designer'
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (ci)-[ :IS_ROLE_TYPE ]->(rt)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
RETURN MIN(an.name) AS costume_designer_pseudo,
       MIN(t.title) AS movie_with_costumes;
