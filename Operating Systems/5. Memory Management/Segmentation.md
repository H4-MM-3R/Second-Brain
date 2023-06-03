in Paging, Processes are divided to pages of fixed length
irrespective of the content inside.


> [!NOTE] Segmentation
> In Segmentation, Process is divided to Segments similiar to pages 
> but segment has certain important function/method or content 
> So, Segments can be of different Lengths.

**SEGMENT TABLE**
|S.no | Base Address| Size|
|-|-|-|
|0|3300|200|
|1|1800|400|
|2|2700|600|
|3|2300|400|
|4|2200|100|
|5|1500|300|

**LOGICAL ADDRESS FROM CPU**

CPU---|
| s | d | 
|-|-|
|Segment|Segment offset|

Here, d <= segment size
If d > segment size it creates a **TRAP**.
