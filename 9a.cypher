MATCH (an:  Aka_name),
      (chn: Char_name),
      (ci:  Cast_info),
      (cn:  Company_name),
      (mc:  Movie_company),
      (n:   Name),
      (rt:  Role_type),
      (t:   Title)
WHERE ci.note IN ['(voice)',
                  '(voice: Japanese version)',
                  '(voice) (uncredited)',
                  '(voice: English version)']
  AND cn.country_code = '[us]'
  AND mc.note IS NOT NULL
  AND (mc.note =~ '.*(USA).*'
       OR mc.note =~ '.*(worldwide).*')
  AND n.gender = 'f'
  AND n.name =~ '.*Ang.*'
  AND rt.role = 'actress'
  AND 2005 <= t.production_year <= 2015
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
RETURN MIN(an.name) AS alternative_name,
       MIN(chn.name) AS character_name,
       MIN(t.title) AS movie;
