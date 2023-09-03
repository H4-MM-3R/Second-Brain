---
type: intro
---

| **Process**                               | **Thread**                                |
| ----------------------------------------- | ----------------------------------------- |
| Managed by user level Library             | Managed by OS (System Calls)              |
| fast                                      | Slow                                      |
| Content Switching is Fast                 | Content Switching is Slow                 |
| if thread is blocked , process is blocked | if thread is blocked, No effect on others |


> [!tip] Note
> - Creating a **Kernel Level Thread** is ***similiar*** to creating a **Process**
> -  Process Time > KLT Time > ULT Time
