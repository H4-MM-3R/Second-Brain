---
type: process-sync 
---

> If multiple Processes are running they might be in serial mode or parellel mode

## Serial Execution: (Multi-Programmed type)
- When one process starts, other processes cant start untill it wont get terminated.
Example : **ATM**, when customers uses ATM they use one-by-one.
- Running of one process doesnt effect other.
## Parellel Execution: (Time-Shared type):
- Executed Parellely

![[Process Synchronization-drw| 900]]


## Race Condition
> int Shared = 5;

![[Process Synchronization-Race-cond]]

> [!note] 
> If  **P1** [[Types of Operating System#^fb1e10|Pre-empts]] first then Shared = 4
or else Shared  = 6 in this race condition.

