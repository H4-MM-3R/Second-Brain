# Relational Database
A Relational database is simple a database that uses a relational data model, which organizes data in tables with rows of data entries and columns of predetermined data types. Relationships between tables are represented with foreign key columns that reference the primary key columns of other tables. 

## Advantages
- They work with structured data.
- Faster query response times.
- They are excellent at keeping data transactions secure.
- They support ACID Therem.

## Disadvantages
- They are hard to scale over distributed cluster ( horizontal scaling ).
- They aren't particularly advantageous if the data has little to no structure and changes shape frequently.

# Non - relational Database
Non-relational database uses a storage model optimized for specific requirements of the type of data being stored.
Non-relational databases are either AP databases or CP databases. In the case of AP non-relational databases, the model of eventual consistency is used.

*Comparing to SQL*: NoSQL cannot be compareed to SQL. in any way. Document DBs, Key-Value DBs, Event DBs are all NoSQL. They are all different in almost all aspects, be it structer of saved data, querying, performance and available tools.

## Types of Non-relational Databases
The types of non-relational databases with thier examples are:
- Graph Database
	- Neof4J and cosmosDB
	![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Relational%20Vs%20NonRelational/img/GraphDB.png)
- Document Store
	- MongoDB, Couchbase, Firebase, CouchDB and DynamoDB.
	![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Relational%20Vs%20NonRelational/img/DocumentDB.png)
- Key-Value Store
	- Redis, DynamoDB, CosmosDB, Memcached, and Hazelcast
	![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Relational%20Vs%20NonRelational/img/KyeValueStore.png)
- Column-Family Database
	- Cassandra, HBase, and CosmosDB.
 ![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Relational%20Vs%20NonRelational/img/ColumnFamily.png)
- Search Engine Database
	- Elasticsearch, Splunk and Solr.
- Time Series Database
	- InfluxDB, Kdb+ and Prometheus.
# Advantages
- They work with data that has little to no structure.
- They provide scalability and flexibility to meet changing business requiremens.
- In order to support ACID developers will have to implement their own code, making their systems more complex.
- Some of them support BASIC theorem, (some do support ACID theorem though, you just need to know which one).
