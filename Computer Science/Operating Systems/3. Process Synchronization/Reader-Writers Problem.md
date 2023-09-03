---
type: process-sync 
---

> In a Database 2 people Reader and Writer try to access the data
> Reader ---> Just reads/See the data.
> Writes ----> Writes/ Modiies the data.

> [!NOTE] Actual Problem
> Problem actually comes when,
> - Writer accesses the data while the reader is reading the data
> - Reader accesses the data while the writer is writing the data.
> - Writer accesses the data while another writer is writing the data.

```c
int rc = 0; // number of readers using the database
semaphore mutex = 1;
semaphore db = 1;
void Reader(){
	while(true){
		down(mutex);       //       |
		rc = rc + 1;       //       |  [ ENTRY CODE ]
		if(rc == 1) down(db);//     |
		up(mutex);         //       |
		DB;          // -------->    reading the database            
		down(mutex);       //       |
		rc = rc - 1;       //       |
		if(rc == 0) up(db);//       |  [ EXIT CODE ]
		up(mutex);         //       |
		Process_data;      //       |
	}
}
void Writer(){
	while(true){
		down(db); // [ ENTRY CODE ]
		DB;       // ------> writing the database
		up(db);   // [ EXIT CODE ]
	}
}
```