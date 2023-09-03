Process can be divided to partitions and allocated at different locations

> [!NOTE] Note
> Holes are created at runtime Dynamically and the Division process is very costly

# Paging :
 Before the process comes into the RAM ,
 process is divided to ***Pages*** and Main Memory is divided to ***Frames***
>  SO that ***Size of Page = Size of Frame***
 - By this External Fragmentation is Totally Removed.


> [!NOTE] Mapping
> CPU is unaware of Paging so , when it asks for a address in page 
> it might be corresponding to a address in the frame it is allocated
> 
> So, we map the addresses of page to frame, which is mapping

> Here, mapping is done my MMU( Memory Management Unit ) with help of Page Table. 


> [!NOTE] Page Table
> Every Process has its own Page Table 
> Entries will be equal to ***Number of Pages***,
> each corresponds to its respective address of its ***allocated Frame.***

**PAGE TABLE ENTRY**
|FRAME|valid(1)/Invalid(0)|Protection(RWX)|Reference(0/1)(LRU)|Caching|Dirty Modify|
|-|-|-|-|-|-|
|Mandatory Field| opt|opt|opt|opt|opt|


> CPU always works on Logical Address
> Logical Address consists of 
> - Page Number  ------> Which page.
> - Page Offset     ------> Which value in the Page number.

> Main Memory Works on Physical Address
> Physical Address consists of 
> - Frame Number ------> Which Frame.
> - Frame Offset    ------> Which value in the frame number


> [!NOTE] Note
> Page Offset == Frame Offset for a entry in Page Table.
