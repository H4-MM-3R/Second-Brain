
> [!NOTE] VM
> Creating Illusion than Process of Memory larger than Main Memory can be executed.

![[Virtual_Memory_image.png]]

Like non-continuos memory allocation
> we pre load the starting pages of the processes after the execution is complete
> the pages are replaced by remaining pages.

# Page Fault
If the CPU demands a page but it is missing in the Main Memory.
Which means VALID BIT is equal to zero.

Then, Trap is generated which Context-Switching Occurs.


> [!NOTE] Context-Switching
> Changing of control from User to OS after a Trap is Generated.
> Means the process being executed goes to ready state and loading a different process in running state.

