---
type: intro
---

> we use Fork System Call to *create* a [[#^3b7796 |Child Process]]

#### Example : 
```c
main(){
printf("Hello world");
}
```
> Output : Hello World

```c
main(){
fork();
printf("Hello world");
}
```
> Output : 
> Hello World
> Hello World

```c
main(){
fork();
fork();
printf("Hello world");
}
```
> Output : 
> Hello World
> Hello World
> Hello World
> Hello World

![[Fork()-drw | 800]]

> [!NOTE] Child Process
> Clone of a Process with its own ID, own registers, own values

^3b7796
