MATCH (k:  Keyword),
      (lt: Link_type),
      (ml: Movie_link),
      (t1: Title),
      (t2: Title)
WHERE k.keyword ='character-name-in-title'
MATCH (t1)<-[ :KEYWORD_OF ]-(k)
MATCH (t1)<-[ :LINKED_FROM ]-(ml)-[ :LINKED_TO ]->(t2)
MATCH (ml)-[ :IS_LINK_TYPE ]->(lt)
RETURN MIN(lt.link) AS link_type,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie;
