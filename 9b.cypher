MATCH (an:  Aka_name),
      (chn: Char_name),
      (ci:  Cast_info),
      (cn:  Company_name),
      (mc:  Movie_company),
      (n:   Name),
      (rt:  Role_type),
      (t:   Title)
WHERE ci.note = '(voice)'
  AND cn.country_code = '[us]'
  AND mc.note =~ '.*(200.*).*'
  AND (mc.note =~ '.*(USA).*'
       OR mc.note =~ '.*(worldwide).*')
  AND n.gender ='f'
  AND n.name =~ '.*Angel.*'
  AND rt.role ='actress'
  AND 2007 <= t.production_year <= 2010
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
RETURN MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_character,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie;
