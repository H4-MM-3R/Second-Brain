- Partitions occurs at run-time 

# Advantages from Static
-  No Internal Fragmentation
-  No Limitation on Multiprogramming
-  No Limitation on Process Size
# Problems
## External Fragmentation :
- If there is a **Hole** in the RAM and Total size of holes at different locations is enough to allocate a new process
- we **can't** allocate due to contiguos method.

> [!NOTE] Hole
> If a Process leaves from a memory location it forms a HOLE surrounded by other process allocations.

- We can avoid External Fragmentation by **Compaction**

> [!NOTE] Compaction
> Taking Empty space to one side and remaining using space to another side.
## Problem of Compaction 
For Compaction we have to stop the running processes in running time and copy-paste from one location to another.

## Allocation/Deallocation is Complex
If Hole are formed deciding where to allocate is a bit complex
this is more complex if processes are more as more holes can be generated.
