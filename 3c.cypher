MATCH (k:  Keyword),
      (mi: Movie_info),
      (t:  Title)
WHERE k.keyword =~ '.*sequel.*'
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
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)
RETURN MIN(t.title) AS movie_title;
