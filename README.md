# Reproducing [Neo4J In Action](https://www.manning.com/books/neo4j-in-action) "Friend-of-friend" relational DB benchmarks

https://github.com/opencredo/neo4j-in-action

https://neo4j.com/business-edge/connected-data-cripples-relational-performance/

## Instructions:

1. (Optional) Turn up a Postgres 10.5 database using [docker-compose](https://docs.docker.com/compose/install/):

```
docker-compose up --detach
```

A Postgres 10.5 database will now be available on host port 5442.

2. Populate the database with `populate_data.sql`:

```
PGPASSWORD=password psql -U postgres -d graphtest -p 5442 -a -t -f populate_data.sql
```

It takes about 13 minutes on my system

3. Benchmark queries with `queries/*.sql` scripts:

```
time PGPASSWORD=password psql -U postgres -d graphtest -p 5442 -a -t -f queries/depth-2.sql
```
