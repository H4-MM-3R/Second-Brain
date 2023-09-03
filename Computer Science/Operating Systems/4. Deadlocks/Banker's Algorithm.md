---
type: deadlock 
---

> Its a **Deadlock Avoidance** Algorithm

Total Resources A = 10, B = 5, C = 7

| Process | Allocation | Max Need | Available | Remaining Need |
|-|-|-|-|-|
|| A  B  C | A  B  C | A  B  C | A  B  C |
|P1| 0   1   0 | 7   5   3 | 3   3   2 | 7   4   3 |
|P2| 2   0   0 | 3   2   2 | 5   3   2 | 1   2   2 |
|P3| 3   0   2 | 9   0   2 | 0   0   0 | 5   0   0 |
|P4| 2   1   1 | 4   2   2 | 0   0   0 | 2   1   1 |
|P5| 0   0   2 | 5   3   3 | 0   0   0 | 5   3   1 |
|Total|7 2 5|


> [!NOTE] Remaining Need
> Max Need - Allocation


> [!NOTE] Available 
> for first ---> Total Resources - Total Allocation
> Remaining ---> Compare Previous available with Remaining need of currrent
> If less then Deadlock so unsafe
> else current Available = previous available + current allocation



