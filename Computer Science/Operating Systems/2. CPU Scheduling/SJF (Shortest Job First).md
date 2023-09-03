---
type: cpu-scheduling
---

> *Criteria* : **Burst Time**
> *Mode* : **Non Pre-Emptive**

|**Process No** | **Arrival Time** |  **Burst Time** |  **Completion Time** | **TakeAway Time** | **Waiting Time** | **Res Time** |
| - | - | - | - | - | - | - |
| p1 | 1 | 3 | 6 | 5 | 2 | 2 |
| p2 | 2 | 4 | 10 | 8 | 4 | 4 |
| p3 | 1 | 2 | 3 | 7 | 0 | 0 |
| p4 | 4 | 4 | 14 | 10 | 6 | 6 |
```mermaid
gantt
        title SFJ
        dateFormat  s
        axisFormat %S
        section Process No
        idle   :active, a, 0, 1s
        p3     :b, after a , 2s
        p1     :c, after b , 3s
        p2     :d, after c, 4s
        p4     :after d , 4s
```

