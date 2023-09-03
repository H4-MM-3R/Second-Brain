# Memcached 
It is a distributed memory object caching system. It is an in-memory key-value store for small chunks of arbitrary data ( strings, objects ) from results of database calls, API calls, or page rendering.
When the memory gets full, it used LRU based eviction policy.
It does not support replication.
Memcached server is a big hash table. The max length of the key is 250 bytes.

## Architecture
All the clients know about the all memcached servers. The clients access the server over TCP or UDP connections. The servers are independent of one another.

### Advantages
1. Memcached's uses include caching and storing session data.
2. The system where memcached is deployed can achieve high performance and scalability.
3. It is very good at handling high traffic websites. It can read lot of information at a time and have a great response time.
4. Excellent for high latency queries, since caching can prevent the need to repeat the big units of work.
