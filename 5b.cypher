MATCH (ct: Company_type),
      (it: Info_type),
      (mc: Movie_company),
      (mi: Movie_info),
      (t:  Title)
WHERE ct.kind = 'production companies'
  AND mc.note =~ '.*(VHS).*'
  AND mc.note =~ '.*(USA).*'
  AND mc.note =~ '.*(1994).*'
  AND mi.info IN ['USA',
                  'America']
  AND t.production_year > 2010
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)-[ :IS_COMPANY_TYPE ]->(ct)
RETURN MIN(t.title) AS american_vhs_movie;
