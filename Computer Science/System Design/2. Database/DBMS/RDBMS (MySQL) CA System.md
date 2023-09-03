# Relational Database Management System
The data is presented to the user in the form of tables known as relations. The data is arranged as the collection of rows and colums.
Structured query language (SQL) is implemented by most commercial RDBMS systems for accessing the database.
Indices can be created on the tables, that helps in faster data retrieval. However, creating indices can be expensive.

Relational Database design satisfies the ACID (atomicity, consistency, integrity and durability) properties required from a database design.

It has the following properties:
- Relations and attributes: The tables represent entities, and the attributes represent the properties of the respective entities.
- Primary Keys: The attribute or set of attributes that help in uniquely identifying a record.
- Relationships: The relationships between the various tables are established with the help of foriegn keys. Foreign keys are attributes occuring in a table that are primary keys of another table. The types of relationships between the tables are following:
	- one to one
	- one to many
	- many to many
## In system design
They are very well suited for storing and querying structed relational data.
They are typically characterized as CA systems that therefore sacrifice partition tolerance, and are often implemented as a single server.

## My SQL
By default, MySQL is CA system, because it follwos master, slave approach. In this the data is replicated to the slaves. In case if some of the slaves lose connection to their master ( or if the master goes down ), the slaves elect a new master.
Thus we now have 2 masters, each with their own set of slaves.

However, MySQL also has another configurationwhich is a clustered configuration. It prioritizes CP over availablity eg:
the cluster will shutdown if there are not enought live nodes to server all the data.

## Definitions

### Primary Key:
A primary key is a column ( or set of colums ) in a table whose values uniquely identify a row in the table,
Primary key cannot be NULL.

### Foreign Key:
Foreign keys are primary keys of another table.

In order to add a row with a given foreign key value, there must exist a row in the related table with the same primary key value.
