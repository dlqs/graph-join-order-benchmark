MATCH (cc:   Complete_cast),
      (cct1: Comp_cast_type),
      (cct2: Comp_cast_type),
      (cn:   Company_name),
      (ct:   Company_type),
      (k:    Keyword),
      (lt:   Link_type),
      (mc:   Movie_company),
      (mi:   Movie_info),
      (ml:   Movie_link),
      (t:    Title)
WHERE cct1.kind IN ['cast',
                    'crew']
  AND cct2.kind = 'complete'
  AND cn.country_code <> '[pl]'
  AND (cn.name =~ '.*Film.*'
       OR cn.name =~ '.*Warner.*')
  AND ct.kind = 'production companies'
  AND k.keyword = 'sequel'
  AND lt.link =~ '.*follow.*'
  AND mc.note IS NULL
  AND mi.info IN ['Sweden',
                  'Germany',
                  'Swedish',
                  'German']
  AND 1950 <= t.production_year <= 2000
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :LINKED_FROM ]-(ml)-[ :IS_LINK_TYPE ]->(lt)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
MATCH (mi)-[ :MOVIE_INFO_OF ]->(t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(cn.name) AS producing_company,
       MIN(lt.link) AS link_type,
       MIN(t.title) AS complete_western_sequel;
