---
type: leetcode
date: Tuesday-22-8-2023
---

# Problem: 
Given an *Integer,* Return its corresponding *String* as it appears in **Excel Sheets**

## Tags: #math #string
### TestCases
Example 1: 
- **Input:** columnNumber = 1
- **Output:** "A"
Example 2: 
- **Input:** columnNumber = 28
- **Outpur:** "AB"
Example 3: 
- **Input:** columnNumber = 701
- **Output:** "ZY"
### Constraints: 
- 1 <= columnNumber <= 2<sup>31</sup> - 1
---
## Solution:
### Intuition:

```cpp
string convertToTitle(int columnNumber){
	string ans = "string";
	while(columnNumber) {
		columnNumber--;

		// Get the last Character and append at the end

		int d = columnNumber % 26l;
		columnNumber /= 26;
		str.push_back(char('A' + d));
	}

// as the order is in reverse 
	reverse(str.begin(), str.end());
	return str;
}
```
#### Time Complexity: O(logN)
#### Space Complexity: O(1)