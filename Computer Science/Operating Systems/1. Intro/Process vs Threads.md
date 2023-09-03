---
type: intro
---

![[Process vs Threads-drw]]


|**Process** | **Thread** |
|------------ | ------------|
|System call is involved | No System Call involved |
|Different Process are treated differently | All User Level Threads are single task for OS|
|Different Process have diff copies of data, files and code | Threads have same copy of code and data |
|Content switching is slower | Content switching is faster |
|Blocking a process will not block another process | Blocking a Thread will block entire process |
|Independent | Interdependent |



