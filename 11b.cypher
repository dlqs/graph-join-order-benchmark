MATCH (cn: Company_name),
      (ct: Company_type),
      (k:  Keyword),
      (lt: Link_type),
      (mc: Movie_company),
      (ml: Movie_link),
      (t:  Title)
WHERE cn.country_code <> '[pl]'
  AND (cn.name =~ '.*Film.*'
       OR cn.name =~ '.*Warner.*')
  AND ct.kind = 'production companies'
  AND k.keyword = 'sequel'
  AND lt.link =~ '.*follows.*'
  AND mc.note IS NULL
  AND t.production_year = 1998
  AND t.title =~ '.*Money.*'
MATCH (t)<-[ :LINKED_FROM ]-(ml)-[ :IS_LINK_TYPE ]->(lt) 
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
RETURN MIN(cn.name) AS from_company,
       MIN(lt.link) AS movie_link_type,
       MIN(t.title) AS sequel_movie;
