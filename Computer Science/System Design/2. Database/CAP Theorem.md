CAP theorem stands for 
- Consistency : All nodes see same data at the same time.
- Availability : All the nodes are always available, and can send response to any request coming their way.
- Partition Tolerance : Even if a node goes down, the system continues to function.

We can only have any 2 of the 3 properties mentioned above.
We always MUST have Partition Tolerance.
So we can trade off between either Consistency and Availablity.

![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/CAP%20Theorem/img/CAP.png)