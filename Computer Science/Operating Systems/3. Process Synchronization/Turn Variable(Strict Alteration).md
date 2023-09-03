---
type: process-sync 
---

- Solution only for 2 Processes
-  Runs in User Mode

int turn = 0; 

| | Process "p0" | Process "p1" |
| - | - | - |
| Entry Code --> | While (turn != 0); | While (turn != 1);
| | {Critical Section} | {Critical Section} |
| Exit Code --> | turn = 1; | turn = 0; |
