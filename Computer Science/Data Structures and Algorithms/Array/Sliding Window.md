
# INDEX
> - [[#^763e65|Templates]]
> - [[#^42bf38 | Problems]]



> [!example] Templates
> - [[#Template 1 Shrinkable Sliding Window]]
> - [[#Template 2 Non-shrinkable Sliding Window]]

^763e65


# Find Maximum Window
## Template 1: Shrinkable Sliding Window

```cpp
int i = 0, j = 0, ans = 0;
for (; j < N; ++j) {
    // CODE: 
// use A[j] to update state which might make the window invalid

// when invalid, keep shrinking the left edge until it's valid 
    for (; invalid(); ++i) { 
        // CODE: 
        // update state using A[i]
    }
    ans = max(ans, j - i + 1);
// the window [i, j] is the maximum window we've found thus far 
}
return ans;
```

Essentially, we want to **keep the window valid** at the end of each *outer* `for` *loop.*

Let's apply this template to [1838. Frequency of the Most Frequent Element (Medium)](https://leetcode.com/problems/frequency-of-the-most-frequent-element/)
1. What should we use as the `state` ? It should be the sum of numbers in the window.
2. How to determine `invalid` ? The window is invalid if `(j - i + 1) * A[j] - sum > k`.
		`(j - i + 1)` is the length of the window `[i, j]`. We want to increase all the numbers in the window to equal  `A[j]`,  the number of operations needed is `(j - i + 1) * A[j] - sum` which should be `<= k`. For example, assume the window is `[1,2,3]`, increasing all the numbers to `3` will take `3 * 3 - (1 + 2 + 3)` operations.

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int maxFrequency(vector<int>& A, int k) {
        sort(begin(A), end(A));
        long i = 0, N = A.size(), ans = 1, sum = 0;
        for (int j = 0; j < N; ++j) {
            sum += A[j];
            while ((j - i + 1) * A[j] - sum > k) sum -= A[i++];
            ans = max(ans, j - i + 1);
        }
        return ans;
    }
};
```

## Template 2: Non-shrinkable Sliding Window
```cpp
int i = 0, j = 0;
for (; j < N; ++j) {
   // CODE: 
   // use A[j] to update state which might make the window invalid
    
    // Increment the left edge ONLY when the window is invalid. 
   // In this way, the window GROWs when it's valid, 
   // and SHIFTs when it's invalid
    if (invalid()) { 
        // CODE:
        // update state using A[i]
        ++i;
    }
    // after `++j` in the for loop, 
    // this window `[i, j)` of length `j - i` MIGHT be valid.
}
// There must be a maximum window of size `j - i`.kj
	return j - i; 
```

Essentially, we GROW the window when it's valid, and SHIFT the window when it's invalid.

Note that there is only a SINGLE `for` loop now!

Let's apply this template to [1838. Frequency of the Most Frequent Element (Medium)](https://leetcode.com/problems/frequency-of-the-most-frequent-element/) again.

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int maxFrequency(vector<int>& A, int k) {
        sort(begin(A), end(A));
        long i = 0, j = 0, N = A.size(), sum = 0;
        for (; j < N; ++j) {
            sum += A[j];
            if ((j - i + 1) * A[j] - sum > k) sum -= A[i++];
        }
        return j - i;
    }
};
```

## --- Apply these Templates to other problems ---

---
[1493. Longest Subarray of 1's After Deleting One Element (Medium)](https://leetcode.com/problems/longest-subarray-of-1s-after-deleting-one-element/)
### Sliding Window (Shrinkable)

1. What's `state`? `cnt` as the number of `0`s in the window.
2. What's `invalid`? `cnt > 1` is invalid.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestSubarray(vector<int>& A) {
        int i = 0, j = 0, N = A.size(), cnt = 0, ans = 0;
        for (; j < N; ++j) {
            cnt += A[j] == 0;
            while (cnt > 1) cnt -= A[i++] == 0;


// note that the window is of size `j - i + 1`.
// We use `j - i` here because we need to delete a number.
            ans = max(ans, j - i); 
        }
        return ans;
    }
};
```

### Sliding Window (Non - Shrinkable)

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestSubarray(vector<int>& A) {
        int i = 0, j = 0, N = A.size(), cnt = 0;
        for (; j < N; ++j) {
            cnt += A[j] == 0;
            if (cnt > 1) cnt -= A[i++] == 0;
        }
        return j - i - 1;
    }
};
```

---
[3. Longest Substring Without Repeating Characters (Medium)](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
### Sliding Window (Shrinkable)

1.  `state`: `cnt[ch]` is the number of occurrence of character `ch` in window.
2.  `invalid`: `cnt[s[j]] > 1` is invalid.
```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int i = 0, j = 0, N = s.size(), ans = 0, cnt[128] = {};
        for (; j < N; ++j) {
            cnt[s[j]]++;
            while (cnt[s[j]] > 1) cnt[s[i++]]--;
            ans = max(ans, j - i + 1);
        }
        return ans;
    }
};
```

**Sliding Window (Non-shrinkable)**

Note that since the non-shrinkable window might include multiple duplicates, we need to add a variable to our state.

1. `state`: `dup` is the number of different kinds of characters that has duplicate in the window. For example, if window contains `aabbc`, then `dup = 2` because `a` and `b` has duplicates.
2. `invalid`: `dup > 0` is invalid.
```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int i = 0, j = 0, N = s.size(), cnt[128] = {}, dup = 0;
        for (; j < N; ++j) {
            dup += ++cnt[s[j]] == 2;
            if (dup) dup -= --cnt[s[i++]] == 1;
        }
        return j - i;
    }
};
```

---
[713. Subarray Product Less Than K (Medium)](https://leetcode.com/problems/subarray-product-less-than-k/)

### Sliding Window (Shrinkable)

- `state`: `prod` is the product of the numbers in window
- `invalid`: `prod >= k` is invalid.

Note that since we want to make sure the window `[i, j]` is valid at the end of the `for` loop, we need `i <= j` check for the inner `for` loop. `i == j + 1` means this window is empty.

Each maximum window `[i, j]` can generate `j - i + 1` valid subarrays, so we need to add `j - i + 1` to the answer

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int numSubarrayProductLessThanK(vector<int>& A, int k) {
        if (k == 0) return 0;
        long i = 0, j = 0, N = A.size(), prod = 1, ans = 0;
        for (; j < N; ++j) {
            prod *= A[j];
            while (i <= j && prod >= k) prod /= A[i++];
            ans += j - i + 1;
        }
        return ans;
    }
};
```

The **non-shrinkable template** is not applicable here since we need to the length of each maximum window ending at each position.

## Find Minimum Window

```cpp
int i = 0;
for (int j = 0; j < N; j++){
	// use A[j] to update state.
	while(valid()){
		ans = min(ans, j - i + 1);
		// use A[i] to update state
		++i;
	}
}
```

# Problems

> [!example] Problem Topics
> - [[#Find Minimum]]
> - [[#Find Maximum]]
> - [[#At Most to Equal]]
> - [[#Find Minimum and Maximum]]
> - [[#Fixed-length Sliding Window]]

^42bf38



### Find Minimum
- [[#[Minimum Window Substring](https //leetcode.com/problems/minimum-window-substring)|Minimum Window Substring]]
- [[#[Minimum Size Subarray Sum](https //leetcode.com/problems/minimum-size-subarray-sum)|Minimum Size Subarray Sum]]

# [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring)

Given two strings `s` and `t` of lengths `m` and `n` respectively, return the **minimum window substring** of `s` such that every character in `t` (**including duplicates**) is included in the window. If there is no such substring, return the _empty string_ `""`.

The testcases will be generated such that the answer is **unique**.
#### Difficulty : `Hard`
#### Tags : #hash #string #slidWind

> [!faq] Follow up
> Could you find an algorithm that runs in `O(m + n)` time?

## Minimum Sliding Window

```cpp
// Time: O(M+N)
// Space: O(C) where C is the range of characters
class Solution {
public:
    string minWindow(string s, string t) {
        int M = s.size(), N = t.size(), cnt[128] = {}; 
        int matched = 0;
        int minLen = INT_MAX, start = -1;
        for (char c : t) cnt[c]++;
        for (int i = 0, j = 0; j < M; ++j) {
            matched += cnt[s[j]]-- > 0;
            while (matched >= N) {
                if (j - i + 1 < minLen) {
                    minLen = j - i + 1;
                    start = i;
                }
                matched -= ++cnt[s[i++]] > 0;
            }
        }
        return start == -1 ? "" : s.substr(start, minLen);
    }
};
```

---

# [Minimum Size Subarray Sum](https://leetcode.com/problems/minimum-size-subarray-sum)
#### Difficulty : `Medium`
#### Tags : #array #binSrch #slidWind #prefSum 
Given an *array* of positive integers `nums` and a positive integer `target`, return the **minimal length** of a *subarray*

whose *sum* is **greater than** or **equal** to `target`. If there is no such *subarray,* return `0` instead.


> [!faq] Follow up
> If you have figured out the `O(n)` solution, try coding another solution of which the time complexity is `O(n log(n))`.

## Sliding Window

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minSubArrayLen(int s, vector<int>& nums) {
        int sum = 0, i = 0, j = 0, N = nums.size(), ans = INT_MAX;
        while (j < N) {
            while (j < N && sum < s) sum += nums[j++];
            if (sum < s) break;
            while (i < j && sum >= s) sum -= nums[i++];
            ans = min(ans, j - i + 1);
        }
        return ans == INT_MAX ? 0 : ans;
    }
};
```

## Sliding Window

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& A) {
        int sum = 0, N = A.size(), i = 0, j = 0, ans = INT_MAX;
        while (j < N) {
            sum += A[j++];
            while (sum >= target) {
                ans = min(ans, j - i);
                sum -= A[i++];
            }
        }
        return ans == INT_MAX ? 0 : ans;
    }
};
```

## Binary Search

`valid(len)` returns true if whether there exists a subarray of length `len` that has sum greater than or equal to `target`.

We binary search the length range `[1, N]` because this predicate `valid(len)` is monotonic. That is, there must exist an index `K` that for any `len >= K`, `valid(len)` is true; and for any `len < K`, `valid(len)` is false.

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& A) {
        int N = A.size(), L = 1, R = N;
        auto valid = [&](int len) {
            int sum = 0;
            for (int i = 0; i < N; ++i) {
                sum += A[i];
                if (i - len >= 0) sum -= A[i - len];
                if (sum >= target) return true;
            }
            return false;
        };
        while (L <= R) {
            int M = (L + R) / 2;
            if (valid(M)) R = M - 1;
            else L = M + 1;
        }
        return L > N ? 0 : L;
    }
};
```
---
### Find Maximum
- [[#[Longest Substring Without Repeating Characters](https //leetcode.com/problems/longest-substring-without-repeating-characters/)|Longest Substring Without Repeating Characters]]
- [[#[Longest Substring with At Most Two Distinct Characters](https //leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/)|Longest Substring with At Most Two Distinct Characters]]
- [[#[Longest Substring with At Most K Distinct Characters](https //leetcode.com/problems/longest-substring-with-at-most-k-distinct-characters)|Longest Substring with At Most K Distinct Characters]]
- [[#[Longest Repeating Character Replacement](https //leetcode.com/problems/longest-repeating-character-replacement/)|Longest Repeating Character Replacement]] 
- [[#[Find Permutation](https //leetcode.com/problems/find-permutation)|Find Permutation]]
- [[#[Subarray Product Less Than K](https //leetcode.com/problems/subarray-product-less-than-k/)|Subarray Product Less Than K]] 
- [[#[Max Consecutive Ones III](https //leetcode.com/problems/max-consecutive-ones-iii/)|Max Consecutive Ones III]]
- [[#[Get Equal Substrings Within Budget](https //leetcode.com/problems/get-equal-substrings-within-budget/)|Get Equal Substrings Within Budget]]
- [[#[Longest Subarray of 1's After Deleting One Element](https //leetcode.com/problems/longest-subarray-of-1s-after-deleting-one-element)|Longest Subarray of 1's After Deleting One Element]]
- [[#[Minimum Operations to Reduce X to Zero](https //leetcode.com/problems/minimum-operations-to-reduce-x-to-zero/)|Minimum Operations to Reduce X to Zero]]
- [[#[Maximum Erasure Value](https //leetcode.com/problems/maximum-erasure-value/)|Maximum Erasure Value]]
- [[#[Frequency of the Most Frequent Element](https //leetcode.com/problems/frequency-of-the-most-frequent-element/)|Frequency of the Most Frequent Element]]
- [[#[Minimum Number of Operations to Make Array Continuous](https //leetcode.com/problems/minimum-number-of-operations-to-make-array-continuous/)|Minimum Number of Operations to Make Array Continuous]]
- [[#[Maximize the Confusion of an Exam](https //leetcode.com/problems/maximize-the-confusion-of-an-exam)|Maximize the Confusion of an Exam]]

# [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

####  Difficulty : `Medium`
#### Tags : #hash #2ptr #string #slidWind 

Given a string, find the length of the **longest substring** without repeating characters.

## Hash Map

```cpp
// Time: O(N)
// Space: O(C) where C is the range of character set
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int ans = 0, start = -1;
        vector<int> m(128, -1);
        for (int i = 0; i < s.size(); ++i) {
            start = max(start, m[s[i]]);
            m[s[i]] = i;
            ans = max(ans, i - start);
        }
        return ans;
    }
};
```

## Sliding Window

### Shrinkable Sliding Window:
```cpp
// Time: O(N)
// Space: O(C)
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int i = 0, j = 0;
        int N = s.size();
        int cnt[128] = {};
        int dup = 0, ans = 0;
        while (j < N) {
            dup += ++cnt[s[j++]] == 2;
            while (dup) dup -= --cnt[s[i++]] == 1;
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```
### Non-shrinable Sliding Window:

```cpp
// Time: O(N)
// Space: O(C)
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int i = 0, j = 0;
        int N = s.size();
        int cnt[128] = {}, dup = 0;
        while (j < N) {
            dup += ++cnt[s[j++]] == 2;
            if (dup) dup -= --cnt[s[i++]] == 1;
        }
        return j - i;
    }
};
```

---
# [Longest Substring with At Most Two Distinct Characters](https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/)
#### Difficulty : `Medium`
#### Tags : #hash #string #slidWind 

Given a string `s`, return _the length of the longest substring that contains at most **two distinct characters**_.

## Sliding Window

### Shrinkable Sliding Window:
```cpp
// Time: O(N)
// Space: O(C) 
class Solution {
public:
    int lengthOfLongestSubstringTwoDistinct(string s) {
        vector<int> m(128, 0);
        int i = 0, j = 0, ans = 0, cnt = 0;
        while (j < s.size()) {
            if (m[s[j++]]++ == 0) ++cnt;
            while (cnt > 2) {
                if (m[s[i++]]-- == 1) --cnt;
            }
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```
### Non-shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(C)
class Solution {
public:
    int lengthOfLongestSubstringTwoDistinct(string s) {
        int distinct = 0;
        int cnt[128] = {};
        int N = s.size(), i = 0, j = 0;
        while (j < N) {
            distinct += ++cnt[s[j++]] == 1;
            if (distinct > 2){
	            distinct -= --cnt[s[i++]] == 0;
            } 
        }
        return j - i;
    }
};
```

---
# [Longest Substring with At Most K Distinct Characters](https://leetcode.com/problems/longest-substring-with-at-most-k-distinct-characters)

#### Difficulty : `Medium`
#### Tags : #hash #string #slidWind 

Given a *string* `s` and an *integer* `k`, return the **length** of the longest *substring* of `s` that contains **at most** `k` **distinct** *characters.*

## Sliding Window

### Shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int lengthOfLongestSubstringKDistinct(string s, int k) {
        int cnt[128] = {};
        int distinct = 0, i = 0, j = 0, ans = 0, N = s.size();
        while (j < N) {
            distinct += cnt[s[j++]]++ == 0;
            while (distinct > k) distinct -= --cnt[s[i++]] == 0;
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```
### Non-shrinkable Sliding Window:
```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int lengthOfLongestSubstringKDistinct(string s, int k) {
        int cnt[128] = {};
        int distinct = 0, i = 0, j = 0, N = s.size();
        while (j < N) {
            distinct += cnt[s[j++]]++ == 0;
            if (distinct > k) distinct -= --cnt[s[i++]] == 0;
        }
        return j - i;
    }
};
```

# [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
####  Difficulty : `Medium`
#### Tags : #hash #string #slidWind 

You are given a *string* `s` and an *integer* `k`. You can choose any *character* of the *string* and **change** it to any other **uppercase English character**. You can perform this *operation* **at most** `k` times.

Return the *length* of the *longest substring* containing the **same letter** you can get after performing the above operations.

## Sliding Window

### Shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int characterReplacement(string s, int k) {
        int i = 0, j = 0, cnt[26] = {}, ans = 0, N = s.size();
        while (j < N) {
            cnt[s[j++] - 'A']++;
            while (j - i - *max_element(cnt, cnt + 26) > k){
	             cnt[s[i++] - 'A']--;
            }
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```
### Non-shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int characterReplacement(string s, int k) {
        int i = 0, j = 0, cnt[26] = {}, N = s.size();
        while (j < N) {
            cnt[s[j++] - 'A']++;
            if (j - i - *max_element(cnt, cnt + 26) > k){
	             cnt[s[i++] - 'A']--;
            }
        }
        return j - i;
    }
};
```

## Sliding Window

### Shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int characterReplacement(string s, int k) {
        int ans = 0, N = s.size();
        auto count = [&](char c) {
            int i = 0, j = 0, cnt = 0, ans = 0;
            for (; j < N; ++j) {
                cnt += s[j] != c;
                while (cnt > k) cnt -= s[i++] != c;
                ans = max(ans, j - i + 1);
            }
            return ans;
        };
        for (char c = 'A'; c <= 'Z'; ++c){
			  ans = max(ans, count(c));     
		} 
        return ans;
    }
};
```

### Non-shrinkable sliding window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int characterReplacement(string s, int k) {
        int ans = 0, N = s.size();
        auto count = [&](char c) {
            int i = 0, j = 0, cnt = 0, ans = 0;
            for (; j < N; ++j) {
                cnt += s[j] != c;
                if (cnt > k) cnt -= s[i++] != c;
            }
            return j - i;
        };
        for (char c = 'A'; c <= 'Z'; ++c){
	        ans = max(ans, count(c));
        } 
        return ans;
    }
};
```

---
# [Find Permutation](https://leetcode.com/problems/find-permutation)
#### Difficulty : `Medium`
#### Tags : #array #string #stack #greedy 

A permutation `perm` of `n` integers of all the integers in the range `[1, n]` can be represented as a string `s` of length `n - 1` where:

- `s[i] == 'I'` if `perm[i] < perm[i + 1]`, and
- `s[i] == 'D'` if `perm[i] > perm[i + 1]`.

Given a string `s`, reconstruct the lexicographically smallest permutation `perm` and return it.

## Solution 1

```cpp
// Time: O(N^2)
// Space: O(1)
class Solution {
public:
    vector<int> findPermutation(string s) {
        vector<int> ans{1};
        for (char c : s) {
            if (c == 'D') {
                ans.push_back(ans.back());
                for (int i = ans.size() - 2; i >= 0 &&
                 ans[i] == ans[i + 1]; --i){
	                 ans[i]++;
                 } 
            } else {
                ans.push_back(ans.size() + 1);
            }
        }
        return ans;
    }
};
```

## Solution 2

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> findPermutation(string s) {
        int N = s.size(), mx = 0, d = s[0] == 'D';
        vector<int> cnt;
        for (int i = 0; i < N;) {
            int start = i++;
            while (i < N && s[i] == s[i - 1]) ++i;
            cnt.push_back(i - start);
        }
        vector<int> ans;
        for (int i = 0; i < cnt.size(); ++i) {
            int c = cnt[i];
            if (ans.empty()) ++c;
            if (d) {
                int n = ans.empty() ? c : mx - 1;
                mx = max(n, mx);
                for (int j = 0; j < c; ++j) ans.push_back(n--);
            } else {
                int n = mx + 1;
                for (int j = 0; j < c; ++j) ans.push_back(n++);
                if (i < cnt.size() - 1) ans.back() += cnt[i + 1];
                mx = ans.back();
            }
            d = 1 - d;
        }
        return ans;
    }
};
```
---
# [Subarray Product Less Than K](https://leetcode.com/problems/subarray-product-less-than-k/)
#### Difficylty : `Medium`
#### Tags : #array #2ptr 

Your are given an array of positive integers `nums`.

Count and print the number of (contiguous) subarrays where the product of all the elements in the subarray is less than `k`.

## Shrinkable Sliding Window

- `state`: `prod` is the product of the numbers in window
- `invalid`: `prod >= k` is invalid.

Note that since we want to make sure the window `[i, j]` is valid at the end of the `for` loop, we need `i <= j` check for the inner `for` loop. `i == j + 1` means this window is empty.

Each maximum window `[i, j]` can generate `j - i + 1` valid subarrays, so we need to add `j - i + 1` to the answer.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int numSubarrayProductLessThanK(vector<int>& A, int k) {
        if (k == 0) return 0;
        long i = 0, j = 0, N = A.size(), prod = 1, ans = 0;
        for (; j < N; ++j) {
            prod *= A[j];
            while (i <= j && prod >= k) prod /= A[i++];
            ans += j - i + 1;
        }
        return ans;
    }
};
```

---
# [Max Consecutive Ones III](https://leetcode.com/problems/max-consecutive-ones-iii/)

#### Difficulty : `Medium`
#### Tags : #array #binSrch #slidWind #prefSum 

Given a binary array `nums` and an integer `k`, return _the maximum number of consecutive_ `1`_'s in the array if you can flip at most_ `k` `0`'s.

## Sliding Window

### Shrinkable sliding window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestOnes(vector<int>& A, int k) {
        int i = 0, j = 0, cnt = 0, N = A.size(), ans = 0;
        while (j < N) {
            cnt += A[j++] == 0;
            while (cnt > k) cnt -= A[i++] == 0;
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```

### Non-shrinkable sliding window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestOnes(vector<int>& A, int k) {
        int i = 0, j = 0, cnt = 0, N = A.size();
        while (j < N) {
            cnt += A[j++] == 0;
            if (cnt > k) cnt -= A[i++] == 0;
        }
        return j - i;
    }
};
```
---

# [Get Equal Substrings Within Budget](https://leetcode.com/problems/get-equal-substrings-within-budget/)

#### Difficulty : `Medium`
#### Tags : #string #binSrch #slidWind #prefSum 

You are given two strings `s` and `t` of the same length. You want to change `s` to `t`. Changing the `i`-th character of `s` to `i`-th character of `t` costs `|s[i] - t[i]|` that is, the absolute difference between the ASCII values of the characters.

You are also given an integer `maxCost`.

Return the maximum length of a substring of `s` that can be changed to be the same as the corresponding substring of `t`with a cost less than or equal to `maxCost`.

## Sliding Window

### Shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int equalSubstring(string s, string t, int maxCost) {
        int i = 0, j = 0, N = s.size(), cost = 0, ans = 0;
        for (; j < N; ++j) {
            cost += abs(s[j] - t[j]);
            for (; cost > maxCost; ++i) cost -= abs(s[i] - t[i]);
            ans = max(ans, j - i + 1);
        }
        return ans;
    }
};
```

### Non-shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int equalSubstring(string s, string t, int maxCost) {
        int i = 0, j = 0, N = s.size(), cost = 0;
        for (; j < N; ++j) {
            cost += abs(s[j] - t[j]);
            if (cost > maxCost) {
                cost -= abs(s[i] - t[i]);
                ++i;
            }
        }
        return j - i;
    }
};
```

---
# [Longest Subarray of 1's After Deleting One Element](https://leetcode.com/problems/longest-subarray-of-1s-after-deleting-one-element)

#### Difficulty : `Medium`
#### Tags : #array #dp #slidWind 

Given a binary array `nums`, you should delete one element from it.

Return _the size of the longest non-empty subarray containing only_ `1`_'s in the resulting array_. Return `0` if there is no such subarray.
## Solution 1

`prev2` and `prev` are the indexes of the non-one values we've seen most recently during scanning.

```
prev2              prev            i
  0       1 1 1     0      1 1 1   0 
```

If the array only contains 1, then return `N - 1`. Otherwise, the answer is the maximum of `i - prev2 - 2`.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestSubarray(vector<int>& A) {
        int N = A.size(), prev2 = -1, prev = -1, ans = 0;
        for (int i = 0; i <= N; ++i) {
            if (i < N && A[i] == 1) continue;
            if (i == N && prev == -1) return N - 1;
            if (prev != -1) ans = max(ans, i - prev2 - 2);
            prev2 = prev;
            prev = i;
        }
        return ans;
    }
};
```

## Sliding Window

### Shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestSubarray(vector<int>& A) {
        int i = 0, j = 0, N = A.size(), cnt = 0, ans = 0;
        for (; j < N; ++j) {
            cnt += A[j] == 0;
            while (cnt > 1) cnt -= A[i++] == 0;
            ans = max(ans, j - i);
        }
        return ans;
    }
};
```

### Non-shrinkable Sliding Window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int longestSubarray(vector<int>& A) {
        int i = 0, j = 0, N = A.size(), cnt = 0;
        for (; j < N; ++j) {
            cnt += A[j] == 0;
            if (cnt > 1) cnt -= A[i++] == 0;
        }
        return j - i - 1;
    }
};
```
---
# [Minimum Operations to Reduce X to Zero](https://leetcode.com/problems/minimum-operations-to-reduce-x-to-zero/)
#### Difficulty : `Medium`
#### Tags : #2ptr #binSrch #greedy 

You are given an integer array `nums` and an integer `x`. In one operation, you can either remove the leftmost or the rightmost element from the array `nums` and subtract its value from `x`. Note that this **modifies** the array for future operations.

Return _the **minimum number** of operations to reduce_ `x` _to **exactly**_ `0` _if it's possible__, otherwise, return_ `-1`.

**Related Topics**:  
[Two Pointers](https://leetcode.com/tag/two-pointers/), [Binary Search](https://leetcode.com/tag/binary-search/), [Greedy](https://leetcode.com/tag/greedy/)

## Two pointers

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minOperations(vector<int>& A, int x) {
        int N = A.size();
        int i = 0, j = N - 1, left = 0, right = 0, ans = N + 1;
        for (; i < N && left < x; ++i) left += A[i];
        if (left < x) return -1;
        if (left == x) ans = i;
        while (i > 0) {
            left -= A[--i];
            while (left + right < x) right += A[j--];
            if (left + right == x) ans = min(ans, i + N - 1 - j);
        }
        return ans == N + 1 ? -1 : ans;
    }
};
```

## Find Maximum Sliding Window

This problem is equivalent to "finding the longest subarray that sums to `sum(A) - target`."

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minOperations(vector<int>& A, int x) {
        int N = A.size();
        int i = 0, j = 0;
        int sum = 0, target = accumulate(begin(A), end(A)
, 0) - x, maxLen = -1;
        if (target < 0) return -1;
        for (; j < N; ++j) {
            sum += A[j];
            while (sum > target) sum -= A[i++];
            if (sum == target) maxLen = max(maxLen, j - i + 1);
        }
        return maxLen == -1 ? -1 : (N - maxLen);
    }
};
```
---
# [Maximum Erasure Value](https://leetcode.com/problems/maximum-erasure-value/)

#### Difficulty : `Medium`
#### Tags : #array #hash #slidWind 

You are given an array of positive integers `nums` and want to erase a subarray containing **unique elements**. The **score** you get by erasing the subarray is equal to the **sum** of its elements.

Return _the **maximum score** you can get by erasing **exactly one** subarray._

An array `b` is called to be a subarray of `a` if it forms a contiguous subsequence of `a`, that is, if it is equal to `a[l],a[l+1],...,a[r]` for some `(l,r)`.
## Shrinkable Sliding Window + Hash Map

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int maximumUniqueSubarray(vector<int>& A) {
// window [i, j] is a window which only contains unique elements.
        int i = 0, ans = 0, N = A.size(); 


// number -> index of last occurrence.
        unordered_map<int, int> m; 
        vector<int> sum(N + 1);
        partial_sum(begin(A), end(A), begin(sum) + 1);
        for (int j = 0; j < N; ++j) {
            if (m.count(A[j])) i = max(i, m[A[j]] + 1);
            m[A[j]] = j;
            ans = max(ans, sum[j + 1] - sum[i]);
        }
        return ans;
    }
};
```

## Shrinkable Sliding Window + Hash Set

```cpp
// Time: O(N)
// Space: O(U) where U is the number of unique elements in `A`
class Solution {
public:
    int maximumUniqueSubarray(vector<int>& A) {
        int ans = 0, N = A.size(), sum = 0;
        unordered_set<int> s;
        for (int i = 0, j = 0; j < N; ++j) {
            while (s.count(A[j])) {
                s.erase(A[i]);
                sum -= A[i++];
            }
            s.insert(A[j]);
            sum += A[j];
            ans = max(ans, sum);
        }
        return ans;
    }
};
```

## Shrinkable Sliding Window + Prefix State Map

```cpp
// Time: O(N)
// Space: O(U) where U is the number of unique elements in `A`
class Solution {
public:
    int maximumUniqueSubarray(vector<int>& A) {
        int i = 0, j = 0, N = A.size(), ans = 0, dup = 0, sum = 0;
        unordered_map<int, int> cnt;
        while (j < N) {
            dup += ++cnt[A[j]] == 2;
            sum += A[j++];
            while (dup) {
                dup -= --cnt[A[i]] == 1;
                sum -= A[i++];
            }
            ans = max(ans, sum);
        }
        return ans;
    }
};
```
---
# [Frequency of the Most Frequent Element](https://leetcode.com/problems/frequency-of-the-most-frequent-element/)

####  Difficulty : `Medium`
#### Tags : #array #binSrch #greedy #slidWind #sort #prefSum 

The **frequency** of an element is the number of times it occurs in an array.

You are given an integer array `nums` and an integer `k`. In one operation, you can choose an index of `nums` and increment the element at that index by `1`.

Return _the **maximum possible frequency** of an element after performing **at most**_ `k` _operations_.
## Sliding window (Shrinkable)

Since we only care about the frequency, we can sort the array first to simplify the problem.

Let two pointers `i, j` form a window `[i, j]`. The window is valid if `(j - i + 1) * A[j] - sum <= k` where `sum` is the sum of the numbers in window `[i, j]`.

We increment `j` and update `sum`, then shrink the window by incrementing `i` until the window become valid again.

Then the window `[i, j]` with length `j - i + 1` is the maximum window we've seen so far.

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int maxFrequency(vector<int>& A, int k) {
        sort(begin(A), end(A));
        long i = 0, N = A.size(), ans = 1, sum = 0;
        for (int j = 0; j < N; ++j) {
            sum += A[j];
            while ((j - i + 1) * A[j] - sum > k) sum -= A[i++];
            ans = max(ans, j - i + 1);
        }
        return ans;
    }
};
```

## Sliding window (Non-shrinkable)

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int maxFrequency(vector<int>& A, int k) {
        sort(begin(A), end(A));
        long i = 0, j = 0, N = A.size(), sum = 0;
        for (; j < N; ++j) {
            sum += A[j];
            if ((j - i + 1) * A[j] - sum > k) sum -= A[i++];
        }
        return j - i;
    }
};
```
---
# [Minimum Number of Operations to Make Array Continuous](https://leetcode.com/problems/minimum-number-of-operations-to-make-array-continuous/)
#### Difficulty : `Hard`
#### Tags : #array #binSrch 

You are given an integer array `nums`. In one operation, you can replace **any** element in `nums` with **any** integer.

`nums` is considered **continuous** if both of the following conditions are fulfilled:

- All elements in `nums` are **unique**.
- The difference between the **maximum** element and the **minimum** element in `nums` equals `nums.length - 1`.

For example, `nums = [4, 2, 5, 3]` is **continuous**, but `nums = [1, 2, 3, 5, 6]` is **not continuous**.

Return _the **minimum** number of operations to make_ `nums` **_continuous_**.

## Sliding Window

**Intuition**: Sort and only keep unique elements. The problem is the same as "get the length of the longest subarray whose difference between min and max elements is `N - 1`".

**Algorithm**:

The brute force way is to pick each `A[i]` as the start of the subarray and count the number of elements that are `<= A[i] + N - 1`, which takes `O(N^2)` time.

Since the array is already sorted, we can use sliding window so that we only traverse the entire array once.

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int minOperations(vector<int>& A) {
        int N = A.size(), ans = N, j = 0;
        sort(begin(A), end(A));

// only keep unique elements
        A.erase(unique(begin(A), end(A)), end(A)); 
        int M = A.size();
        for (int i = 0; i < M; ++i) {

// let `j` point to the first element that is out of range--
//  `>= A[i] + N`.
            while (j < M && A[j] < A[i] + N) ++j; 

// The length of this subarray is `j - i`.
// We need to replace `N - j + i` elements to make it continuous.
            ans = min(ans, N - j + i); 
        }
        return ans;
    }
};
```

### Use Shrinkable Sliding Window Template:

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int minOperations(vector<int>& A) {
        int N = A.size(), i = 0, j = 0, ans = 0;
        sort(begin(A), end(A));

// only keep unique elements
        A.erase(unique(begin(A), end(A)), end(A)); 
        for (int M = A.size(); j < M; ++j) {

// let `i` point to the first element that is in range -- 
// `A[i] + N > A[j]`
            while (A[i] + N <= A[j]) ++i; 
            ans = max(ans, j - i + 1);
        }
        return N - ans;
    }
};
```

### Use Non-shrinkable Sliding Window Template:

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int minOperations(vector<int>& A) {
        int N = A.size(), i = 0, j = 0;
        sort(begin(A), end(A));

// only keep unique elements
        A.erase(unique(begin(A), end(A)), end(A)); 
        for (int M = A.size(); j < M; ++j) {
            if (A[i] + N <= A[j]) ++i;
        }
        return N - j + i;
    }
};
```
---

# [Maximize the Confusion of an Exam](https://leetcode.com/problems/maximize-the-confusion-of-an-exam)
#### Difficulty : `Medium`
#### Tags : #string #binSrch #slidWind #prefSum 

A teacher is writing a test with `n` true/false questions, with `'T'` denoting true and `'F'` denoting false. He wants to confuse the students by **maximizing** the number of **consecutive** questions with the **same** answer (multiple trues or multiple falses in a row).

You are given a string `answerKey`, where `answerKey[i]` is the original answer to the `ith` question. In addition, you are given an integer `k`, the maximum number of times you may perform the following operation:

- Change the answer key for any question to `'T'` or `'F'` (i.e., set `answerKey[i]` to `'T'` or `'F'`).

Return _the **maximum** number of consecutive_ `'T'`s or `'F'`s _in the answer key after performing the operation at most_ `k` _times_.

## Sliding Window

**Intuition**: Use a sliding window to get the longest substring with at most `k` `'T'` (or `'F'`).

**Algorithm**: Implement a function `count(c)` which gets the longest substring with at most `k` character `c`. The answer is `max(count('T'), count('F'))`

We can use a shrinkable sliding window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxConsecutiveAnswers(string s, int k) {
        auto count = [&](char c) {
            int N = s.size(), cnt = 0, i = 0, ans = 0;
            for (int j = 0; j < N; ++j) {
                cnt += s[j] == c;

// if there are more than `k` `c` characters,
// shrink the window until the `cnt` drops back to `k`.
                while (cnt > k) cnt -= s[i++] == c; 
                ans = max(ans, j - i + 1);
            }
            return ans;
        };
        return max(count('T'), count('F'));
    }
};
```

### use Non-shrinkable sliding window:

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxConsecutiveAnswers(string s, int k) {
        auto count = [&](char c) {
            int N = s.size(), cnt = 0, i = 0, j = 0;
            for (; j < N; ++j) {
                cnt += s[j] == c;

// If `cnt > k` we shift the window.
                if (cnt > k) cnt -= s[i++] == c; 
            }
            return j - i;
        };
        return max(count('T'), count('F'));
    }
};
```

## Binary Search

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    int maxConsecutiveAnswers(string s, int k) {
        auto count = [&](char c) {
            auto valid = [&](int len) {
                int N = s.size(), cnt = 0;
                for (int i = 0; i < N; ++i) {
                    cnt += s[i] != c;
                    if (i - len >= 0) cnt -= s[i - len] != c;
                    if (i >= len - 1 && cnt <= k) return true; 
                }
                return false;
            };
            int L = 1, R = s.size();
            while (L <= R) {
                int M = (L + R) / 2;
                if (valid(M)) L = M + 1;
                else R = M - 1;
            }
            return R;
        };
        return max(count('T'), count('F'));
    }
};
```

---
### At Most to Equal 

[[At Most to Equal#[Count Vowel Substrings of a String](https //leetcode.com/problems/count-vowel-substrings-of-a-string/)|Count Vowel Substrings of a String]]

---
### Find Minimum and Maximum

# [Subarrays with K Different Integers](https://leetcode.com/problems/subarrays-with-k-different-integers/)

#### Difficulty : `Hard`
#### Tags : #hash #2ptr #slidWind 

Given an array `A` of positive integers, call a (contiguous, not necessarily distinct) subarray of `A` _good_ if the number of different integers in that subarray is exactly `K`.

Return the number of good subarrays of `A`.
## Sliding Window

Use `[i, j)` as a sliding window to find the maximum window which contains no more than `K` unique elements.

To achieve this, we use a map `m` to store the last position of each number in the current window.

When `m.size() > K`, we should move forward `i` to shrink the window until it become valid again.

When `m.size() == K`, `[i, j)` is the maximum window we are looking for.

Within this maximum window `[i, j)`, there is a minimum window `[k, j)` containing no more than `K` unique elements. `k` is the minimal index in `m`.

Now, the number of valid subarrays in this window is `k - i + 1`.

Since `k` is monotonically increasing and must be no less than `i`, we can use `k` as a global pointer just like `i` and `j` so that the overall time complexity of moving `k` is `O(N)`.

Whenever `m.size() == K`, we can move `k` forward until `m[A[k] - '0'] == k`, and add `k - i + 1` to the answer.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int subarraysWithKDistinct(vector<int>& A, int K) {
        int ans = 0, i = 0, j = 0, k = 0, N = A.size();
        unordered_map<int, int> m;
        while (j < N) {
            m[A[j] - '0'] = j;
            ++j;
            while (m.size() > K) {
                int d = A[i++] - '0';
                if (m[d] < i) m.erase(d);
            }
            if (m.size() == K) {
                k = max(i, k);
                while (m[A[k] - '0'] != k) ++k;
                ans += k - i + 1;
            }
        }
        return ans;
    }
};
```

## Shrinkable Sliding Window

We can turn this problem into two find maximum sliding window problem: one is to find a window with at most `k` different integers, another is to find a window with at most `k - 1` different integers.

```cpp
// Time: O(N)
// Space: O(U) where U is the number of unique numbers in `A`
class Solution {
    int atMost(vector<int> &A, int k) {
        int distinct = 0, i = 0, j = 0, N = A.size(), ans = 0;
        unordered_map<int, int> cnt;
        for (; j < N; ++j) {
            distinct += ++cnt[A[j]] == 1;
            while (distinct > k) distinct -= --cnt[A[i++]] == 0;
            ans += j - i;
        }
        return ans;
    }
public:
    int subarraysWithKDistinct(vector<int>& A, int k) {
        return atMost(A, k) - atMost(A, k - 1);
    }
};
```

---
### Fixed-length Sliding Window
- [[#[Find All Anagrams in a String](https //leetcode.com/problems/find-all-anagrams-in-a-string/)|Find All Anagrams in a String]]
- [[#[Permutation in String](https //leetcode.com/problems/permutation-in-string/)|Permutation in String]]
- [[#[Find K-Length Substrings With No Repeated Characters](https //leetcode.com/problems/find-k-length-substrings-with-no-repeated-characters/)|Find K-Length Substrings With No Repeated Characters]]
- [[#[Diet Plan Performance](https //leetcode.com/problems/diet-plan-performance/)|Diet Plan Performance]]
- [[#[Check If a String Contains All Binary Codes of Size K](https //leetcode.com/problems/check-if-a-string-contains-all-binary-codes-of-size-k/)|Check If a String Contains All Binary Codes of Size K]]
- [[#[Minimum Number of Flips to Make the Binary String Alternating](https //leetcode.com/problems/minimum-number-of-flips-to-make-the-binary-string-alternating/)|Minimum Number of Flips to Make the Binary String Alternating]]
- [[#[K Radius Subarray Averages](https //leetcode.com/problems/k-radius-subarray-averages/)|K Radius Subarray Averages]]

# [Find All Anagrams in a String](https://leetcode.com/problems/find-all-anagrams-in-a-string/)
#### Difficulty : `Medium`
#### Tags : #hash #string #slidWind 

Given two strings `s` and `p`, return _an array of all the start indices of_ `p`_'s anagrams in_ `s`. You may return the answer in **any order**.

## Solution 1

```cpp
// Time: O(M + RN) where `R` is the range of characters
// Space: O(R)
class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        int target[26] = {}, cnt[26] = {};
        for (char c : p) target[c - 'a']++;
        vector<int> ans;
        for (int i = 0; i < s.size(); ++i) {
            cnt[s[i] - 'a']++;
            if (i >= p.size()) cnt[s[i - p.size()] - 'a']--;
            int j = 0;
            for (; j < 26 && target[j] == cnt[j]; ++j);
            if (j == 26) ans.push_back(i - p.size() + 1);
        }
        return ans;
    }
};
```

Or

```cpp
// Time: O(M + RN) where `R` is the range of characters
// Space: O(1)
class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        int cnt[26] = {};
        for (char c : p) cnt[c - 'a']++;
        vector<int> ans;
        for (int i = 0, N = s.size(), M = p.size(); i < N; ++i) {
            cnt[s[i] - 'a']--;
            if (i - M >= 0) cnt[s[i - M] - 'a']++;
            int j = 0;
            while (j < 26 && cnt[j] == 0) ++j;
            if (j == 26) ans.push_back(i - M + 1);
        }
        return ans;
    }
};
```

## Solution 2

```cpp
// Time: O(M + N)
// Space: O(R) where `R` is the range of characters
class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        int cnt[26] = {}, matched = 0;
        for (char c : p) cnt[c - 'a']++;
        vector<int> ans;
        for (int i = 0; i < s.size(); ++i) {
            if (--cnt[s[i] - 'a'] >= 0) ++matched;
            if (i >= p.size()
             && ++cnt[s[i - p.size()] - 'a'] > 0) --matched;
            if (matched == p.size()){
				ans.push_back(i - p.size() + 1);
			} 
        }
        return ans;
    }
};
```

---
# [Permutation in String](https://leetcode.com/problems/permutation-in-string/)
#### Difficulty : `Medium`
#### Tags : #hash #2ptr #string #slidWind 

Given two strings `s1` and `s2`, return `true` _if_ `s2` _contains a permutation of_ `s1`_, or_ `false` _otherwise_.

In other words, return `true` if one of `s1`'s permutations is the substring of `s2`.

## Fixed-length Sliding Window

Store the counts of letters of `a` in `cnts` array.

- When we consume a letter `b[i]`, we decrement its count.
- When we pop a letter `b[i - N]`, we increment its count. We start popping when `i - N >= 0` to make sure the sliding window is at most as long as `a`.

Once all the counts in `cnts` array are zeros, we return `true`. If we reached end of array and still haven't clear out the `cnts`, return `false`.

The time complexity is `O(26 * S2) = O(S2)`.

```cpp
// Time: O(B)
// Space: O(1)
class Solution {
public:
    bool checkInclusion(string a, string b) {
        if (a.size() > b.size()) return false;
        int N = a.size(), cnts[26] = {};
        for (char c : a) cnts[c - 'a']++;
        for (int i = 0; i < b.size(); ++i) {
            cnts[b[i] - 'a']--;
            if (i - N >= 0) cnts[b[i - N] - 'a']++;
            bool match = true;
            for (int j = 0; j < 26 && match; ++j) {
                if (cnts[j]) match = false;
            }
            if (match) return true;
        }
        return false;
    }
};
```

## Fixed-length Sliding Window

Similar to Solution 1, we keep a sliding window of size `a.size()`. Instead of checking the count for 26 characters, we just use a `matched` variable to store the number of matched characters within the sliding window.
```cpp
// Time: O(B)
// Space: O(1)
class Solution {
public:
    bool checkInclusion(string a, string b) {
        if (a.size() > b.size()) return false;
        int cnt[26] = {}, matched = a.size(), N = a.size();
        for (char c : a) cnt[c - 'a']++;
        for (int i = 0; i < b.size(); ++i) {
            if (i >= N) matched += cnt[b[i - N] - 'a']++ >= 0;
            matched -= cnt[b[i] - 'a']-- > 0;
            if (!matched) return true;
        }
        return false;
    }
};
```

## Variable-length Sliding Window

We keep the counts of letters of `s1` in `goal` array. And we use two pointers `i` and `j` to consume `s2`, and store the counts of letters within range `[i, j)` in `cnt` array.

1. We keep incrementing `j` and the corresponding count `cnt[s2[j]]` until it reaches the end or `cnt[s2[j]] + 1 <= goal[s2[j]]`. Let `X` be `s2[j]` then `X` is the letter we don't want to consume.
2. If the gap between `i` and `j` is the length of `s1`, then we've found match and just return `true`.
3. Since `s2[j]` is unwanted, we keep popping `s2[i]` by incrementing `i` until `s2[i] == s2[j]`, meanwhile, we decrement `cnt[s2[i]]`.
4. Now `s[i]` and `s[j]` are all pointing to the unwanted letter `X`, increment `i` and `j` both so that the `cnt[X]` will be unchanged. Go to Step 1 until `j` reaches end.

```cpp
// Time: O(S2)
// Space: O(1)
class Solution {
public:
    bool checkInclusion(string s1, string s2) {
        int M = s1.size(), N = s2.size();
        int i = 0, j = 0;
        int goal[26] = {0}, cnt[26] = {0};
        for (char c : s1) goal[c - 'a']++;
        for (; j < N; ++i, ++j) {
            while (j < N &&
             cnt[s2[j] - 'a'] + 1 <= goal[s2[j] - 'a']){
	             cnt[s2[j++] - 'a']++;
             }
            if (j - i == M) return true;
            while (j < N && i < j &&
             s2[i] != s2[j]) {
	             cnt[s2[i++] - 'a']--;
             }
        }
        return false;
    }
};
```

Or

```cpp
// Time: O(B)
// Space: O(1)
class Solution {
public:
    bool checkInclusion(string a, string b) {
        if (a.size() > b.size()) return false;
        int cnt[26] = {};
        for (char c : a) cnt[c - 'a']++;
        for (int i = 0, j = 0; j < b.size(); ++j) {

// We can't have this `b[j]` in the window
            if (--cnt[b[j] - 'a'] < 0) { 

// keep skipping until `b[i] == b[j]`
                while (b[i] != b[j]) cnt[b[i++] - 'a']++; 

// remove `b[i]` from the window
                cnt[b[i++] - 'a']++; 
            }

// If the window has the same length as `a`, return true
            if (j - i + 1 == a.size()) return true; 
        }
        return false;
    }
};
```

---
# [Find K-Length Substrings With No Repeated Characters](https://leetcode.com/problems/find-k-length-substrings-with-no-repeated-characters/)

#### Difficulty : `Medium`
#### Tags : #hash #string #slidWind 

Given a string `s` and an integer `k`, return _the number of substrings in_ `s` _of length_ `k` _with no repeated characters_.

## Fixed-length Sliding Window

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int numKLenSubstrNoRepeats(string s, int k) {
        int N = s.size(), ans = 0, cnt[26] = {}, unique = 0;
        for (int i = 0; i < N; ++i) {
            if (++cnt[s[i] - 'a'] == 1) ++unique;
            if (i - k >= 0 && --cnt[s[i - k] - 'a'] == 0){
				--unique;
			} 
            ans += unique == k;
        }
        return ans;
    }
};
```

---
# [Diet Plan Performance](https://leetcode.com/problems/diet-plan-performance/)

#### Difficulty : `Easy`
#### Tags : #array #slidWind 

A dieter consumes `calories[i]` calories on the `i`-th day. 

Given an integer `k`, for **every** consecutive sequence of `k` days (`calories[i], calories[i+1], ..., calories[i+k-1]` for all `0 <= i <= n-k`), they look at _T_, the total calories consumed during that sequence of `k` days (`calories[i] + calories[i+1] + ... + calories[i+k-1]`):

- If `T < lower`, they performed poorly on their diet and lose 1 point; 
- If `T > upper`, they performed well on their diet and gain 1 point;
- Otherwise, they performed normally and there is no change in points.

Initially, the dieter has zero points. Return the total number of points the dieter has after dieting for `calories.length` days.

Note that the total points can be negative.

## Sliding Window

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int dietPlanPerformance(
			    vector<int>& A,
			    int k,
			    int lower,
			    int upper) {
        int N = A.size(), ans = 0, sum = 0;
        for (int i = 0; i < N; ++i) {
            sum += A[i];
            if (i - k >= 0) sum -= A[i - k];
            if (i >= k - 1) {
                if (sum < lower) --ans;
                else if (sum > upper) ++ans;
            }
        }
        return ans;
    }
};
```

---
# [Check If a String Contains All Binary Codes of Size K](https://leetcode.com/problems/check-if-a-string-contains-all-binary-codes-of-size-k/)

#### Difficulty : `Medium`
#### Tags : #hash #string #bitManip #rollinghash #hashfunc

Given a binary string `s` and an integer `k`, return `true` _if every binary code of length_ `k` _is a substring of_ `s`. Otherwise, return `false`.

## NOTE

Bitwise AND has higher priority than bitwise OR according to [https://en.cppreference.com/w/cpp/language/operator_precedence](https://en.cppreference.com/w/cpp/language/operator_precedence). So

```cpp
cout << bitset<3>(0b110 | 1 & 0b11) << " " << bitset<3>(0b110 & 0b11 | 1) << endl;
// 111 011
```

For `k = 20`, there are at most `2^k ~= 1e6` binary codes.

We can use a sliding window of length `k` to scan all the binary codes that can be generated from `s`.

For `s.length = 5e5`, there are at most `5e5 - 19` codes. We can save them in a set. If the size of set becomes `2^k`, we've seen all the binary codes.

## Sliding window

We can use a sliding window to keep track of the substring of length `k`, and mark the corresponding binary representation `n` as visited. Then we check if all the numbers in range `[0, 2^k)` are visited.

```cpp
// Time: O(N + min(N, 2^K))
// Space: O(2^K)
class Solution {
public:
    bool hasAllCodes(string s, int k) {
        vector<bool> v(1 << k);
        int n = 0, mask = (1 << k) - 1;
        for (int i = 0; i < s.size(); ++i) {
            n = (n << 1) & mask | (s[i] - '0');
            if (i >= k - 1) v[n] = true;
        }
        for (int i = 0; i < (1 << k); ++i) {
            if (!v[i]) return false;
        }
        return true;
    }
};
```

Or

```cpp
// Time: O(min(N, 2^K))
// Space: O(2^K)
class Solution {
public:
    bool hasAllCodes(string s, int k) {
        vector<bool> v(1 << k);
        int mask = (1 << k) - 1, cnt = 1 << k, n = 0;
        for (int i = 0; i < s.size() && cnt; ++i) {
            n = n << 1 & mask | (s[i] - '0');
            if (i >= k - 1) {
                if (!v[n]) --cnt;
                v[n] = true;
            }
        }
        return cnt == 0;
    }
};
```

## Sliding window

Same idea as Solution 1, but using `unordered_set` to store the visited info and we just need to check the size of the set in the end.

```cpp
// Time: O(N)
// Space: O(2^K)
class Solution {
public:
    bool hasAllCodes(string s, int k) {
        unordered_set<int> st;
        int n = 0, mask = (1 << k) - 1;
        for (int i = 0; i < s.size(); ++i) {
            n = (n << 1) & mask | (s[i] - '0');
            if (i >= k - 1) st.insert(n);
            if (st.size() == (1 << k)) return true;
        }
        return false;
    }
};
```

---

# [Minimum Number of Flips to Make the Binary String Alternating](https://leetcode.com/problems/minimum-number-of-flips-to-make-the-binary-string-alternating/)

#### Difficulty : `Medium`
#### Tags : #string #greedy 

You are given a binary string `s`. You are allowed to perform two types of operations on the string in any sequence:

- **Type-1: Remove** the character at the start of the string `s` and **append** it to the end of the string.
- **Type-2: Pick** any character in `s` and **flip** its value, i.e., if its value is `'0'` it becomes `'1'` and vice-versa.

Return _the **minimum** number of **type-2** operations you need to perform_ _such that_ `s` _becomes **alternating**._

The string is called **alternating** if no two adjacent characters are equal.

- For example, the strings `"010"` and `"1010"` are alternating, while the string `"0100"` is not.

## Note

Hint 1: Only consider the case where the first character in the result string is `0`. The `1` case is symmetrical.

Hint 2: Type-1 operation basically allows us to regard `s` as a cyclic string. We can pick any index as the starting index and use its next `N` characters (including the starting index) to get the result.

## Fixed-length Sliding Window

This is a fixed-length sliding window problem on a cyclic string.

We can loop `i` in range `[0, 2N)`. Push `s[i % N]` into window and `s[i - N] (i - N >= 0)` out of the window. We keep track of the count of flips needed within the window as `cnt` and return the global minimal `cnt` as the answer.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minFlips(string s) {
        int N = s.size();
        auto solve = [&](char c) {
            int ans = INT_MAX, cnt = 0;
            for (int i = 0; i < 2 * N; ++i) {
                cnt += s[i % N] == c ^ (i % 2);
                if (i - N >= 0){
	                cnt -= s[i - N] == c ^ ((i - N) % 2);
                } 
                if (i >= N - 1) ans = min(ans, cnt);
            }
            return ans;
        };
        return min(solve('0'), solve('1'));
    }
};
```

The following is a fool-proof implementation (good to use during contest), but takes `O(N)` space.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int minFlips(string s) {
        int N = s.size(), c1 = 0, c2 = 0, ans = INT_MAX;


// simulating cyclic string
        s += s; 

// the target strings
        string x, y; 
        for (int i = 0; i < 2 * N; ++i) {
            x += i % 2 ? '1' : '0';
            y += i % 2 ? '0' : '1';
        }
        for (int i = 0; i < 2 * N; ++i) {
            c1 += x[i] != s[i];
            c2 += y[i] != s[i];
            if (i - N >= 0) {
                c1 -= x[i - N] != s[i - N];
                c2 -= y[i - N] != s[i - N];
            }
            if (i >= N - 1) ans = min({ ans, c1, c2 });
        }
        return ans;
    }
};
```

## Solution 2

Due to symmetry, if making the result string start with character `0` requires `t` steps, then making the result string start with character `1` requires `N - t` steps.

If the length of `s` is even, picking any index `j > 0` as starting index is equivalent to picking `i = 0` as the starting index and possibly flipping the target string.

For example, `s = "0110"`, if we pick `j = 1` as the starting index

```
 v
0110
1010 // target string = "0101" starts from index 1.
// this is equivalent to 
v
0110
1010 // target string = "1010" starts from index 0
```

So, if the length of `s` is even, the answer is `min(t, N - t)`.

When the length of `s` is odd, if we make `i = 1` as the starting index, we need to do the following:

1. Flip the target string. The number of steps needed to make the result string start with character `0` is now `N - t`.
2. Make adjustment for `s[i]`.

For example:

```
     s = "01101"
target = "01010"
            ---
     t = 3
// Now let index 1 be the starting index
           v
     s = "01101"
target = "00101"
// This is the same as
// Step 1:
           v
     s = "01101"
target = "10101" // flipping the original target string
     t = N - t // the number of flips is also flipped
// Step 2:
           v
     s = "01101"
target = "00101" // adjustment for s[0]
// If s[0] == '0', we need to minus 1
// If s[0] == '1', we need to plus 1.
// So, the adjustment is to plus `s[i] == '0' ? -1 : 1`.
```

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minFlips(string s) {
        int N = s.size(), t = 0;

// `t` is the number of flips needed to make the result 
// string that start with character `0`.
        for (int i = 0; i < N; ++i){
	        t += (s[i] == '0') ^ (i % 2 == 0); 
        } 


// `N - t` is the number of flips needed to make the result 
// string start with character `1`.
        int ans = min(t, N - t); 

// If `N` is even, the answer is `min(t, N - t)`.
        if (N % 2 == 0) return ans; 

// If `N` is odd, we try making `i+1` as the starting index
        for (int i = 0; i < N - 1; ++i) { 

// flipping all the target characters make t -> N - t.
// We need adjust for `s[i]`.
            t = N - t + (s[i] == '0' ? -1 : 1); 
            ans = min(ans, min(t, N - t));
        }
        return ans;
    }
};
```

---

# [K Radius Subarray Averages](https://leetcode.com/problems/k-radius-subarray-averages/)

#### Difficulty : `Medium`
#### Tags : 

You are given a **0-indexed** array `nums` of `n` integers, and an integer `k`.

The **k-radius average** for a subarray of `nums` **centered** at some index `i` with the **radius** `k` is the average of **all** elements in `nums` between the indices `i - k` and `i + k` (**inclusive**). If there are less than `k` elements before **or** after the index `i`, then the **k-radius average** is `-1`.

Build and return _an array_ `avgs` _of length_ `n` _where_ `avgs[i]` _is the **k-radius average** for the subarray centered at index_ `i`.

The **average** of `x` elements is the sum of the `x` elements divided by `x`, using **integer division**. The integer division truncates toward zero, which means losing its fractional part.

- For example, the average of four elements `2`, `3`, `1`, and `5` is `(2 + 3 + 1 + 5) / 4 = 11 / 4 = 3.75`, which truncates to `3`.

## Sliding Window

**Intuition**: Keep a fixed-length sliding window of length `2k + 1`. Slide it from left to right, and update the sum of the window on the fly.

**Algorithm**:

Let `len = 2*k + 1`.

If `N < len`, return all `-1`s directly because this array is too short to cover any window

Otherwise, loop `i` from `0` to `N-1`:

- Push `A[i]` into the window. `sum += A[i]`
- Pop `A[i-len]` out of the window. `sum -= A[i - len]`
- Assign the average value. `ans[i - k] = sum / len`.

```cpp
// Time: O(N)
// Space: O(1) extra space
class Solution {
public:
    vector<int> getAverages(vector<int>& A, int k) {

// `len` is the length of the window
        long N = A.size(), len = 2 * k + 1, sum = 0; 
        vector<int> ans(N, -1);

// If the array is too short to cover a window, return all -1s
        if (N < len) return ans; 
        for (int i = 0; i < N; ++i) {

// push A[i] into the window
            sum += A[i]; 


// pop A[i-len], if any, out of window
            if (i - len >= 0) sum -= A[i - len]; 

// the center of this window is at `i-k`
            if (i >= len - 1) ans[i - k] = sum / len; 
        }
        return ans;
    }
};
```

## Prefix Sum

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> getAverages(vector<int>& A, int k) {
        int N = A.size(), len = 2 * k + 1;
        vector<int> ans(N, -1);

// If the array is too short to cover a window, return all -1s
        if (N < len) return ans; 
        vector<long> sum(N + 1);
        for (int i = 0; i < N; ++i) sum[i + 1] = sum[i] + A[i];
        for (int i = k; i + k < N; ++i){
	         ans[i] = (sum[i + k + 1] - sum[i - k]) / len;
        }
        return ans;
    }
};
```