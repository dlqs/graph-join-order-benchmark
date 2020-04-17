MATCH (cn: Company_name),
      (ct: Company_type),
      (k:  Keyword),
      (lt: Link_type),
      (mc: Movie_company),
      (ml: Movie_link),
      (t:  Title)
WHERE cn.country_code <> '[pl]'
  AND (cn.name =~ '20th Century Fox.*'
       OR cn.name =~ 'Twentieth Century Fox.*')
  AND ct.kind <> 'production companies'
  AND ct.kind IS NOT NULL
  AND k.keyword IN ['sequel',
                    'revenge',
                    'based-on-novel']
  AND mc.note IS NOT NULL
  AND t.production_year > 1950
MATCH (t)<-[ :LINKED_FROM ]-(ml)-[ :IS_LINK_TYPE ]->(lt) 
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
RETURN MIN(cn.name) AS from_company,
       MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_based_on_book;
