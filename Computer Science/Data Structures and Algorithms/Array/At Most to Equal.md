
**Exactly** `k` times = **At Most** `k` times - **At Most** `k - 1` times. ^edc5af

> [!example] Problems 
> - [[#[Binary Subarrays with Sum](https //leetcode.com/problems/binary-subarrays-with-sum/)|Binary Subarrays with Sum]]
> - [[#[Subarrays with K Different Integers](https //leetcode.com/problems/subarrays-with-k-different-integers/)|Subarrays with K Different Integers]]
> - [[#[1248. Count Number of Nice Subarrays (Medium)](https //leetcode.com/problems/count-number-of-nice-subarrays/|Count Number of Nice Subarrays]] 
> - [2062. Count Vowel Substrings of a String (Easy)](https://leetcode.com/problems/count-vowel-substrings-of-a-string/discuss/1563765/c-on-time-sliding-window/1141941)

# [Binary Subarrays with Sum](https://leetcode.com/problems/binary-subarrays-with-sum/)
#### **Difficulty**: `Medium` 
#### **Tags:** #array #hash #slidWind #prefSum
---
Given a binary array `nums` and an integer `goal`, return _the number of non-empty **subarrays** with a sum_ `goal`.

---
## Prefix State Map

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int numSubarraysWithSum(vector<int>& A, int goal) {
        unordered_map<int, int> m{{0,-1}}; // count of 1s -> index
        int ans = 0;
        for (int i = 0, N = A.size(), sum = 0; i < N; ++i) {
            sum += A[i];
            if (m.count(sum) == 0) m[sum] = i;
            if (goal == 0) ans += i - m[sum];
            else if (sum - goal >= 0) ans += m[sum - goal + 1] - m[sum - goal];
        }
        return ans;
    }
};
```

or

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int numSubarraysWithSum(vector<int>& A, int S) {
	// sum -> number of occurrences of this sum
        unordered_map<int, int> m{{0, 1}}; 
        int sum = 0, ans = 0;
        for (int n : A) {
            sum += n;
            ans += m.count(sum - S) ? m[sum - S] : 0;
            m[sum]++;
        }
        return ans;
    }
};
```

## At Most to Equal + Find Maximum Sliding Window

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
    int atMost(vector<int> A, int goal) {
        int N = A.size(), i = 0, j = 0, cnt = 0, ans = 0;
        while (j < N) {
            cnt += A[j++];
            while (i < j && cnt > goal) cnt -= A[i++];
            ans += j - i;
        }
        return ans;
    }
public:
    int numSubarraysWithSum(vector<int>& A, int goal) {
        return atMost(A, goal) - atMost(A, goal - 1);
    }
};
```

---
# [Subarrays with K Different Integers](https://leetcode.com/problems/subarrays-with-k-different-integers/)
#### **Difficulty**: `Hard` 
#### **Tags**: #hash #2ptr #slidWind 
---
Given an *array* `A` of positive integers, 
- call a **(contiguous,** not necessarily distinct) subarray of `A` _good_ if the _number of different integers_ in that subarray is exactly `K`.

Return the number of good subarrays of `A`.

---
## Sliding Window

- Use `[i, j)` as a *sliding window* to find the **maximum window** which contains no more than `K` unique elements.

To achieve this, we use a map `m` to store the last position of each number in the current window.

- When `m.size() > K`, we should move forward `i` to shrink the window until it become **valid** again.
- When `m.size() == K`, `[i, j)` is the **maximum window** we are looking for.

Within this **maximum window** `[i, j)`, there is a **minimum window** `[k, j)` containing no more than `K` unique elements.  `k` is the **minimal index** in `m`.

- Now, the number of valid subarrays in this window is `k - i + 1`.

Since `k` is monotonically increasing and must be no less than `i`, 

- we can use `k` as a global pointer just like `i` and `j` so that the overall time complexity of moving `k` is `O(N)`.

-  Whenever `m.size() == K`, we can move `K` forward until `m[A[k] - 0] == K`,  and  add `K - i + 1` to the answer.

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

We can turn this problem into two find **maximum sliding window** problem: 
- one is to **find** a *window* with at most `k` different integers.
- another is to **find** a *window* with at most `k - 1` different integers.

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
# [1248. Count Number of Nice Subarrays (Medium)](https://leetcode.com/problems/count-number-of-nice-subarrays/)
#### **Difficulty**: `Medium` 
#### **Tags**:  #array #hash #math #slidWind 

Given an *array* of integers `nums` and an integer `k`. A *continuous subarray* is called **nice** if there are `k` odd numbers on it.

Return the number of **nice** *sub-arrays*.

---
## Prefix State Map

Use a *map* `m` to **store** the mapping from the **count of odd numbers** `cnt` to the **first index** in the array that has `cnt` numbers in front of it and including itself.

- When `cnt >= k`, we add `m[cnt - k + 1] - m[cnt - k]` to the answer.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int numberOfSubarrays(vector<int>& A, int k) {
        int N = A.size(), cnt = 0, ans = 0;
        unordered_map<int, int> m{{0,-1}};
        for (int i = 0; i < N; ++i) {
            cnt += A[i] % 2;
            if (m.count(cnt) == 0) m[cnt] = i;
            if (cnt >= k) ans += m[cnt - k + 1] - m[cnt - k]; 
        }
        return ans;
    }
};
```

## Two Pointers

Assume the current pointer is `j` and the corresponding odd number count is `cj`, we need two pointers to get the answer.

- The *first pointer* `i` is the index whose corresponding **odd number count** is 
 `cj - k + 1`.
- The *second pointer* `prev` is the index whose corresponding **odd number count** is `cj - k`.

So when `cj >= k`, we add `i - prev` to the answer.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int numberOfSubarrays(vector<int>& A, int k) {
        int N = A.size();
        int i = 0, j = 0, prev = -1, ans = 0, ci = 0, cj = 0;
        while (j < N) {
            cj += A[j++] % 2;
            if (ci <= cj - k) {
                prev = i;
                while (ci <= cj - k) ci += A[i++] % 2;
            }
            if (cj >= k) ans += i - prev;
        }
        return ans;
    }
};
```

Or use a single count.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int numberOfSubarrays(vector<int>& A, int k) {
        int N = A.size();
        int i = 0, j = 0, prev = -1, ans = 0, cnt = 0;
        while (j < N) {
            int c = A[j++] % 2;
            cnt += c;
            if (c && cnt >= k) {
                prev = i;
                while (A[i] % 2 == 0) ++i;
                ++i;
            }
            if (cnt >= k) ans += i - prev;
        }
        return ans;
    }
};
```

## AtMost to Equal + Find Maximum Sliding Window

![[#^edc5af]]

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
    int atMost(vector<int> &A, int k) {
        int N = A.size(), i = 0, ans = 0;
        for (int j = 0; j < N; ++j) {
            k -= A[j] % 2;
            while (k < 0) k += A[i++] % 2;
            ans += j - i;
        }
        return ans;
    }
public:
    int numberOfSubarrays(vector<int>& A, int k) {
        return atMost(A, k) - atMost(A, k - 1);
    }
};
```
---
# [Count Vowel Substrings of a String](https://leetcode.com/problems/count-vowel-substrings-of-a-string/)

#### Difficulty : `Easy`
#### Tags : #hash #string 

A **substring** is a contiguous (non-empty) sequence of characters within a string.

A **vowel substring** is a substring that **only** consists of vowels (`'a'`, `'e'`, `'i'`, `'o'`, and `'u'`) and has **all five** vowels present in it.

Given a string `word`, return _the number of **vowel substrings** in_ `word`.
## Brute Force

```cpp
// Time: O(N^2)
// Space: O(1)
class Solution {
    bool isVowel(char c) {
        return c == 'a' ||
         c == 'e' || c == 'i' || c == 'o' || c == 'u';
    };
public:
    int countVowelSubstrings(string s) {
        int ans = 0, N = s.size();
        unordered_map<char, int> cnt;
        for (int i = 0; i < N; ++i) {
            cnt.clear();
            for (int j = i; j < N && isVowel(s[j]); ++j) {
                cnt[s[j]]++;
                if (cnt.size() == 5) ++ans;
            }
        }
        return ans;
    }
};
```

## Sliding Window

Function `atMost(s, goal)` returns the number of substrings that has at most `goal` number of unique vowels. The answer is `atMost(s, 5) - atMost(s, 4)`.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
    bool isVowel(char c) {
        return c == 'a' 
        || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    };
    int atMost(string &s, int goal) {
        int ans = 0, i = 0, j = 0, N = s.size();
        unordered_map<char, int> cnt;
        for (; j < N; ++j) {
            if (!isVowel(s[j])) {
                i = j + 1;
                cnt.clear();
                continue;
            }
            cnt[s[j]]++;
            for (; cnt.size() > goal; ++i) {
                if (--cnt[s[i]] == 0) cnt.erase(s[i]);
            }

// this window [i, j] is the maximum window ending at `s[j]`
// that has at most `goal` number of unique vowels.
            ans += j - i + 1; 
        }
        return ans;
    }
public:
    int countVowelSubstrings(string s) {
        return atMost(s, 5) - atMost(s, 4);
    }
};
```