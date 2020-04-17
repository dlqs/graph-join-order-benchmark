MATCH (an: Aka_name),
      (ci: Cast_info),
      (cn: Company_name),
      (mc: Movie_company),
      (n:  Name),
      (rt: Role_type),
      (t:  Title)
WHERE ci.note = '(voice: English version)'
  AND cn.country_code ='[jp]'
  AND mc.note =~ '.*(Japan).*'
  AND NOT mc.note =~ '.*(USA).*'
  AND n.name =~ '.*Yo.*'
  AND NOT n.name =~ '.*Yu.*'
  AND rt.role = 'actress'
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (ci)-[ :IS_ROLE_TYPE ]->(rt)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
RETURN MIN(an.name) AS actress_pseudonym,
       MIN(t.title) AS japanese_movie_dubbed;
