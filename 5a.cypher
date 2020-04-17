MATCH (ct: Company_type),
      (it: Info_type),
      (mc: Movie_company),
      (mi: Movie_info),
      (t:  Title)
WHERE ct.kind = 'production companies'
  AND mc.note =~ '.*(theatrical).*'
  AND mc.note =~ '.*(France).*'
  AND mi.info IN ['Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German']
  AND t.production_year > 2005
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(t.title) AS typical_european_movie;
