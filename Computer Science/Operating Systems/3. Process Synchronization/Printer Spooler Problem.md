---
type: process-sync 
---

> [!NOTE] Problem
> One Printer used by Multiple users then Spooler is used for sequential maintainance for scheduling users 


![[Printer Spooler Problem-drw|center]]

## Program:
```
1. Load Ri, M[in] // in is variable for free slot
2. Store SD[Ri], "F-N" //F-N is file name, SD is spooler DIrectory
3. INCR Ri
4. Store M[in], Ri
```

> Here, without synchronization user may rewrite the existing slot which leads to an error
> Error is loss of data