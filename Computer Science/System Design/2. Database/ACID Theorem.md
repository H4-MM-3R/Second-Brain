Transactions are series of Database operations.
A database is said to e ACID compliant when it follows the following properties:
- Atomicity :- All operations succeed or fail together.
- Consistency :- A successful transaction places the databsse in a valid state, that is, no schema violations.
- Isolation :- Transactions can be executed concurrently.
- Durability :- completed transactions persist, even when servers restart etc.

Usually relational databases are ACID compliant.
So the database is consistent after every transaction.

# Base Theorem

A Database is said to BASE compliant when it follows the following properties:
- Basic Availability :- The system is guarantedd to be available in event of failure.
- Soft-state :- The state of the data could change without application interactions due to eventual consistency.
- Eventual consistency :- The system will be eventually reach a consistent state. But the consistency is not guaranteed at a transaction level.
This essentially means that: It's OK to use stale data, and it's OK to give approximate answers.
BASE providesless assurance than ACID, but it scales very well and react well to rapid data changes.