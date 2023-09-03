---
type: DSA 
topic: basics
---


> [!example] Contents 
> - [[#Problem Count digits in a number|Count digits in a number]]
> - [[#Problem Reverse a number|Reverse the number]]
> - [[#Problem Palindrome Check (Number)| Palindrome Check]]
> - [[#Problem GCD of 2 Numbers|GCD of 2 Numbers]]
> - [[#Problem Check if Armstrong Number|Armstrong Number Check]]
> - [[#Problem Divisors of Number|Divisors of a Number]]
> - [[#Problem Prime Number Check|Check if Prime Number]]


# Problem: Count digits in a number
## Solution: 
### 1. Intuition { *O(N)* , *O(1)* }: 
```cpp
int count_digits(int num){
	int cnt = 0;
	while(num){
		num /= 10;
		cnt++;
	}
	return cnt;
}
```

### 2.  Logarithmic { *O(1)* , *O(1)* }:
```cpp
int count_digits(int num){
	return (log10(num) + 1);
}
```

---
# Problem: Reverse a number
## Solution:
```cpp
int rev_num(int num){
	int rev = 0;
	while(num){
		rev = rev*10 + ( num%10 );
		num /= 10;
	}
	return rev;
}
```

---
# Problem: Palindrome Check (Number)
## Solution:
### Intuition { *O(logN)* , *O(1)* }: 
if [[#Problem Reverse a number|Reversed Number]] == Original Number then true 
else false.

---
# Problem: GCD of 2 Numbers
## Solution:
### Brute Force { *O(N)* , *O(1)* }

```cpp
int gcd(int a, int b){
	int ans;
	for(int i = 1; i <= min(a, b); i++){
		if(!(a % i) && !(b % i)){
			ans = i;
		}
	}
	return ans;
}
```


### Brute Force { *O(log(min(a,b)))* , *O(1)* }
```cpp
int gcd(int a, int b){
	if(!b) return a;
	return gcd(b, a%b);
}
```

---
# Problem: Check if Armstrong Number

> [!NOTE] Armstrong Number
> Sum of { each digit <sup>number of digits</sup> } == number

## Solution:
```cpp
bool isArmstrg_Num(int n){
	int cnt = 0;
	int temp = n;
	while(temp){
		cnt++;
		temp /= 10;
	}
	int powSum = 0;
	while(n){
		powSum += pow( (n % 10) , cnt );
		n /= 10;
	}
	return powSum == n;
}
```

---
# Problem:  Divisors of Number
## Solution:

> [!NOTE] Note
> we are not considering the storage array as used space

### Brute Force { O(N) , O(1) }:
```cpp
vector<int> divisors_num(int n){
	vector<int> ans;	
	for(int i = 1; i <= n; i++){
		if(!(n % i)) ans.push_back(i);
	}
	return ans;
}
```

### Optimal { O($\sqrt{N}$  ) , O(1) }:
```cpp
vector<int> divisors_num(int n){
	vector<int> ans;	
	for(int i = 1; i <= sqrt(n); i++){
		if(!(n % i)) ans.push_back(i);
	}
	return ans;
}
```

# Problem: Prime Number Check
## Solution: 
### Brute Force { O(N) , O(1) }:
```cpp
bool isPrime(int n){
	for(int i = 2; i < n; i++){
		if(!(n % i)) return false;
	}
	return true;
}
```

### Optimal { O($\sqrt{N}$) , O(1) }:
```cpp
bool isPrime(int n){
	for(int i = 2; i < sqrt(n); i++){
		if(!(n % i)) return false;
	}
	return true;
}
```