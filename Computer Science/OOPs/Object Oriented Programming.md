
---
type: comp-sci
file_t: database
name: oops
---
#### **What is Object Oriented Programming?**
**O**bject **O**riented **P**rogramming (OOP) is a programming paradigm where the complete software operates as a bunch of objects talking to each other. An object is a collection of data and methods that operate on its data.

#### **Why OOP?** 
The main advantage of OOP is better manageable code that covers following. 

1) The overall understanding of the software is increased as the distance between the language spoken by developers and that spoken by users.   
2) Object orientation eases maintenance by the use of encapsulation.   One can easily change the underlying representation by keeping the methods same.   
OOP paradigm is mainly useful for relatively big software.


#### **What are main features of OOP?**   
Encapsulation   
Polymorphism   
Inheritance











#### **What is encapsulation?**   
Encapsulation is referred to one of the following two notions.   
1) Data hiding: A language feature to restrict access to members of an object. For example, private and protected members in C++.   
2) Bundling of data and methods together: Data and methods that operate on that data are bundled together.

#### **What is Polymorphism? How is it supported by C++?**   
Polymorphism means that some code or operations or objects behave differently in different contexts. In C++,  following features support polymorphism. 

_Compile Time Polymorphism:_ Compile time polymorphism means compiler knows which function should be called when a polymorphic call is made.  C++ supports compiler time polymorphism by supporting features like templates, function overloading and default arguments. 

_Run Time Polymorphism:_ Run time polymorphism is supported by virtual functions_._ The idea is, [virtual functions](http://en.wikipedia.org/wiki/Virtual_function) are called according to the type of object pointed or referred, not according to the type of pointer or reference. In other words, virtual functions are resolved late, at runtime.
#### **What is** [**Inheritance**](http://en.wikipedia.org/wiki/Inheritance_%28object-oriented_programming%29)**? What is the purpose?**   
The idea of inheritance is simple, a class is based on another class and uses data and implementation of the other class.   
The purpose of inheritance is Code Reuse.
#### **What is Abstraction?**   
Abstraction is similar to data encapsulation and very important in OOP. It shows only the necessary information and hides the other irrelevant information. Abstraction is implemented using Abstraction classes and interfaces . The problems in Abstraction are solved at design or interface level.
#### **What is Constructor?**

Constructor is a block of code that initializes the newly created object. A constructor resembles an instance method in java but it’s not a method as it doesn’t have a return type.
#### **What are Manipulators?**

Manipulators are the functions which can be used in conjunction with the insertion (<<) and extraction (>>) operators on an object. Examples are endl and setw.
#### **What is destructor?**

A destructor is a method which is automatically called when the object is made of scope or destroyed. Destructor name is also same as class name but with the tilde symbol before the name.