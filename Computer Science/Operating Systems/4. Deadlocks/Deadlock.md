---
type: deadlock 
---

> If two or more processes are waiting on happening of some event but that event doesnt happen, then both the processes are in deadlock state.

![[Deadlock-drw|800]]
# Conditions for Deadlock
#### Mutual  Exclusion
More than one Proccesses cant use the same Resource
#### No Preemption
Cant release the current process while the resource is holding it for another process
#### Hold & Wait
Processes will hold resource and wait for another resource for neccessary requirement
#### Circular Wait
Loop of waiting for all the processes circular manner 
