MATCH (an:  Aka_name),
      (chn: Char_name),
      (ci:  Cast_info),
      (cn:  Company_name),
      (it:  Info_type),
      (mc:  Movie_company),
      (mi:  Movie_info),
      (n:   Name),
      (rt:  Role_type),
      (t:   Title)
WHERE ci.note IN ['(voice)',
                  '(voice: Japanese version)',
                  '(voice) (uncredited)',
                  '(voice: English version)']
  AND cn.country_code = '[us]'
  AND it.info = 'release dates'
  AND mc.note IS NOT NULL
  AND (mc.note =~ '.*(USA).*'
       OR mc.note =~ '.*(worldwide).*')
  AND mi.info IS NOT NULL
  AND (mi.info =~ 'Japan:.*200.*'
       OR mi.info =~ 'USA:.*200.*')
  AND n.gender = 'f'
  AND n.name =~ '.*Ang.*'
  AND rt.role = 'actress'
  AND 2005 <= t.production_year <= 2009
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
RETURN MIN(n.name) AS voicing_actress,
       MIN(t.title) AS voiced_movie;
