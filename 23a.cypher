MATCH (cc:  Complete_cast),
      (cct: Comp_cast_type),
      (cn:  Company_name),
      (ct:  Company_type),
      (it:  Info_type),
      (k:   Keyword),
      (kt:  Kind_type),
      (mc:  Movie_company),
      (mi:  Movie_info),
      (t:   Title)
WHERE cct.kind = 'complete+verified'
  AND cn.country_code = '[us]'
  AND it.info = 'release dates'
  AND kt.kind IN ['movie']
  AND mi.note =~ '.*internet.*'
  AND mi.info IS NOT NULL
  AND (mi.info =~ 'USA:.* 199.*'
       OR mi.info =~ 'USA:.* 200.*')
  AND t.production_year > 2000
MATCH (t)-[ :IS_KIND_TYPE ]->(kt)
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(kt.kind) AS movie_kind,
       MIN(t.title) AS complete_us_internet_movie;
