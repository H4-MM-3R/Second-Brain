---
type: basics
---

> [!faq] Network Topology
>  Way that defines how components in a [[Terminology#^abcc45|Network]] to be connected to each other.
^b5094f

- The arrangement of a [[Terminology#^abcc45|Network]] comprises [[Terminology#^ea09ee|Nodes]] and connecting lines via sender and receiver .
---
## Types of Network Topology

> [!example] Contents
> 1. [[#Point to Point Topology]]
> 2. [[#Mesh Topology]]
> 3. [[#Star Topology]]
> 4. [[#Bus Topology]]
> 5. [[#Ring Topology]]
> 6. [[#Tree Topology]]
> 7. [[#Hybrid Topology]]

---

## Point to Point Topology

 [[#^b5094f|Topology]] which works on the functionality of the sender and receiver.

 - Point-to-Point provides high bandwidth.
![[Topology-Point-to-Point-drw|400|center]]
---
## Mesh Topology

[[#^b5094f|Topology]] where all devices are connected to each other via unique channels.

  Protocols used are 
  - AHCP (Ad Hoc Configuration Protocols)
  - DHCP (Dynamic Host Configuration Protocol), etc.

![[Topology-Mesh-drw|400|center]]


### Advantages of Mesh Topology
- Communication is very fast between the [[Terminology#^ea09ee|nodes]].
- Mesh [[#^b5094f|Topology]] is robust.
- The fault is diagnosed easily. 
- Data is reliable because data is transferred among the devices through dedicated channels or links.
- Provides security and privacy.
### Drawbacks of Mesh Topology
- Installation and configuration are difficult.
- The cost of cables is high as bulk wiring is required, hence suitable for less number of devices.
- The cost of maintenance is high.



> [!example] Application 
>  Application would be **Internet** connected via internet service provider 
 
 Used in **Military communication systems**, **Aircraft navigation systems** etc
 
---
## Star Topology

[[#^b5094f|Topology]] where all devices are connected to a single hub through a cable. 
- This hub is the **Central Node** .

In **Star Topology**, many popular Ethernet LAN protocols are used as 
- CD(*Collision Detection*)
- CSMA (*Carrier Sense Multiple Access*) etc.

![[Topology-Star-drw|center]]


### Advantages of Star Topology

- If N devices are connected to each other in a star topology, then the number of cables required to connect them is N. So, it is easy to set up.
- Each device requires only 1 port i.e. to connect to the hub, therefore the total number of ports required is N.
- It is Robust. If one link fails only that link will affect and not other than that.
- Easy to fault identification and fault isolation.
- Star topology is cost-effective as it uses inexpensive coaxial cable.
### Drawbacks of Star Topology

- If the concentrator (hub) on which the whole topology relies fails, the whole system will crash down.
- The cost of installation is high.
- Performance is based on the single concentrator i.e. hub.


> [!example] Application 
> Application would be [[Terminology#^d5871b|LAN]] in an office where all computers are connected to a central hub.

Used in **wireless networks** where all devices are connected to a **wireless access point**.

---
## Bus Topology

[[#^b5094f|Topology]] where all devices is connected to a single cable.
- It is bi-directional.
- It is a **multi-point connection** and a non-robust topology because if the backbone fails the topology crashes.
- In Bus Topology, various MAC (*Media Access Control*) protocols are followed by [[Terminology#^d5871b|LAN]] ethernet connections like TDMA, Pure Aloha, CDMA, Slotted Aloha, etc.
![[Topology-Bus-drw|450|center]]

### Advantages of Bus Topology

- If N devices are connected to each other in a bus topology, then the number of cables required to connect them is 1, known as backbone cable, and N drop lines are required.
- Coaxial or twisted pair cables are mainly used in bus-based networks that support up to 10 Mbps.
- The cost of the cable is less compared to other topologies, but it is used to build small networks.
- Bus topology is familiar technology as installation and troubleshooting techniques are well known. 
- CSMA is the most common method for this type of topology.
### Drawbacks of  Bus Topology

- A bus topology is quite simpler, but still, it requires a lot of cabling.
- If the common cable fails, then the whole system will crash down.
- If the network traffic is heavy, it increases collisions in the network. To avoid this, various protocols are used in the MAC layer known as Pure Aloha, Slotted Aloha, CSMA/CD, etc.
- Adding new devices to the network would slow down networks.
- Security is very low.

> [!example] Application
>Application would be Ethernet [[Terminology#^d5871b|LAN]], where all devices are connected to a single coaxial cable or twisted pair cable. 

Also used in **cable television networks**.

---
## Ring Topology

[[#^b5094f|Topology]] where all devices form a **ring** with **exactly two** neighboring devices.

Here, to access adjacent [[Terminology#^ea09ee|nodes]] **Repeaters** are used which prevents data loss in the [[Terminology#^abcc45|network]].
![[Topology-Ring-drw|450|center]]


The most common access method of ***Ring Topology*** is **Token Passing**.


> [!NOTE] Token Passing
>  It is a network access method in which a [[#^be529d|token]] is passed from one [[Terminology#^ea09ee|node]] to another [[Terminology#^ea09ee|node]].

> [!NOTE] Token
>  It is a frame that circulates around the [[Terminology#^abcc45|network]].
^be529d



### Operations of Ring Topology

1. One station is known as a **monitor** station which takes all the responsibility for performing the operations.
2. To transmit the data, the station has to hold the [[#^be529d|token]]. After the transmission is done, the [[#^be529d|token]] is to be released for other stations to use.
3. When no station is transmitting the data, then the [[#^be529d|token]] will circulate in the ring.
4. There are two types of [[#^be529d|token]] release techniques: **Early token release** releases the [[#^be529d|token]] just after transmitting the data and **Delayed token release** releases the [[#^be529d|token]] after the acknowledgment is received from the receiver.

### Advantages of Ring Topology

- The data transmission is high-speed.
- The possibility of collision is minimum in this type of topology.
- Cheap to install and expand.
- It is less costly than a [[#Star Topology]].

### Drawbacks of Ring Topology

- The failure of a single node in the network can cause the entire network to fail.
- Troubleshooting is difficult in this topology.
- The addition of stations in between or the removal of stations can disturb the whole topology.
- Less secure.

---
## Tree Topology

A variation of the [[#Star Topology]] which has a **Hierarchical flow** of data

Here, [[Terminology#^d1643f|protocols]] like [[Terminology#^985f18|DHCP]] and **SAC** (Standard Automatic Configuration ) are used.

![[Topology-Tree-drw|450|center]]

### Advantages of Tree Topology

- It allows more devices to be attached to a single central hub thus it decreases the distance that is traveled by the signal to come to the devices.
- It allows the [[Terminology#^abcc45|network]] to get isolated and also prioritize from different computers.
- We can add **new devices to the existing network.**
- **Error detection** and **error correction** are very easy in a Tree Topology.

### Drawbacks of Tree Topology

- If the Central Hub gets fails the entire system fails.
- The cost is high because of the cabling.
- If new devices are added, it becomes difficult to reconfigure.


> [!example] Application 
> Application is the hierarchy in a large organization. Each department has its own hierarchy,


## Hybrid Topology

[[#^b5094f|Topology]] which is a combination of various topologies. 

- It is used when the nodes are free to take any form.
It means these can be individuals or can be a combination of [[#^b5094f|topologies]].  Each individual [[#^b5094f|topology]] uses the [[Terminology#^d1643f|protocol]] that has been discussed earlier.


![[Topology-Hybrid-drw|450|center]]

**Advantages of Hybrid Topology**

- This topology is **very flexible**.
- The size of the network can be easily expanded by **adding new devices.**

**Drawbacks of Hybrid Topology**

- It is challenging **to design the architecture** of the Hybrid Network.
- **Hubs** used in this topology are **very expensive.**
- The infrastructure cost is very high as a hybrid network **requires a lot of cabling and network devices**.


> [!example] Application
> Application is a **university campus network**.
> -  The network may have a backbone of a [[#Star Topology]], with each building connected to the backbone through a switch or router.
> - Within each building, there may be a [[#Bus Topology]] or [[#Ring Topology]] connecting the different rooms and offices.
> - The wireless access points also create a [[#Mesh Topology]] for wireless devices. 

