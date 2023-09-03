

> [!example] Problems 
> - [[#[Reorganize String](https //leetcode.com/problems/reorganize-string)|Reorganize String]]
> - [[#[Distant Barcodes](https //leetcode.com/problems/distant-barcodes/)| Distant Barcodes]] 


# [Reorganize String](https://leetcode.com/problems/reorganize-string)
#### **Difficulty**: `Medium`
#### **Tags**: #hash #string #greedy #sort #heap #counting 

Given a *string* `s`, rearrange the characters of `s` so that any two *adjacent characters* are **not the same**.

Return any possible **rearrangement** of `s` or return `""` if **not** possible.

---
## Sequential Placing (Greedy)

We place the *letters* from **left** to **right.** We always pick the *letter* that has the **maximum count** and is not the *previously placed letter*.

```cpp
// Time: O(NA) where A is the size of the alphabet
// Space: O(A)
class Solution {
public:
    string reorganizeString(string s) {
        int cnt[26] = {}, mxCnt = 0;
        for (char c : s) mxCnt = max(mxCnt, ++cnt[c - 'a']);
        if (mxCnt > (s.size() + 1) / 2) return "";
        string ans;
        for (int i = 0; i < s.size(); ++i) {
            int mxIndex = -1;
            for (int c = 0; c < 26; ++c) {
                if (cnt[c] == 0 ||
	                (ans.size() && ans.back() == 'a' + c) ||
	                 (mxIndex != -1 && cnt[c] <= cnt[mxIndex]))
                  continue;
                mxIndex = c;
            }
            cnt[mxIndex]--;
            ans.push_back('a' + mxIndex);
        }
        return ans;
    }
};
```

## Sequential Placing (Greedy + Heap)

Similar to [[#Sequential Placing (Greedy)]], but instead of **traversing** all the *letters,* we use a *priority queue* to pick the one with the **maximum count**.

Since we can't place the *letter* we just **placed** again, we **store the letter** we just placed in a *temp variable* `prev`, and **push it back** into the *priority queue* one round later.

```cpp
// Time: O(A + NlogA) where A is the size of the alphabet
// Space: O(A)
class Solution {
public:
    string reorganizeString(string S) {
        int cnt[26] = {}, prev = -1;
        for (char c : S) cnt[c - 'a']++;
        auto cmp = [&](int a, int b) { return cnt[a] < cnt[b]; };
        priority_queue<int, vector<int>, decltype(cmp)> q(cmp);
        for (int i = 0; i < 26; ++i) if (cnt[i]) q.push(i);
        string ans;
        while (q.size()) {
            int c = q.top();
            q.pop();
            ans.push_back('a' + c);
            if (prev != -1) q.push(prev);
            if (--cnt[c]) prev = c;
            else prev = -1;
        }
        if (prev != -1) return "";
        return ans;
    }
};
```

## Interleaving Placement

We fill the *even indices* first, then the *odd indices*.

```cpp
// Time: O(AlogA + N) where A is the size of the alphabet 
// Space: O(A)
class Solution {
public:
    string reorganizeString(string s) {
        int N = s.size(), cnt[26] = {}, j = 0;
        for (char c : s) cnt[c - 'a'] += 100;
        for (int i = 0; i < 26; ++i) cnt[i] += i;
        sort(begin(cnt), end(cnt), greater<>());
        string ans(N, 0);
        for (int n : cnt) {
            int ct = n / 100, ch = n % 100;
            if (ct == 0) continue;
            if (ct > (N + 1) / 2) return "";
            while (ct--) {
                ans[j] = ch + 'a';
                j = (j + 2) % N;
                if (j == 0) j = 1;
            }
        }
        return ans;
    }
};
```

We don't even need to **sort** the `cnt` **array.** We just need to **place** the *letter* with the **maximum count** first, and then **place** the rest in **any order**.

```cpp
// Time: O(N)
// Space: O(A)
class Solution {
public:
    string reorganizeString(string s) {
        int cnt[26] = {}, mxIndex = -1, N = s.size(), j = 0;
        for (char c : s) ++cnt[c - 'a'];
        for (int i = 0; i < 26; ++i) {
            if (mxIndex == -1 || cnt[i] > cnt[mxIndex]) {
				   mxIndex = i;        
			}
        }
        if (cnt[mxIndex] > (N + 1) / 2) return "";
        string ans(N, 0);
        // Place the most frequent letter
        while (cnt[mxIndex]--) {
            ans[j] = 'a' + mxIndex;
            j += 2;
        }
        // Place rest of the letters in any order
        for (int i = 0; i < 26; ++i) {
            while (cnt[i]-- > 0) {
                if (j >= N) j = 1;
                ans[j] = 'a' + i;
                j += 2;
            }
        }
        return ans;
    }
};
```

---
# [Distant Barcodes](https://leetcode.com/problems/distant-barcodes/)
#### **Difficulty**: `Medium`
#### **Tags**: #heap #sort 

There is a *row* of **barcodes,** where the `i`<sup>th</sup> barcode is `barcodes[i]`.

Rearrange the **barcodes** so that no two **adjacent barcodes** are **equal.**  You may return any *answer,* and it is guaranteed an *answer exists*.

---
## Greedy + Heap

```cpp
// Time: O(NlogN)
// Space: O(N)
class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& A) {
        unordered_map<int, int> cnt;
        for (int n : A) cnt[n]++;
        auto cmp = [&](int a, int b) { return cnt[a] < cnt[b]; };
        priority_queue<int, vector<int>, decltype(cmp)> q(cmp);
        for (auto &p : cnt) q.push(p.first);
        int prev = 0;
        vector<int> ans;
        while (q.size()) {
            int n = q.top();
            q.pop();
            ans.push_back(n);
            if (prev) q.push(prev);
            if (--cnt[n]) prev = n;
            else prev = 0;
        }
        return ans;
    }
};
```

## Interleaving Placement

```c
// OJ: https://leetcode.com/problems/distant-barcodes/
// Author: github.com/lzl124631x
// Time: O(NlogN)
// Space: O(N)
class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& A) {
        unordered_map<int, int> cnt;
        set<pair<int, int>> s;
        for (int n : A) cnt[n]++;
        for (auto &p : cnt) s.emplace(p.second, p.first);
        int j = 0, N = A.size();
        vector<int> ans(N);
        for (auto it = s.rbegin(); it != s.rend(); ++it) {
            for (int c = 0; c < it->first; ++c, j += 2) {
                if (j >= N) j = 1;
                ans[j] = it->second;
            }
        }
        return ans;
    }
};
```


## Counting:
Just **fill** the *most frequent number* first. The *others* can be **filled** **irrespective** of their *frequency.*

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& A) {
        short cnt[10001] = {}, maxCnt = 0, num = 0, j = 0;
        for (int n : A) {
            maxCnt = max(maxCnt, ++cnt[n]);
            if (maxCnt == cnt[n]) num = n;
        }
        for (int i = 0; i <= 10000; ++i) {
            int n = i ? i : num;
            while (cnt[n]-- > 0) {
                A[j] = n;
                j = (j + 2) % A.size();
                if (j == 0) j = 1;
            }
        }
        return A;
    }
};
```