MATCH (ct: Company_type),
      (it: Info_type),
      (mc: Movie_company),
      (mi: Movie_info),
      (t:  Title)
WHERE ct.kind = 'production companies'
  AND (NOT mc.note =~ '.*(TV).*')
  AND mc.note =~ '.*(USA).*'
  AND mi.info IN ['Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American']
  AND t.production_year > 1990
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(t.title) AS american_movie;
