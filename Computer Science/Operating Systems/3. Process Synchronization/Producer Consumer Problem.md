---
type: process-sync 
---

![[Producer Consumer Problem-drw|center]]
```c
// common for both producer and consumer
int count = 0;
int n;
int in = 0; // next free slot in buffer
int out = 0; // curr used slot in buffer
int buffer[n];
```
## Producer Code
```cpp
void producer(){
	int itemp;
	while(true){
	prduce.item(itemp);
	while(count == n); // buffer overflow
	// no space for new production
	buffer[in] = itemp;
		in = (in + 1) mod n;
	count = count + 1;
	/* CPU Instruction for count
	load R m[count];
	INCR R;          // means increment
	Store m[count], R;
	*/
	}
}
```

## Consumer Code
```c
void consumer(){
	int itemc;
	while(true){
	while(count == 0); // buffer underflow
	//nothing to consume
	itemc = buffer(out);
	out = (out + 1) mod n;
	count = count - 1;
	process.item(itemc);
	}
}
```


> [!NOTE] Note
> Here, if the process is not synchronized then, 
> While production producer process might pre-empt(stop for some reason)
> which leads to synchronization error 

> Here, the error is count value difference where no of elements in buffer is not equal to count
> 


