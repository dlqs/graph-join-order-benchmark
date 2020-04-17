MATCH (an:  Aka_name),
      (chn: Char_name),
      (ci:  Cast_info),
      (cn:  Company_name),
      (it:  Info_type),
      (k:   Keyword),
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
  AND cn.name = 'DreamWorks Animation'
  AND it.info = 'release dates'
  AND k.keyword IN ['hero',
                    'martial-arts',
                    'hand-to-hand-combat',
                    'computer-animated-movie']
  AND mi.info IS NOT NULL
  AND (mi.info =~ 'Japan:.*201.*'
       OR mi.info =~ 'USA:.*201.*')
  AND n.gender = 'f'
  AND n.name =~ '.*An.*'
  AND rt.role = 'actress'
  AND t.production_year > 2010
  AND t.title =~ 'Kung Fu Panda.*'
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn) 
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n) 
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt) 
RETURN MIN(chn.name) AS voiced_char_name,
       MIN(n.name) AS voicing_actress_name,
       MIN(t.title) AS kung_fu_panda;
