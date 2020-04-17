// Create relationships
// Note: batchSize is adjustable

// movie_keyword can be converted entirely into a relationship 
// (it's the only entity that can do so since it has no other attributes)
USING PERIODIC COMMIT 10000
LOAD CSV FROM "file:///movie_keyword.csv" AS row
MATCH (k:Keyword), (t:Title)
    WHERE k.id = toInteger(row[2]) 
    AND t.id = toInteger(row[1])
CREATE (k)-[ :KEYWORD_OF ]->(t);

CALL apoc.periodic.iterate(
    "MATCH (at:Aka_title), (t:Title)
     WHERE at.movie_id = t.id
     RETURN at, t",
    "CREATE (at)-[ :KNOWN_AS ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (cc:Complete_cast), (t:Title)
     WHERE cc.movie_id = t.id
     RETURN cc, t",
    "CREATE (cc)-[ :COMPLETE_CAST_OF ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (cc:Complete_cast), (cct:Comp_cast_type)
     WHERE cc.subject_id = cct.id
     RETURN cc, cct",
    "CREATE (cc)-[ :IS_SUBJECT_CAST_TYPE ]->(cct)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (cc:Complete_cast), (cct:Comp_cast_type)
     WHERE cc.status_id = cct.id
     RETURN cc, cct",
    "CREATE (cc)-[ :IS_STATUS_CAST_TYPE ]->(cct)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ml:Movie_link), (t:Title), (t2:Title)
     USING SCAN ml:Movie_link
     WHERE ml.movie_id = t.id AND ml.linked_movie_id = t2.id
     RETURN ml, t, t2",
    "CREATE (t)<-[ :LINKED_FROM ]-(ml)-[ :LINKED_TO ]->(t2)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ml:Movie_link), (lt:Link_type)
     WHERE ml.link_type_id = lt.id
     RETURN ml, lt",
    "CREATE (ml)-[ :IS_LINK_TYPE ]->(lt)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ci:Cast_info), (t:Title)
     WHERE ci.movie_id = t.id
     RETURN ci, t",
    "CREATE (ci)-[ :CAST_IN ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (chn:Char_name), (ci:Cast_info)
     WHERE chn.id = ci.person_role_id
     RETURN chn, ci",
    "CREATE (chn)-[ :CHAR_IN ]->(ci)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ci:Cast_info), (rt:Role_type)
     USING SCAN ci:Cast_info
     WHERE ci.role_id = rt.id
     RETURN ci, rt",
    "CREATE (ci)-[ :IS_ROLE_TYPE ]->(rt)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (an:Aka_name), (ci:Cast_info)
     USING SCAN an:Aka_name
     WHERE an.person_id = ci.person_id
     RETURN an, ci",
    "CREATE (an)-[ :CAST_AS ]->(ci)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (an:Aka_name), (n:Name)
     USING SCAN n:Name
     WHERE n.id = an.person_id
     RETURN n, an",
    "CREATE (an)-[ :NAME_OF ]->(n)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (n:Name), (pi:Person_info)
     USING SCAN pi:Person_info
     WHERE pi.person_id = n.id
     RETURN pi, n",
    "CREATE (pi)-[ :PERSON_INFO_OF ]->(n)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (pi:Person_info), (it:Info_type)
     USING SCAN pi:Person_info
     WHERE pi.info_type_id = it.id
     RETURN pi, it",
    "CREATE (pi)-[ :IS_INFO_TYPE ]->(it)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mi:Movie_info), (t:Title)
     USING SCAN mi:Movie_info
     WHERE mi.movie_id = t.id
     RETURN mi, t",
    "CREATE (mi)-[ :MOVIE_INFO_OF ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mi:Movie_info), (it:Info_type)
     USING SCAN mi:Movie_info
     WHERE mi.info_type_id = it.id
     RETURN mi, it",
    "CREATE (mi)-[ :IS_INFO_TYPE ]->(it)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mi_idx:Movie_info_idx), (t:Title)
     USING SCAN mi_idx:Movie_info_idx
     WHERE mi_idx.movie_id = t.id
     RETURN mi_idx, t",
    "CREATE (mi_idx)-[ :MOVIE_INFO_IDX_OF ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mi_idx:Movie_info_idx), (it:Info_type)
     USING SCAN mi_idx:Movie_info_idx
     WHERE mi_idx.info_type_id = it.id
     RETURN mi_idx, it",
    "CREATE (mi_idx)-[ :IS_INFO_TYPE ]->(it)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mc:Movie_company), (t:Title)
     USING SCAN mc:Movie_company
     WHERE mc.movie_id = t.id
     RETURN mc, t",
    "CREATE (mc)-[ :MOVIE_COMPANY_OF ]->(t)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mc:Movie_company), (cn:Company_name)
     USING SCAN mc:Movie_company
     WHERE cn.id = mc.company_id
     RETURN mc, cn",
    "CREATE (cn)-[ :COMPANY_NAME_OF ]->(mc)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mc:Movie_company), (ct:Company_type)
     USING SCAN mc:Movie_company
     WHERE mc.company_type_id = ct.id
     RETURN mc, ct",
    "CREATE (mc)-[ :IS_COMPANY_TYPE ]->(ct)",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (t:Title), (kt:Kind_type)
     USING SCAN t:Title
     WHERE t.kind_id = kt.id
     RETURN t, kt",
    "CREATE (t)-[ :IS_KIND_TYPE ]->(kt)",
    {batchSize: 100000}
);

// Remove extra attributes that were used for joining
// They are not needed anymore since the relationships have been created

CALL apoc.periodic.iterate(
    "MATCH (mi_idx:Movie_info_idx)
     RETURN mi_idx",
    "REMOVE mi_idx.movie_id, mi_idx.info_type_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (pi:Person_info)
     RETURN pi",
    "REMOVE pi.info_type_id, pi.person_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mi:Movie_info)
     RETURN mi",
    "REMOVE mi.movie_id, mi.info_type_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (mc:Movie_company)
     RETURN mc",
    "REMOVE mc.company_id, mc.movie_id, mc.company_type_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (an:Aka_name)
     RETURN an",
    "REMOVE an.person_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (t:Title)
     RETURN t",
    "REMOVE t.kind_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (cc:Complete_cast)
     RETURN cc",
    "REMOVE cc.subject_id, cc.status_id, cc.movie_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ml:Movie_link)
     RETURN ml",
    "REMOVE ml.movie_id, ml.linked_movie_id, ml.link_type_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (at:Aka_title)
     RETURN at",
    "REMOVE at.movie_id",
    {batchSize: 100000}
);

CALL apoc.periodic.iterate(
    "MATCH (ci:Cast_info)
     RETURN ci",
    "REMOVE ci.movie_id, ci.person_role_id, ci.person_id, ci.role_id",
    {batchSize: 100000}
);
