
> [!example] Problems
> - [[#[3Sum Closest](https //leetcode.com/problems/3sum-closest/)|3Sum Closest]]
> - [[#[Intersection of Two Arrays II](https //leetcode.com/problems/intersection-of-two-arrays-ii)|Intersection of Two Arrays II]]
> - [[#[Find Permutation](https //leetcode.com/problems/find-permutation)|Find Permutation]]
> - [[#[ Permutation in String](https //leetcode.com/problems/permutation-in-string/)| Permutation in String]]
> - [[#[String Without AAA or BBB](https //leetcode.com/problems/string-without-aaa-or-bbb/)|String Without AAA or BBB]]
> - [[#[Jump Game VII](https //leetcode.com/problems/jump-game-vii/)|Jump Game VII]]

# [3Sum Closest](https://leetcode.com/problems/3sum-closest/)

#### Difficulty : `Medium`
#### Tags : #array #2ptr #sort 

Given an array `nums` of _n_ integers and an integer `target`, find three integers in `nums` such that the sum is closest to `target`. Return the sum of the three integers. You may assume that each input would have exactly one solution.

## Two pointers

```cpp
// Time: O(N^2)
// Space: O(1)
class Solution {
public:
    int threeSumClosest(vector<int>& A, int target) {
        sort(begin(A), end(A));
        int N = A.size(), ans = A[0] + A[1] + A[2];
        for (int i = 0; i < N - 2; ++i) {
            int L = i + 1, R = N - 1;
            while (L < R) {
                long sum = A[L] + A[R] + A[i];
                if (abs(sum - target) < abs(ans - target)){
	                 ans = sum;
                }
                if (sum == target) return target;
                if (sum > target) --R;
                else ++L;
            }
        }
        return ans;
    }
};
```

---
# [Intersection of Two Arrays II](https://leetcode.com/problems/intersection-of-two-arrays-ii)

#### Difficulty : `Easy`
#### Tags : #array #hash #2ptr #binSrch #sort 

Given two integer arrays `nums1` and `nums2`, return _an array of their intersection_. Each element in the result must appear as many times as it shows in both arrays and you may return the result in **any order**.


> [!faq] Follow up
> - What if the given array is already sorted? How would you optimize your algorithm?
> - What if `nums1`'s size is small compared to `nums2`'s size? Which algorithm is better?
> - What if elements of `nums2` are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?


## Counting

```cpp
// Time: O(M + N)
// Space: O(D) where D is the data range of the numbers
class Solution {
public:
    vector<int> intersect(vector<int>& A, vector<int>& B) {
        int ca[1001] = {};
        for (int n : A) ca[n]++;
        vector<int> ans;
        for (int n : B) {
            if (ca[n]-- > 0) ans.push_back(n);
        }
        return ans;
    }
};
```

## Two Pointers


> [!faq] Follow up
> What if the given array is already sorted? How would you optimize your algorithm?

We can use two pointers to reduce the space complexity from `O(D)` to `O(1)`.

```cpp
// Time: O(M + N) assuming the arrays are sorted
// Space: O(1)
class Solution {
public:
    vector<int> intersect(vector<int>& A, vector<int>& B) {
        sort(begin(A), end(A));
        sort(begin(B), end(B));
        vector<int> ans;
        for (int i = 0, j = 0, M = A.size(), N = B.size();
         i < M && j < N; ) {
            if (A[i] == B[j]) ans.push_back(A[i]), ++i, ++j;
            else if (A[i] < B[j]) ++i;
            else ++j;
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
                for (int i = ans.size() - 2;
                 i >= 0 && ans[i] == ans[i + 1]; --i) ans[i]++;
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
# [ Permutation in String](https://leetcode.com/problems/permutation-in-string/)

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
            while (j < N &&
             i < j && s2[i] != s2[j]) cnt[s2[i++] - 'a']--;
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
# [String Without AAA or BBB](https://leetcode.com/problems/string-without-aaa-or-bbb/)

#### Difficulty : `Medium`
#### Tags : #greedy 

Given two integers `A` and `B`, return **any** string `S` such that:

- `S` has length `A + B` and contains exactly `A` `'a'` letters, and exactly `B` `'b'` letters;
- The substring `'aaa'` does not occur in `S`;
- The substring `'bbb'` does not occur in `S`.


## Solution 1

```cpp
// Time: O(A + B)
// Space: O(1)
class Solution {
public:
    string strWithout3a3b(int A, int B) {
        char a = 'a', b = 'b';
        if (A < B) swap(A, B), swap(a, b);
        string ans;
        while (A && B) {
            for (int i = A > B ? 2 : 1; i > 0; --i, --A) ans += a;
            ans += b;
            --B;
        }
        while (A-- > 0) ans += a;
        return ans;
    }
};
```

---
# [Jump Game VII](https://leetcode.com/problems/jump-game-vii/)

#### Difficulty : `Medium`
#### Tags : #greedy #bfs #linesweep

You are given a **0-indexed** binary string `s` and two integers `minJump` and `maxJump`. In the beginning, you are standing at index `0`, which is equal to `'0'`. You can move from index `i` to index `j` if the following conditions are fulfilled:

- `i + minJump <= j <= min(i + maxJump, s.length - 1)`, and
- `s[j] == '0'`.

Return `true` _if you can reach index_ `s.length - 1` _in_ `s`_, or_ `false` _otherwise._

## Solution 1

```cpp
// Time: O(N)
// Space: O(maxJump - minJump)
class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        if (s.back() == '1') return false;
        queue<int> q;
        int j = 0, prev = 0;
        for (int i = 1; i < s.size(); ++i) {
            if (i - prev > maxJump) return false;
            if (s[i] == '1') continue;
            j = max(j, i - maxJump);
            while (i - j >= minJump) {
                if (s[j] == '0') q.push(j);
                ++j;
            }
            while (q.size() && i - q.front() > maxJump) q.pop();

// mark this position as non-reachable.
            if (q.empty()) s[i] = '1'; 
            else prev = i;
        }
        return q.size();
    }
};
```

## Two Pointers

Mark reacheable position using `'2'`. For each `s[i] == '2'`, we traverse `i + minJump <= j <= i + maxJump` and turn `s[j]` to `2` if `s[j] == '0'`.

Pointer `j` can be monotonically increasing so that both pointer `i` and `j` at most traverse the array once.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        if (s.back() == '1') return false;

// mark s[0] as reacheable
        s[0] = '2'; 
        int j = 0;
        for (int i = 0; i < s.size() && s.back() != '2'; ++i) {

// only extend reacheable points
            if (s[i] != '2') continue; 

// `j` is at least `i + minJump`
            j = max(j, i + minJump); 
            while (j < s.size() && j - i <= maxJump) { // try to extend until `j > i + maxJump`

// mark `s[j]` as reacheable if `s[j] == '0'`
                if (s[j] == '0') s[j] = '2'; 
                ++j;
            }
        }
        return s.back() == '2';
    }
};
```

## DP + Sliding Window

`dp[i] = true` if we can reach `s[i]`.

`active` is the number of previous positions that we can jump from.

For each `i`, the `[i - maxJump, i + minJump]` forms a sliding window, and we only update the `active` when `'0'` goes in/out of the window.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        if (s.back() == '1') return false;
        int N = s.size(), active = 0;
        vector<int> dp(N);
        dp[0] = true;
        for (int i = 1; i < N; ++i) {
            if (i - minJump >= 0 && dp[i - minJump]) ++active;
            if (i - maxJump - 1 >= 0 && dp[i - maxJump - 1]){
				 --active;
            }
            dp[i] = s[i] == '0' && active;
        }
        return dp.back();
    }
};
```

Or

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        if (s.back() == '1') return false;
        int N = s.size(), active = 0;
        s[0] = '2';
        for (int i = 1; i < N && s.back() != '2'; ++i) {
            if (i - minJump >= 0 && s[i - minJump] == '2'){
	            ++active;
            } 
            if (i - maxJump - 1 >= 0 &&
             s[i - maxJump - 1] == '2'){
	            --active;
            } 
            if (s[i] == '0' && active) s[i] = '2';
        }
        return s.back() == '2';
    }
};
```

