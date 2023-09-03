---
type: process-sync 
---

> N Philosophers sit with N forks to eat
> so ith philosophers needs forks left of him and right of him
> ( i . e ) ith takes ith fork and i+1(mod n) fork


> [!NOTE] Note
> Here it is a special case of synchronization where multiple philosophers can eat at a time as if they are **INDEPENDENT PROCESSES**


> [!NOTE] Problem
> Problem comes when 2 forks are not available for philosopher as both are taken/used by other philosphers

> Here we use an ***Array of Binary Semaphores*** to take care of current status of  respective fork Initialized with 1

```c
int n; // number of philosophers
// initialize an array of semaphores initialized to "1"
void Philosopher(){
	while(true){
		Thinking_to_eat();
		down(take_fork(S[i]));
		down(take_fork(s[(i+1) % n]));
		EAT();
		up(put_fork(s[i]));
		up(put_fork(s[(i+1) % n]));
	}
}
```

## Dead-Lock Situation
Here, while one fork is taken, the process gets pre-empted before taking another fork
If this process goes on till all the semaphores are 0
> We get into deadlock where any philosopher cant take eat as no philosopher has access to their second fork and all of them waits


> [!NOTE] Solution for this
> to avoid this we reverse the taking the fork of last philosopher 
( i . e taking (i+1)mod n and i  instead of i and (i+1)mod n)
