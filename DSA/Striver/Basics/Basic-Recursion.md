
---
type: DSA 
topic: basics
---


> [!example] Contents 
> - [[#Problem Factorial of a Number|Factorial of a Number]]
> - [[#Problem Reverse an Array|Reverse an Array]]
> - [[#Problem Palindrome Check (String)|Palindrome Check (String)]]
> - [[#Problem Fibonacci Series|Fibonacci Series]]




# Problem: Factorial of a Number
## Solution: 
### Iterative { O(N) , O(1) }:
```cpp
int factorial(int num){
	int ans = 1;
	for(int i = 1; i <= num; i++){
		ans *= i; 
	}
	return ans;
}
```
### Recursive { O(N) , O(N) }:
```cpp
int factorial(int num){
	//Base Case
	if(!n) return 1;

	//Recursive Case
	return n * factorial(n-1);
}
```

---
# Problem: Reverse an Array
## Solution: 
### Extra Array or Stack { O(N) , O(N) }:
```cpp
vector<int> rev_arr(vector<int> arr){
	vector<int> ans(arr.length());
	for(int i = n - 1; i >= 0; i++){
		ans[n - i - 1] = arr[i];
	}
	return ans;
}
```
### Space-optimized Iterative { O(N) , O(1) }:
```cpp
void rev_arr(vector<int> arr){
	int ptr1 = 0, ptr2 = arr.length() - 1;
	while(ptr1 < ptr2){
		swap(arr[ptr1], arr[ptr2]);
		ptr1++;
		ptr2--;
	}
}
```
### Recursive { O(N) , O(1) }:
```cpp
void rev_arr(vector<int> arr, int start, int end){
	if(start < end){
		swap(arr[start], arr[end]);
		rev_arr(arr, start + 1, end - 1);
	}
}
```

---
# Problem: Palindrome Check (String)
## Solution: 
### Iterative { O(N) , O(1) }:
```cpp
bool isPalindrome(string s){
	int left = 0;
	int right = s.length() - 1;
	while(left < right){
	
	// isalnum is to check if alphanumeric
	
		if(!isalnum(s[left])) left++;
		else if(!isalnum(s[right])) right--;
		else if(tolower(s[left]) != tolower(s[right])){
			return false;
		} else {
			left++;
			right--;
		}
	}
	return true;
}
```
### Recursive { O(N) , O(1) }:
```cpp
bool isPalindrome(int i, string& s){
	// Base condition
// if i > half of string then checking is done for all
	if(i >= s.length()/2) return true;

// if start != end
	if(s[i] != s[s.length()-i-1]) return false;

// if both are same, compare start + 1 and end - 1
	return isPalindrome(i + 1, s);
}
```



# Problem: Fibonacci Series
## Solution: 

### Naive { O(N) + O(N) ~= O(N) , O(N) }:
```cpp
vector<int> fib(int n){
	vector<int> ans(n + 1);
	if(!n) ans.push_back(0);
	else if(n == 1) ans.push_back(1);
	else{
		ans[0] = 0;
		ans[1] = 1;
		for(int i = 2; i <= n; i++){
			ans[i] = ans[i - 1] + ans[i - 2];
		}
	}
	return ans;
}
```
### Recursive { O(2<sup>N</sup>) , O(N) };
```cpp
int fib(int n){
//Base case
	if(n <= 1) return n;
//Recursive case
	return fib(n-1) + fib(n-2);
}
```