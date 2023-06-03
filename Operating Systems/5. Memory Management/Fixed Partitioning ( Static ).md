- No . of partitions are fixed.
- Size of each Partition may / maynot be same.
- Contiguos Allocation so, Spanning is not allowed.

> [!NOTE] Spanning
> Entire Process should be in one Partition.
> (not like some part in one partition and remaining in another)

# Limitations :
## Internal Fragmentation :
" Space is Left unused"
If a partition is of 4 MB and Process is of 2 MB then 2 MB is not used / wasted.
This is Internal Fragementation.

## Limit in Process Size :
if Process size is larger than any of the partition size.

## Limitation on Multiprogramming
We cant bring more processes as No.of Partitions are already fixed.

## External Fragmentation :
" no allocation even if space exists "
Even if total remaining size from each partition at different locations is sufficient for a upcoming Process , we cant allocate because of contiguos method.