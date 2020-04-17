MATCH (an:   Aka_name),
      (cc:   Complete_cast),
      (cct1: Comp_cast_type),
      (cct2: Comp_cast_type),
      (chn:  Char_name),
      (ci:   Cast_info),
      (cn:   Company_name),
      (it1:  Info_type),
      (it2:  Info_type),
      (k:    Keyword),
      (mc:   Movie_company),
      (mi:   Movie_info),
      (n:    Name),
      (pi:   Person_info),
      (rt:   Role_type),
      (t:    Title)
WHERE cct1.kind = 'cast'
  AND cct2.kind = 'complete+verified'
  AND chn.name = 'Queen'
  AND ci.note IN ['(voice)',
                  '(voice) (uncredited)',
                  '(voice: English version)']
  AND cn.country_code = '[us]'
  AND it1.info = 'release dates'
  AND it2.info = 'trivia'
  AND k.keyword = 'computer-animation'
  AND mi.info IS NOT NULL
  AND (mi.info =~ 'Japan:.*200.*'
       OR mi.info =~ 'USA:.*200.*')
  AND n.gender = 'f'
  AND n.name =~ '.*An.*'
  AND rt.role = 'actress'
  AND t.title = 'Shrek 2'
  AND 2000 <= t.production_year <= 2010
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)<-[ :COMPANY_NAME_OF ]-(cn)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (chn)-[ :CHAR_IN ]->(ci)-[ :IS_ROLE_TYPE ]->(rt)
MATCH (n)<-[ :PERSON_INFO_OF ]-(pi)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
RETURN MIN(chn.name) AS voiced_char,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS voiced_animation;
