---
type: intro
---
# New State (When we Create the process)
 a Stable State in Secondary Memory
	
# Ready State/Queue (Active State)
 now process came into RAM 
 came into a **Faster Memory** after staying in a stable state
 out of N we can only bring some number of processes to ready state
-  [[#^6dace5 |Long Term Scheduler]] brings all these Processes.


# Running State (Executing Process)
 certain amount of processes are Dispatched to Running State , **Based on RAM**
 Process is still in RAM But, at new Address where it is executed
 While Process is Running if a **High Priority Process** comes to ready state to execute it first before it 
-  [[#^fcd78f |Short Term Scheduler]] picks a Process and sends it running state


# Terminate State (Deallocation of Process)
 Process is Deallocated from RAM after Execution is complete ( Status Complete 

# Wait/Block
 If Executing Process has an I/O request then it should read from secondary memory
 After I/o request it goes to Ready queue
 If all request are overflowing of I/O requests then **Waiting Queue** will be filled 
 as RAM is Limited we suspend for some time and swap out **(return it to secondary memory)**
 It is handled by [[#^8cbe83 |Medium Turn Scheduler]].


> [!NOTE]  Long Term Scheduler :
Bringing as many processes to ready queue **([[Types of Operating System#Multi Programmed OS|MultiProgramming]])**

^6dace5

> [!NOTE] Short Term Scheduler : 
Bring Processes after execution and deallocation of current Process **([[Types of Operating System#Multi Tasking / Time Sharing OS| Multi Tasking]])**

^fcd78f

> [!NOTE] Medium Term Scheduler :
> Bring Processes from Wait/Block to Suspend-Wait when **Waiting queue is Full**.

^8cbe83


