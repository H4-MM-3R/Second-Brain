Instead of creating a page table for every process,
***we create one page table for all processes***
called **Global Page Table** / **Inverted Page Table**.

**NORMAL PAGE TABLE**
|Index / Page no|Frame no|
|-|-|
|0||
|1||
|2||
|3||

**INVERTED PAGE TABLE**
|Index / Frame no|Page no|Process ID|
|-|-|-|
|0|p0|P1|
|1|p1|P2|
|2|p2|P1|
|3|p1|P3|
|4|p3|P2|
|5|p2|P3|


> [!NOTE] No of Entries
> No of Entries in Normal Page Table = No of Pages.
> No of Entries in Inverted Page Table = No of Frames.


> [!NOTE] Searching Time
> Normal Page Table = O(1)  --  { Hashing }
> Inverted Page Table = O(N)  --  { Linear Search }
