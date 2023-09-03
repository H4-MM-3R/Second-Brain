# Cassandra 
It is a NoSQL database.
It was originally created at Facebook.

## Architecture
The basic architecture consists of a cluster of nodes, any and all of which can accept a read or write request. This is a key aspect of its architecture, as there are not master nodes. Instead, all nodes communicate equally.

### Advantages
1. It is AP system, offering high availability and partition tolerance ( i.e no single point of failure )
2. NoSQL databases do not require fixed schema, allowing for easy replication.
3. Can handle high volumes of data across multiple servers.
4. It is able to fast write huge amounts of data without affecting the read effciency.
5. Is Horizontally scalable.
6. Supports ACID (Atomicity, Consistency, Isolation and Durablity ) property.