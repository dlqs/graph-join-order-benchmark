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
  AND n.gender = 'f'
  AND n.name =~ '.*An.*'
  AND rt.role ='actress'
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
RETURN MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_character_name,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie;
