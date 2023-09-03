# Horizontal Scaling

Horizontal scaling means scaling by adding more machines to your pool of resources.

One of the fundamental differences between the two is that horizontal scaling requires breaking a sequential piece of login into smaller pieces so that they can be executed in parellel across multiple machines.
- We horizontal scale by adding several small server/machines.
- We need a load balancer to balance the load amongst all other machines.
- If one of the machine fails, you can redirect the request to the several other machines.
- What ever communication we have between the machines, it is over he network, and netweorks are usually slow as compared to inter-process communicatio.
- Data can be inconsistent, because there are several machines, it may take some time for machines to copy data from other machines.
- Scales well, we can add as many server/machines as we like.
![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Horizontal%20and%20Vertical%20Scaling/img/HorizontalScaling.PNG)
Datavases running horizontal scaling: Cassandra, MongoDB, Google Cloud Spanner

# Vertical Scaling
Vertical scaling means, scaling by adding more power (e.g CPU, RAM ) to an existing machine.

Vertical scaling is easier because the login relly doesn't need to change. Rather, you're just running the same code one higher-spec machies.
- We vertical scale by adding more power to out existing server.
- We can increase power of our existing machine by adding more processing power, giving it more storage, etc
- We dont require a load balancer since there is just one big system
- but if this one big system fails then the entire service goes down.
- If we want to communicate between 2 independent systems, then we have inter process communication thats faster.
- The data just resides on one system, so data will always be consistent.
- There will eventually be some hardware limitations, so it eventually won't scale
![](https://github.com/PriyankaKhire/SystemDesign/blob/main/Basics/Horizontal%20and%20Vertical%20Scaling/img/VerticalScaling.PNG?raw=true)
Databases running vertical scaling: MySQL, Amazon RDS

![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/Horizontal%20and%20Vertical%20Scaling/img/HorizontalVSVertical.PNG)


