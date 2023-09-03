---
type: basics
---

> [!faq] Network
> A collection of devices connected together to enable communication and data exchange. 
^abcc45

> [!faq] Nodes
>  Devices connected to a network.
^ea09ee

> [!faq] Protocol
>  Set of rules to govern how data is transmitted over a network.
^d1643f

> [!faq] Router
> Device that connects multiple [[#^abcc45|Networks]] together and forwards data packets between them.

> [!faq] Switch
>  Device that connects **devices** on a [[#^abcc45|network]] and forwards data packets between them.

> [!faq] Topology
> Physical and Logical Arrangement of [[#^ea09ee|Nodes]] on a [[#^abcc45|Network]] . 

> [!faq] Service Provider Networks
>  [[#^abcc45|Networks]] which give permission to take Network Capacity and Functionality on lease from the Provider.

> [!faq] Firewall
> A Security Device used to monitor and control incoming and outgoing network traffic.
## Types of Enterprise Computer Networks


> [!faq] Local Area Network
>  A [[#^abcc45|Network]] that covers a small area, such as an office or a home.
^d5871b


> [!faq] Metropolitan Area Network
>  A [[#^abcc45|Network]] that covers a area of a city , i.e larger than [[#^d5871b|LAN]] and smaller than [[#^75f715|WAN]]

^3390f6


> [!faq] Wide Area Network
> A  [[#^abcc45|Network]]that covers a larger geographic area, such as a state, country, or even the entire world.
^75f715

> [!faq] Cloud Networks
>  A [[#^75f715|WAN]] hosted on public or private cloud service providers.

- *Open system:* A system that is connected to the network 
- *Closed system:* A system that is not connected to the network 

## Types of Computer Network Architecture

Computer Network falls under these broad Categories:

- **Client-Server Architecture:** The Server [[#^ea09ee|Node]] can manage the Client [[#^ea09ee|Node]] Behaviour.
- **Peer-to-Peer Architecture:** Each device is free for working as either client or server.

---
## Network Topology

> [!faq] [Network Topology](https://www.geeksforgeeks.org/types-of-network-topology/)
> Layout arrangement of the different devices in a [[#^abcc45|Network]] 

![[Terminology-Topology-drw|800|center]]
## **OSI Model** 

 [Open Systems Interconnection](https://www.geeksforgeeks.org/layers-of-osi-model/):
 - It is a 7 layer architecture. 
 - Each layer of OSI has different functions and each layer has to follow different [[#^d1643f|Protocols]]. 

The 7 layers are as follows: 
1. [Physical Layer](https://www.geeksforgeeks.org/physical-layer-in-osi-model/)
2. [Data link Layer](https://www.geeksforgeeks.org/data-link-layer/)
3. [Network Layer](https://www.geeksforgeeks.org/network-layer-services-packetizing-routing-and-forwarding/) 
4. [Transport Layer](https://www.geeksforgeeks.org/transport-layer-responsibilities/)
5. [Session Layer](https://www.geeksforgeeks.org/session-layer-in-osi-model/)
6. [Presentation Layer](https://www.geeksforgeeks.org/presentation-layer-in-osi-model/)
7. [Application Layer](https://www.geeksforgeeks.org/application-layer-in-osi-model/)



> [!faq] Dynamic Host Configuration Protocol(*DHCP*)
> A [[#^d1643f|Protocol]] that automatically assigns [[#^a352d5|IP Addresses]] and **network configuration** settings to devices on a [[#^abcc45|Network]].

^985f18

> [!faq] Transmission Control Protocol/Internet Protocol(*TCP/IP*)
 A set of [[#^d1643f|protocols]] communication over the internet and other [[#^abcc45|networks]].
# Unique Identifiers of Network 
 
> [!NOTE] Hostname
> Each Device in the [[#^cb5883|Network]] is associated with a unique Device Name known as Hostname.
^7774e3

Type “hostname” in the command prompt(Administrator Mode) and press ‘Enter’, this displays the [[#^7774e3|hostname]] of your machine.
![](https://media.geeksforgeeks.org/wp-content/uploads/hostname.png)

----
> [!faq] IP Address (*LOGICAL ADDRESS*)
> A unique numerical identifier assigned to every device on a [[#^abcc45|Network]] to identify devices and enable communication between them.dress
^a352d5
- To identify each device, **Internet Assigned Numbers Authority (IANA)** assigns an **IPV4** *(Version 4)* address as a unique identifier to each device on the Internet. 

> [!example] Note
> The length of an IPv4 address is **32 bits**, hence, 
> **we have2<sup>32</sup> IP addresses available**.

- The length of an IPv6 address is **128 bits**. 

Type “ipconfig” in the command prompt and press ‘Enter’, this gives us the IP address of the device. 
![](https://a-auto50.unirita.co.jp/wordpress/wp-content/uploads/2015/11/ipconfig.png)

----
> [!faq] MAC Address (*PHYSICAL ADDRESS*)
>  The [MAC Address](https://www.geeksforgeeks.org/introduction-of-mac-address-in-computer-network/) is the unique identifier of each host and is associated with its *NIC (Network Interface Card)* 
^93f009

- The length of the [[#^93f009|MAC address]] is: 12-nibble/ **6 bytes/ 48 bits**.

Type “ipconfig/all” in the command prompt and press ‘Enter’, this gives us the MAC address. 
![](https://activedirectorypro.com/wp-content/uploads/2021/09/windows-cmd-commands-2.png)

----
> [!faq] Port
> A Logical Channel through which Data can be sent/received to an Application.

- Any host may have multiple applications running, and each of these applications is identified using the **Port Number** on which they are running.

> [!example] Note 
> A port number is a **16-bit integer**, hence,
> we have **2<sup>16</sup> ports** available which are categorized as shown below:

| Port Types       | Range       |
| ---------------- | ----------- |
| Well known Ports | 0-1023      |
| Registered Ports | 1024-49151  |
| Ephemeral Ports  | 49152-65535 |

- Number of ports: 65,536   
- Range: 0 – 65535   

Type “**netstat -a**” in the command prompt and press ‘Enter’, this lists all the ports being used.
![](https://media.geeksforgeeks.org/wp-content/uploads/ports.png)

----
> [!faq] Socket
> The unique combination of [[#^a352d5|IP address]] and **Port number** together is termed a Socket.


## Other Related Concepts 

> [!faq] [DNS](https://www.geeksforgeeks.org/domain-name-system-dns-in-application-layer/)(*Domain Name System*)
> A [[#^d1643f|Protocol]] which translate human-readable domain names into corresponding [[#^a352d5|IP addresses]].

The command ‘**nslookup**’ gives you the IP address of the domain you are looking for. This also provides information on our DNS Server. 
![](https://media.geeksforgeeks.org/wp-content/uploads/nslookup.png)


> [!faq] [ARP](https://www.geeksforgeeks.org/how-address-resolution-protocol-arp-works/) (*Address Resolution Protocol*)
>  [[#^d1643f|Protocol]] which converts an [[#^a352d5|IP Address]] to its corresponding [[#^93f009|Physical Address]]. 

- ARP is used by the **Data Link Layer** to identify the [[#^93f009|MAC address]] of the Receiver’s machine. 

> [!faq] [RARP](https://www.geeksforgeeks.org/what-is-rarp/)(*Reverse Address Resolution Protocol*)
>  [[#^d1643f|Protocol]] which converts [[#^93f009|Physical Address]] as input to provide its corresponding [[#^93f009|Physical Address]]. 

- But RARP has become obsolete since the time DHCP has come into the picture.



