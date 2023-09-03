# Redis 
Redis stands for Remote Dictionary Server.
It is not just a plain key-value store, it is actually a data structure server, supporting different kinds of values. In Redis, the value ( of the key-value pair ) is not limited to a simple string, bt can also hold more complex data structures.

It is used primarily as an application cache or quick-response database. Because it stores data in memory, rather than on a disk or solid-state-drive (SSD), Redis delivers unparelleled speed, reliability, and performance.

## Architecture
Redis is AP System.
Redis used Master-Slave approach. The slaves are the exact copies of the master. The slave will always try to reconnect to the master every time the link breaks, and try to be an exact replica of the master regardless of what ever happens to the master.
The best configuration for Redis Master-Slave is to perform Writes to the master and reads from the slave.
If the master goes down , we cann add a new machine as the master or pick one of the slaves as the new master.
The data replication is down asynchronously.

### Advantages
1. Faster response times when performing read and write operations.
2. Redis can queue tasks that may take web clients longer to process than usual.
3. Because Redis supports the use of publish and subscribe (Pub/Sub) commands, users can design a high-performance chat and messaging services across all their applications and services.
4. High Availability.