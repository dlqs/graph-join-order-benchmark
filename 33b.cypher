MATCH (cn1:     Company_name),
      (cn2:     Company_name),
      (it1:     Info_type),
      (it2:     Info_type),
      (kt1:     Kind_type),
      (kt2:     Kind_type),
      (lt:      Link_type),
      (mc1:     Movie_company),
      (mc2:     Movie_company),
      (mi_idx1: Movie_info_idx),
      (mi_idx2: Movie_info_idx),
      (ml:      Movie_link),
      (t1:      Title),
      (t2:      Title) 
WHERE cn1.country_code = '[nl]'
  AND it1.info = 'rating'
  AND it2.info = 'rating'
  AND kt1.kind IN ['tv series']
  AND kt2.kind IN ['tv series']
  AND lt.link =~ '.*follow.*'
  AND mi_idx2.info < '3.0'
  AND t2.production_year = 2007
MATCH (ml)-[ :IS_LINK_TYPE ]->(lt)
MATCH (t1)<-[ :LINKED_FROM ]-(ml)-[ :LINKED_TO ]->(t2)
MATCH (t1)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx1)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t2)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx2)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t1)-[ :IS_KIND_TYPE ]-(kt1)
MATCH (t2)-[ :IS_KIND_TYPE ]-(kt2)
MATCH (t1)<-[ :MOVIE_COMPANY_OF ]-(mc1)<-[ :COMPANY_NAME_OF ]-(cn1)
MATCH (t2)<-[ :MOVIE_COMPANY_OF ]-(mc2)<-[ :COMPANY_NAME_OF ]-(cn2)
RETURN MIN(cn1.name) AS first_company,
       MIN(cn2.name) AS second_company,
       MIN(mi_idx1.info) AS first_rating,
       MIN(mi_idx2.info) AS second_rating,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie;
