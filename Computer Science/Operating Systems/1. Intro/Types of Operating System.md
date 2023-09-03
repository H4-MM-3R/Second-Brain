---
type: intro
---

- [[#Batch OS]]
- [[#Multi Programmed OS]] ^34a3e0
- [[#Multi Tasking / Time Sharing OS]]
- [[#Real Time OS]]
- [[#Distributed OS]]
- [[#Clustered OS]]
- [[#Embedded OS]]

# Batch OS
 Making Batches of Similiar kind of work and executing them

![[Types of Operating System-BatchOS| 600]]
**Examples** : Fortran, IBSYS 709x.

# Multi Programmed OS
It is [[#^8e8019| Non Pre-Emptive]].
 CPU would be **less Idle** and as soon as a process completes next process will take over.
 ![[Types of Operating System-MultiprogrammedOS| 600]]

# Multi Tasking / Time Sharing OS
 It is [[#^fb1e10 | Pre-Emptive]].
  CPU would be **More Responsive**.
![[Types of Operating System-MultitaskingOS| 800]]

# Real Time OS
Happening in **Real Time Environment** (TIme Constraint without Delays)

###  Hard RLOS
   - Very strict about time , there can be no delays **( Example : Missile Launching)**
###  Soft RLOS
 -  Little bit delay doesnt lead to a critical situation **( Example :  Gaming)**

# Distributed OS
- Environment is Distributed geographically and connected through a Network working independently.
- Each Machine has its own kernel, own memory, own disk..........
- All the data is placed at one place and others are distributed.
![[Types of Operating System-DistributedOS| 500]]


# Clustered OS
Connected through a Local Network
- Conneted together to form a cluster of one server with more computational Power
- Increased Availability.
![[Types of Operating System-ClusteredOS| 500]]

# Embedded OS
Works only with fixed functionality 


> [!info] Non Pre-Emptive
CPU **Completely executes** the current process untill going for next one ^8e8019

> [!info] Pre-Emptive
 CPU will decide certain time for a process in advance.  
> > [!note] Note
> > if it is not executed in given time , it will reschedule it again in future.

^fb1e10

 