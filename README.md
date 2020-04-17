# Join order benchmark for graph databases
This was made mainly for neo4j. The data create\* scripts use APOC libary functions. Without them, Neo4j will hit OOM errors,
due to the size of the data set.  
Took about 1 hour to run on a AWS EC2 r4.xlarge instance (4 vCPUs, 30.5 GiB) + EBS storage. Tested with Neo4j Community Edition 3.5.16 AMI.

## Running cypher
There are two ways to run `.cypher` files:
- By piping from stdin: `cat <file>.cypher | cypher-shell -u <username> -p <password> --format plain`
- Or by interacting with `cyper-shell` and calling `CALL apoc.cypher.run[File|SchemaFile](...)`

## To load
1. Download the csv files, and place into Neo4j's import directory, which by default is `/var/lib/neo4j/import` 
(will be the starting point for `file:///` inside cypher).
2. To create the schema, pipe the file/run in cypher-shell `CALL apoc.cypher.runSchemaFile("<import directory>/create_schema.cypher")`
3. To create the nodes, pipe the file/run in cypher-shell `CALL apoc.cypher.runFile("<import directory>/create_nodes.cypher")`
3. To create relationships, pipe the file/run in cypher-shell `CALL apoc.cypher.runFile("<import directory>/create_relationships.cypher")`

## To run cypher queries
1. Pipe the file/run in cypher-shell `CALL apoc.cypher.runFile("<import directory>/1a.cypher")`

## Note for Neo4j Community Edition 3.5.16 AMI
 - To change Neo4j configuration (`neo4j.conf`) on the AMI, do not edit `neo4j.conf` as it gets rewritten 
 anyways by `neo4j.template` file - edit that file instead. [See here.](https://neo4j.com/developer/neo4j-cloud-vms/)
 - The default username is "neo4j" and password the instance ID, e.g. "i-08407a097a5c5d20e".
