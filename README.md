# Reproducing [Neo4J In Action](https://www.manning.com/books/neo4j-in-action) "Friend-of-friend" relational DB benchmarks

https://github.com/opencredo/neo4j-in-action

https://neo4j.com/business-edge/connected-data-cripples-relational-performance/

## Instructions:

1. Install dependencies

* [Docker](https://docs.docker.com/install/), [docker-compose](https://docs.docker.com/compose/install/)
* [Ruby 2.5+](https://github.com/postmodern/ruby-install)
  * `$ ruby-install 2.5.0`
* Bundler
  * `$ gem install bundler`
  * `$ bundle`

2. Turn up Postgres database with:

```
docker-compose up --detach
```

A Postgres 10.5 database will now be available on host port 5442.

3. Populate the database with:

```
time bundle exec ruby populate_data.rb
```

(It takes about 13 minutes on my system)

4. Benchmark queries with:

```
bundle exec ruby benchmark.rb
```

Example output on my machine:

```
             user     system      total        real
depth 2  0.000075   0.000012   0.000087 (  0.022880)
depth 3  0.000093   0.000016   0.000109 (  0.547985)
depth 4  0.000135   0.000023   0.000158 ( 10.326733)
depth 5  0.000110   0.000019   0.000129 (221.158533)
```
