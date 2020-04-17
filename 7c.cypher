MATCH (an: Aka_name),
      (ci: Cast_info),
      (it: Info_type),
      (lt: Link_type),
      (ml: Movie_link),
      (n:  Name),
      (pi: Person_info),
      (t:  Title)
WHERE an.name IS NOT NULL
  AND (an.name =~ '.*a.*'
       OR an.name =~ 'A.*')
  AND it.info = 'mini biography'
  AND lt.link IN ['references',
                  'referenced in',
                  'features',
                  'featured in']
  AND 'A' <= n.name_pcode_cf <= 'F'
  AND (n.gender = 'm'
       OR (n.gender = 'f'
           AND n.name =~ 'A.*'))
  AND pi.note IS NOT NULL
  AND 1980 <= t.production_year <= 2010
MATCH (t)<-[ :LINKED_TO ]-(ml)-[ :IS_LINK_TYPE ]->(lt)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (n)<-[ :PERSON_INFO_OF ]-(pi)-[ :IS_INFO_TYPE ]->(it)
RETURN MIN(n.name) AS cast_member_name;
       MIN(pi.info) AS cast_member_info;
