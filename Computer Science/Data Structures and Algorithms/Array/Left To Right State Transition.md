

> [!example] Problems 
> - [[#[Minimum Deletions to Make String Balanced](https //leetcode.com/problems/minimum-deletions-to-make-string-balanced/)|Minimum Deletions to Make String Balanced]] 
> - [[#[Ways to Make a Fair Array](https //leetcode.com/problems/ways-to-make-a-fair-array/)|Ways to Make a Fair Array]]
> - [[#[Minimum Number of Operations to Move All Balls to Each Box](https //leetcode.com/problems/minimum-number-of-operations-to-move-all-balls-to-each-box/)|Minimum Number of Operations to Move All Balls to Each Box]] 
> - [[#[Minimum Operations to Make a Uni-Value Grid](https //leetcode.com/problems/minimum-operations-to-make-a-uni-value-grid/)|Minimum Operations to Make a Uni-Value Grid]]
> - [[#[All Divisions With the Highest Score of a Binary Array](https //leetcode.com/problems/all-divisions-with-the-highest-score-of-a-binary-array/)|All Divisions With the Highest Score of a Binary Array]]
> - [[#[Minimum Cost to Make Array Equal](https //leetcode.com/problems/minimum-cost-to-make-array-equal)|Minimum Cost to Make Array Equal]]
> - [[#[Sum of Distances](https //leetcode.com/problems/sum-of-distances)|Sum of Distances]] 

# [Minimum Deletions to Make String Balanced](https://leetcode.com/problems/minimum-deletions-to-make-string-balanced/)
#### **Difficulty** : `Medium`
#### **Tags** : #string #dp #stack

You are given a string `s` consisting only of characters `'a'` and `'b'`​​​​.

You can delete any number of characters in `s` to make `s` **balanced**. `s` is **balanced** if there is no pair of indices `(i,j)` such that `i < j` and `s[i] = 'b'` and `s[j]= 'a'`.

Return _the **minimum** number of deletions needed to make_ `s` _**balanced**_.

---
## Left-to-Right State Transition

**Scan** `s` and try using each *point* as a *breakpoint*. **Keep track** of the *number* of `a`s to the **left** and *number* of `b`s to the **right.**

For each *breakpoint,* the **longest** *string* we can form is of 
length `a + b`.
We find the **global maximum** of such length, and the **answer** is
`N` **minus** this **maximum** *value.*

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int minimumDeletions(string s) {
        int a = 0, b = 0, N = s.size();
        for (char c : s) b += c == 'b';
        int ans = b;
        for (int i = 0; i < N; ++i) {
            a += s[i] == 'a';
            b -= s[i] == 'b';
            ans = max(ans, a + b);
        }
        return N - ans;
    }
};
```

---
# [Ways to Make a Fair Array](https://leetcode.com/problems/ways-to-make-a-fair-array/)

#### **Difficulty** : `Medium`
#### **Tags** : #array #dp 


You are given an *integer array* `nums`. You can choose **exactly one** *index* (**0-indexed**) and **remove** the *element.*
Notice that the *index* of the *elements* may change after the **removal.**

For example, if `nums = [6,1,7,4,1]`:

- Choosing to remove index `1` results in `nums = [6,7,4,1]`.
- Choosing to remove index `2` results in `nums = [6,1,4,1]`.
- Choosing to remove index `4` results in `nums = [6,1,7,4]`.

An array is **fair** if the sum of the **odd-indexed** *values* equals the **sum of the even-indexed** *values.*

Return the **number of** *indices* that you could choose such that after the removal, `nums` is **fair**


## Left-to-Right State Transition (Prefix + Suffix)

If we remove `A[i]`, then the parity of the indexes greater than `i` are all changed (even becomes odd and vice versa).

$$\mathrm{[ left part ] - A[i] - [ right part] }$$
We can get the **sum** of **even/odd** *numbers* in the **right part** using the *precomputed suffix sum*, and get the *sum* of **even/odd** *numbers* in the **left part** by calculating **prefix sum**.

**Algorithm**:

Let `e[i]`/`o[i]` be the (suffix) sum of all even/odd numbers with index greater than and equal to `i`.

We precompute `e[i]` and `o[i]` first.

Then we can scan from left to right and compute the prefix sum of all even/odd numbers with indexes smaller than `i` on the fly, and save them in `even` and `odd`.

If we remove `A[i]`, then the sum of all the even numbers is `even + o[i + 1]`, and the sum of all odd numbers is `odd + e[i + 1]`.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int waysToMakeFair(vector<int>& A) {
        int N = A.size(), even = 0, odd = 0, ans = 0;
        vector<int> e(N + 1), o(N + 1);
        for (int i = N - 1; i >= 0; --i) {
            if (i % 2 == 0) e[i] += A[i];
            else o[i] += A[i];
            e[i] += e[i + 1];
            o[i] += o[i + 1];
        }
        for (int i = 0; i < N; ++i) {
            ans += (even + o[i + 1]) == (odd + e[i + 1]);
            if (i % 2 == 0) even += A[i];
            else odd += A[i];
        }
        return ans;
    }
};
```

## Left-to-right State Transition (Prefix + Suffix) { Optimized }

We can compute the suffix sums on the fly as well to save the extra space

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int waysToMakeFair(vector<int>& A) {
        int N = A.size();
        int evenPrefix = 0;
        int oddPrefix = 0;
        int evenSuffix = 0;
        int oddSuffix = 0;
        int ans = 0;
        for (int i = 0; i < N; ++i) {
            if (i % 2 == 0) evenSuffix += A[i];
            else oddSuffix += A[i];
        }
        for (int i = 0; i < N; ++i) {
            if (i % 2 == 0) evenSuffix -= A[i];
            else oddSuffix -= A[i];
            ans += (evenPrefix + oddSuffix) == (oddPrefix + evenSuffix);
            if (i % 2 == 0) evenPrefix += A[i];
            else oddPrefix += A[i];
        }
        return ans;
    }
};
```

---
# [Minimum Number of Operations to Move All Balls to Each Box](https://leetcode.com/problems/minimum-number-of-operations-to-move-all-balls-to-each-box/)
#### **Difficulty** : `Medium`
#### **Tags** : #array #string 

You have `n` boxes. You are given a *binary string* `boxes` of **length** `n`, where `boxes[i]` is `'0'` if the `ith` box is **empty**, and `'1'` if it contains **one** ball.

In one operation, you can move **one** ball from a box to an **adjacent** box. Box `i` is adjacent to box `j` if `abs(i - j) == 1`. Note that after doing so, there may be more than one ball in some boxes.

Return an *array* `answer` of size `n`, where `answer[i]` is the **minimum** number of operations needed to move all the balls to the `ith` box.

Each `answer[i]` is calculated considering the **initial** state of the boxes.


## Brute force

```cpp
// Time: O(N^2)
// Space: O(1)
class Solution {
public:
    vector<int> minOperations(string s) {
        int N = s.size();
        vector<int> ans(s.size());
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                if (s[j] == '1') ans[i] += abs(j - i);
            }
        }
        return ans;
    }
};
```

## Left-to-Right State Transition

Assume we are at `s[i]` and the corresponding operations needed is `sum`. When we move from `s[i]` to `s[i + 1]`, if there are `left` **balls** that have indexes `<= i` and `right` **balls** that have indexes `> i`, then the **number of operations** needed for `s[i + 1]` will be `sum + left - right`.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    vector<int> minOperations(string s) {
        int N = s.size();
        int sum = 0;
        int right = 0;
        int left = 0;
        vector<int> ans(s.size());
        for (int i = 0; i < N; ++i) {
            if (s[i] == '1') sum += i, ++right;
        }
        for (int i = 0; i < N; ++i) {
            ans[i] = sum;
            if (s[i] == '1') --right, ++left;
            sum += left - right;
        }
        return ans;
    }
};
```
---

# [Minimum Operations to Make a Uni-Value Grid](https://leetcode.com/problems/minimum-operations-to-make-a-uni-value-grid/)
#### **Difficulty** : `Medium`
#### **Tags** : #array #math #sort #matrix 

You are given a **2D integer** `grid` of size `m x n` and an *integer* `x`. In one operation, you can **add** `x` to or **subtract** `x` from any element in the `grid`.

A **uni-value grid** is a grid where all the elements of it are equal.

Return _the **minimum** number of operations to make the grid **uni-value**_. If it is not possible, return `-1`.

## Left-to-right State Transition

```cpp
// Time: O(NlogN) where `N` is the count of all elements in `A`.
// Space: O(N)
class Solution {
public:
    int minOperations(vector<vector<int>>& A, int x) {
        vector<int> B;
        for (auto &r : A) {
            for (int n : r) B.push_back(n);
        }
        sort(begin(B), end(B));
        long mn = B[0], val = 0;
        for (int i = 0; i < B.size(); ++i) {
            if ((B[i] - mn) % x) return -1;
            val += (B[i] - mn) / x;
        }
        long ans = val;
        for (int i = 1; i < B.size(); ++i) {
            int diff = (B[i] - B[i - 1]) / x;
            val += i * diff - (B.size() - i) * diff;
            ans = min(ans, val);
        }
        return ans;
    }
};
```

## Median Minimizes Sum of Absolute Deviations

Any *median* **minimizes** the **sum of absolute deviations**.

If the *array* has **odd number of elements**, there is only a *single median* which **minimizes** the **sum of absolute deviations**.

If the *array* has **even number** of elements, any *numbers* between (including) the two **median** numbers **minimizes** the *sum of absolute* deviations.

```cpp
// Time: O(NlogN) where `N` is the count of all elements in `A`.
// Space: O(N)
class Solution {
public:
    int minOperations(vector<vector<int>>& A, int x) {
        vector<int> B;
        for (auto &r : A) {
            for (int n : r) B.push_back(n);
        }
        sort(begin(B), end(B));
        int median = B[B.size() / 2], ans = 0;
        for (int i = 0; i < B.size(); ++i) {
            int d = abs(B[i] - median);
            if (d % x) return -1;
            ans += abs(d) / x;
        }
        return ans;
    }
};
```
---

# [All Divisions With the Highest Score of a Binary Array](https://leetcode.com/problems/all-divisions-with-the-highest-score-of-a-binary-array/)

#### **Difficulty** : `Medium`
#### **Tags** : #array 

You are given a **0-indexed** *binary array* `nums` of length `n`. `nums` can be divided at index `i` (where `0 <= i <= n)` into two *arrays* (possibly empty) `numsleft` and `numsright`:

- `numsleft` has all the *elements* of `nums` between index `0` and `i - 1` **(inclusive)**, while `numsright` has all the *elements* of nums between index `i` and `n - 1` **(inclusive)**.
- If `i == 0`, `numsleft` is **empty**, while `numsright` has all the elements of `nums`.
- If `i == n`, `numsleft` has all the elements of nums, while `numsright` is **empty**.

The **division score** of an index `i` is the **sum** of the number of `0`'s in `numsleft` and the number of `1`'s in `numsright`.

Return _**all distinct indices** that have the **highest** possible **division score**_. You may return the answer in **any order**.

## Count Left Ones and Right Zeros on the fly

Let `zero`/`one` be the number of zeros/ones in the left/right part. Initially `one = SUM(A)`.

For each `i`, `score = zero + one`. And we can update `zero` and `one` when we move `A[i]` from right part to left part.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> maxScoreIndices(vector<int>& A) {
        int N = A.size();
        int one = accumulate(begin(A), end(A), 0);
        int zero = 0;
        int mx = 0;
        vector<int> ans;
        for (int i = 0; i <= N; ++i) {
            int score = one + zero;
            if (score > mx) {
                ans = {i};
                mx = score;
            } else if (score == mx) ans.push_back(i);
            if (i < N) {
                one -= A[i] == 1;
                zero += A[i] == 0;
            }
        }
        return ans;
    }
};
```

Note that here I marked extra space complexity as `O(N)` because the `ans` is used to store some temporary results whose length might be as long as `N-1` while the answer might be just of length 1. So, the extra space we used might be linear to the input but not strictly confined by the size of the real answer.

That said, we can make it `O(1)` space by calculating the maximum score in one loop first then gather the `ans` array in another loop. In this way, the size of the `ans` is absolutely the same as the size of the real answer and won't be linear to the input size. But, this requires two loops.

## Prefix Sum

Let `sum[i+1]` be `A[0] + ... + A[i]`.

For *index* `i`, there are `i - sum[i]` zeros in the **left part** and `sum[N] - sum[i]` ones in the **right* part*.

So the *score* for `i` is `i - sum[i] + sum[N] - sum[i]`.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> maxScoreIndices(vector<int>& A) {
        int N = A.size(), mx = 0;
        vector<int> sum(N + 1, 0), ans;
        for (int i = 0; i < N; ++i){
		      sum[i + 1] = sum[i] + A[i];   
        }
        for (int i = 0; i <= N; ++i) {
            int score = i - sum[i] + sum[N] - sum[i];
            if (score > mx) {
                ans = {i};
                mx = score;
            } else if (score == mx) ans.push_back(i);
        }
        return ans;
    }
};
```
---
# [Minimum Cost to Make Array Equal](https://leetcode.com/problems/minimum-cost-to-make-array-equal)
#### **Difficulty** : `Hard`
#### **Tags** : #array #binSrch #greedy #sort #prefSum  

You are given two **0-indexed** arrays `nums` and `cost` consisting each of `n` **positive** integers.

You can do the following operation **any** number of times:
- Increase or decrease **any** element of the array `nums` by `1`.

The cost of doing one operation on the `ith` element is `cost[i]`.

Return _the **minimum** total cost such that all the elements of the array_ `nums` _become **equal**_.

## Left-to-right State Transition

We first sort the *arrays* together in **accending order** of the *numbers*.

For example,
$$A = [1,3,5,2], C = [2,3,1,14]$$
  $$\Downarrow$$
$$A = [1,2,3,5], C = [2,14,3,1]$$

We scan the numbers from left to right.

Let `rightSum` be the sum of costs of numbers greater than or equal to the current number, `leftSum` be the cost of numbers smaller than the current number, `totalCost` be the total cost needed to change all numbers to be the same as the current number.

When we move from `A[i-1]` to `A[i]`, let `d = A[i] - A[i-1]`, the `totalCost` need to `- d * rightSum` and `+ d * leftSum`.

For example, `A = [1,2,3,5], C = [2,14,3,1]`. When we move from `A[0] = 1` to `A[1] = 2`, `d = 1`, the `totalCost` at `A[0]` was `0 * 2 + 1 * 14 + 2 * 3 + 4 * 1`, and now we need to change `totalCost` by `- d * rightSum = -1 * (14 + 3 + 1)` and `+ d * leftSum = +1 * (2)`, so the `totalCost` becomes `1 * 2 + 0 * 14 + 1 * 3 + 3 * 1`.

After calculating `totalCost` for `A[i]`, we update `rightSum` by `-C[i]` and `leftSum` by `+C[i]`.

```cpp
// Time: O(NlogN)
// Space: O(N)
class Solution {
public:
    long long minCost(vector<int>& A, vector<int>& C) {
        long long rightSum = accumulate(begin(C), end(C), 0LL);
        int leftSum = 0;
        int ans = LLONG_MAX;
        int N = A.size();
        int prev = 0;
        int totalCost = 0;
        vector<int> id(N);
        iota(begin(id), end(id), 0);
        sort(begin(id), end(id), [&](int a, int b) { return A[a] < A[b]; });
        for (int i = 0; i < N; ++i){
	        totalCost += (long long)A[i] * C[i];
        } 
        for (int i = 0; i < N; ++i) {
            long long num = A[id[i]];
            long long cost = C[id[i]];
            long long d = num - prev;
            totalCost = totalCost + d * (leftSum - rightSum);
            ans = min(ans, totalCost);
            rightSum -= cost;
            leftSum += cost;
            prev = num;
        }
        return ans;
    }
};
```

## Binary Search


This approach is based on one theorem: a linear combination (with non-negative coefficients) of convex functions is convex.

Here, we define fi(x)f_i(x)fi​(x) as the cost function if `nums` only contains one element `nums[i]`.

If `nums` only contains `nums[i]`, the cost function fi(x)f_i(x)fi​(x) is convex, as shown in the picture below.

If `nums` consists of multiple elements, the cost F(x)F(x)F(x) is the combination of every fi(x)f_i(x)fi​(x), that is F(x)=f1(x)+f2(x)+...F(x) = f_1(x) + f_2(x) + ... F(x)=f1​(x)+f2​(x)+... where each fi(x)f_i(x)fi​(x) is convex.

[![img](https://camo.githubusercontent.com/d75577227d93fb0059a78b1872f72e492f0a897042d6061c773a4badc57d8079/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f6d696e696d756d2d636f73742d746f2d6d616b652d61727261792d657175616c2f466967757265732f323434382f63312e706e67)](https://camo.githubusercontent.com/d75577227d93fb0059a78b1872f72e492f0a897042d6061c773a4badc57d8079/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f6d696e696d756d2d636f73742d746f2d6d616b652d61727261792d657175616c2f466967757265732f323434382f63312e706e67)

Therefore, the total cost function F(x)F(x)F(x) is convex and has the minimum `mi` in the range `[min(nums), max(nums)]`.

Therefore, we can use binary search to locate the minimum of this convex function. Start with setting the boundaries of the search space as `left = min(nums)` and `right = max(nums)`, we cut the search space into two halves by `mid = (left + right) / 2`. Then we shall determine which part contains the minimum cost. This can be done by comparing the cost of two adjacent bases:

- If F(x)<F(x+1)F(x) < F(x + 1)F(x)<F(x+1), it means the base that brings the minimum cost is on F(x)F(x)F(x)'s left, thus we should cut the right half.
- If F(x)>=F(x+1)F(x) >= F(x + 1)F(x)>=F(x+1), it means the base that brings the minimum cost is on F(x)F(x)F(x)'s right, thus we should cut the left half.

[![img](https://camo.githubusercontent.com/6ce40117affa5d47b0b541e4d434e29cca5208d930023c447582f123932b3ead/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f6d696e696d756d2d636f73742d746f2d6d616b652d61727261792d657175616c2f466967757265732f323434382f63322e706e67)](https://camo.githubusercontent.com/6ce40117affa5d47b0b541e4d434e29cca5208d930023c447582f123932b3ead/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f6d696e696d756d2d636f73742d746f2d6d616b652d61727261792d657175616c2f466967757265732f323434382f63322e706e67)

We continue the binary search until we reach the base that brings the minimum cost.

  

#### [](https://github.com/lzl124631x/LeetCode/tree/master/leetcode/2448.%20Minimum%20Cost%20to%20Make%20Array%20Equal#algorithm)Algorithm

1. Initialize the searching space by setting its boundaries `left = min(nums)` and `right = max(nums)`.

2）While `left < right`:

- Get the middle value `mid` using integer division `mid = (left + right) / 2`.
- Calculate the cost of two adjacent bases, `F(mid)` and `F(mid + 1)`.
- If `F(mid) > F(mid + 1)`, cut the left half by setting `left = mid + 1`. Otherwise, cut the right half by setting `right = mid`. Then repeat step 2.

3. Return `left` once the search ends.

```cpp
// Time: O(NlogK)
// Space: O(1)
class Solution {
public:
    long long minCost(vector<int>& A, vector<int>& C){
        long long ans = LLONG_MAX;
        long long L = *min_element(begin(A), end(A));
        long long R = *max_element(begin(A), end(A));
        long long N = A.size();
        auto cost = [&](int to) {
            long long ans = 0;
            for (int i = 0; i < N; ++i) {
              ans += (long long)abs(A[i] - to) * C[i];
            }
            return ans;
        };
        while (L <= R) {
            long long M = (L + R) / 2;
            long long a = cost(M);
            long long b = cost(M + 1);
            ans = min(a, b);
            if (a > b) L = M + 1;
            else R = M - 1;
        }
        return ans;
    }
};
```
---
# [Sum of Distances](https://leetcode.com/problems/sum-of-distances)

#### **Difficulty** : `Medium`
#### **Tags** : #array #hash #prefSum  
You are given a **0-indexed** integer array `nums`. There exists an array `arr` of length `nums.length`, where `arr[i]` is the sum of `|i - j|` over all `j` such that `nums[j] == nums[i]` and `j != i`. If there is no such `j`, set `arr[i]` to be `0`.

Return _the array_ `arr`_._

## Left-to-right State Transition

Group the indices of the same numbers together using an `unordered_map<int, vector<int>> m`.

For the index numbers in each of the group, we keep `rightSum` as sum of all index numbers greater than the current index number, and `leftSum` as the sum of all index numbers smaller than or equal to the current index number. Initially `rightSum` is the sum of all index numbers in the group.

Then, we visit the index numbers one by one. For index number `v[i]`, we deduct it from `rightSum` and add it to `leftSum`. `ans[v[i]]` is `rightSum - (N - i - 1) * v[i] + (i + 1) * v[i] - leftSum = rightSum - leftSum + (2 * (i + 1) - N) * v[i]`.

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<long long> distance(vector<int>& A) {
        int N = A.size();
        vector<long long> ans(N);
        unordered_map<int, vector<int>> m;
        for (int i = 0; i < N; ++i){
	        m[A[i]].push_back(i);
        } 
        for (auto &[n, v] : m) {
            long long rightSum = 0, leftSum = 0;
            for (int i : v) rightSum += i;
            for (int i = 0; i < v.size(); ++i) {
                rightSum -= v[i];
                leftSum += v[i];
                ans[v[i]] = rightSum - leftSum + 
                (2LL * (i + 1) - v.size()) * v[i];
            }
        }
        return ans;
    }
};
```