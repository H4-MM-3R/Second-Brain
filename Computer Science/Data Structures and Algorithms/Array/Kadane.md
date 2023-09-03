
> [!faq] Kadane's Algorithm 
> - **Kadane's algorithm** is used to **find** the *maximum sum subarray* from a given *array.*
> - It's a **DP algorithm**

# Algorithm
Test the code for [[#[Maximum Subarray](https //leetcode.com/problems/maximum-subarray/)|Maximum Subarray]]
```cpp
// Time: O(N)
// Space: O(1)
int kadane(vector<int> &A) {
    int ans = INT_MIN, mx = 0;
    for (int n : A) {
        mx = max(mx + n, n);
        ans = max(ans, mx);
    }
    return ans;
}
```


> [!example] Problems 
> - [[#[Maximum Subarray](https //leetcode.com/problems/maximum-subarray/)|Maximum Subarray]]
> - [[#[Max Sum of Rectangle No Larger Than K](https //leetcode.com/problems/max-sum-of-rectangle-no-larger-than-k/)|Max Sum of Rectangle No Larger Than K]]
> - [[#[Substring With Largest Variance](https //leetcode.com/problems/substring-with-largest-variance)|Substring With Largest Variance]]


# [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
#### **Difficulty:** `Easy`
#### **Tags:** #array #divConq #dp 

Given an *integer array* `nums`, find the *contiguous subarray* (**containing at least one number**) which has the **largest sum** and return its **sum.**

> [!faq] Follow up
>  If you have figured out the `O(n)` solution, try coding another solution using the **divide and conquer** approach, which is more subtle.

---
## Rolling Sum + Greedy

We can first **get** the *rolling sum* so that `sum[i] = nums[0] + ... + nums[i]`. With `partial_sum` we can do that **in place**.

Then this problem is almost the same as [121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/) 
finding the maximum `sum[j] - sum[i]` where `j > i`. 

- The only difference is that the *sub array* can **start** at index `0`, so we also need to take `sum[i]` where `0 <= i < N` into consideration. So the "**minimum sum we've seen so far**" should be initialized as `0`.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        partial_sum(nums.begin(), nums.end(), nums.begin());
        int minSum = 0, ans = INT_MIN;
        for (int n : nums) {
            ans = max(ans, n - minSum);
            minSum = min(minSum, n);
        }
        return ans;
    }
};
```

Or

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxSubArray(vector<int>& A) {
        int mn = 0, sum = 0, ans = INT_MIN;
        for (int n : A) {
            sum += n;
            ans = max(ans, sum - mn);
            mn = min(mn, sum);
        }
        return ans;
    }
};
```

## DP

Let `dp[i + 1]` be the *sum of maximum subarray* ending with `nums[i]`.

$$ \mathrm{dp[i + 1]} = max
  \begin{cases}
    \mathrm{dp[i] + A[i]}       & \quad \text{if } \mathrm{dp[i]} \text{ > 0}\\
    \mathrm{A[i]}  & \quad \text{if } \mathrm{dp[i]} \text{ <= 0}
  \end{cases}
$$
Or
$$ \mathrm{dp[i + 1] = max(dp[i], 0) + A[i]}
$$

Where `0 <= i < N`.

Note that we can set `dp[0] = 0` so that the equation stay true for `i = 0`.

The result is $$\mathrm{max\{ dp[1], ..., dp[N] \}}$$

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = INT_MIN, N = nums.size();
        vector<int> dp(N + 1, 0);
        for (int i = 0; i < N; ++i){
	        ans = max(ans, dp[i + 1] = max(dp[i], 0) + nums[i]);
        }
        return ans;
    }
};
```

## DP Optimized

We can optimize [[#DP]] by storing `dp` in `nums` so that the *space complexity* is **reduced** from `O(N)` to `O(1)`.

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = nums[0];
        for (int i = 1; i < nums.size(); ++i) {
            nums[i] += max(nums[i - 1], 0);
            ans = max(ans, nums[i]);
        }
        return ans;
    }
};
```

## DP Efficient

What if we are not allowed th change the value in `nums` array?

Since `dp[i+1]` is only **dependent** on `dp[i]`, we can use `O(1)` space to store `dp` *array* -- only **store** the *last value*.

So we put the *maximum subarray sum* we've seen thus far into the `cur` variable.
When we need to update `cur` for the current `nums[i]`, we can simply do 
$$\mathrm{cur = max(cur, 0) + n}$$

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = INT_MIN, cur = INT_MIN;
        for (int n : nums) {
            cur = max(cur, 0) + n;
            ans = max(ans, cur);
        }
        return ans;
    }
};
```

## Divide and Conquer

```cpp
// Time: O(NlogN)
// Space: O(logN)
class Solution {
private:
    int crossSum(vector<int>& nums, int L, int R, int p) {
        if (L == R) return nums[L];
        int left = INT_MIN, right = INT_MIN, i, sum;
        for (i = p, sum = 0; i >= L; --i) {
		    left = max(left;
		    sum += nums[i]);
        }
        for (i = p + 1, sum = 0; i <= R; ++i) {
	        right = max(right, sum += nums[i]);
        }
        return left + right;
    }
    
    int helper(vector<int>& nums, int L, int R) {
        if (L == R) return nums[L];
        int p = (L + R) / 2;
        int left = helper(nums, L, p);
        int right = helper(nums, p + 1, R);
        int cross = crossSum(nums, L, R, p);
        return max(left, max(right, cross));
    }
public:
    int maxSubArray(vector<int>& nums) {
        return helper(nums, 0, nums.size() - 1);
    }
};
```

---
# [Max Sum of Rectangle No Larger Than K](https://leetcode.com/problems/max-sum-of-rectangle-no-larger-than-k/)
#### Difficulty :`Hard`
#### Tags : #array #binSrch #dp #matrix #set

Given an `m x n` *matrix* `matrix` and an *integer* `k`, return the **max sum** of a *rectangle* in the *matrix* such that its *sum* is no **larger than** `k`.

It is **guaranteed** that there will be a *rectangle* with a *sum* **no larger** than `k`.


> [!faq] Follow up
> What if the **number of** *rows* is much **larger** than the **number of** *columns?*

## Note

The brute force solution is enumerating `O((MN)^2)` all rectangles and for each rectangle sum the matrix sum in `O(MN)` time. 
The overall time complexity is `O((MN)^3)` which is too slow.

A better brute force is using *prefix sum* to save the `O(MN)` time **calculating the matrix sum** given a *rectangle.* The overall *time complexity* is `O((MN)^2)`.
Since `M` and `N` are at most `100`, the *time complexity* is around `O(10^8)` which will still get **TLE**.

Now consider a **single row** *matrix,* we can **scan** the *matrix* from **left** to **right** and keep storing the *prefix sums* we've seen in a *set.* For the **current prefix sum** `S`, we want to find a *prefix sum* `X` from *set* that `S - X <= K`, i.e. `X >= S - K`. 

To find such a `X`, we can **leverage** `lower_bound` of `set` which takes `O(logN)` time. 
So this *algorithm* overall takes `O(NlogN)` time.

For a `2 x N` *matrix,* how to **find a 2-row submatrix** with *sum* `<= K`? We can **compress** the *matrix* by **summing each column** individually.

```
2  1 -4
1  0  1

// after compression

3  1 -3 
```

Then for this **compressed** `(3 1 -3)` *vector,* we can use the *algorithm* above for a **single row** *matrix.*

For a `M x N` *matrix,* we can **enumerate** different starting *rows.* For each **starting** *row,* we **extend** the **bottom edge** of the *matrix* continuously until it **reaches** the *end.*

During this **extention,** we can keep **compressing** the *matrix* and running the *algorithm* for the **compressed** *vector.*

The overall *time complexity* is `O(M^2 * NlogN)

## DP + Binary Search

```cpp
// Time: O(M^2 * NlogN)
// Space: O(N)
class Solution {
public:
    int maxSumSubmatrix(vector<vector<int>>& A, int k) {
        int M = A.size(), N = A[0].size(), ans = INT_MIN;

			// starting row
        for (int i = 0; i < M; ++i) { 
            vector<int> prefix(N, 0);

			// ending row
            for (int j = i; j < M; ++j) { 
                int sum = 0;
                set<int> s{0};
               
				for (int t = 0; t < N; ++t) {
                    sum += A[j][t];
                    prefix[t] += sum;
                    int target = prefix[t + 1] - k;
                    auto it = s.lower_bound(target);
   
					if (it != s.end()) {
                        ans = max(ans, prefix[t] - *it);
                    }
                    s.insert(prefix[t]);
                }
            }
        }
        return ans;
    }
};
```

Or extract the `maxSumSubarray` function.

```cpp
// Time: O(M^2 * NlogN)
// Space: O(N)
class Solution {
    int maxSumSubarray(vector<int> &A, int k) {
        set<int> s{0};
        int ans = INT_MIN;
        for (int n : A) {
            int target = n - k;
            auto it = s.lower_bound(target);
            if (it != s.end()) ans = max(ans, n - *it);
            s.insert(n);
        }
        return ans;
    }
public:
    int maxSumSubmatrix(vector<vector<int>>& A, int k) {
        int M = A.size(), N = A[0].size(), ans = INT_MIN;

			// starting row
        for (int i = 0; i < M; ++i) { 
            vector<int> prefix(N, 0);

			// ending row
            for (int j = i; j < M; ++j) { 
                int sum = 0;
                for (int t = 0; t < N; ++t) {
                    sum += A[j][t];
                    prefix[t] += sum;
                }
                ans = max(ans, maxSumSubarray(prefix, k));
            }
        }
        return ans;
    }
};
```

## Transpose Matrix to Reduce Time

Considering the follow-up, the original *algorithm* is using `O(M^2 * NlogN)` time and `M` is always the **number of** *rows.*

If the **number of** *rows* is way larger than **number of** *columns,* we should **transpose the** *matrix.*

```cpp
// Time: O(min(M, N)^2 * max(M, N)log(max(M, N)))
// Space: O(max(M, N))
class Solution {
    int maxSumSubarray(vector<int> &A, int k) {
        set<int> s{0};
        int ans = INT_MIN;
        for (int n : A) {
            int target = n - k;
            auto it = s.lower_bound(target);
            if (it != s.end()) ans = max(ans, n - *it);
            s.insert(n);
        }
        return ans;
    }
public:
    int maxSumSubmatrix(vector<vector<int>>& A, int k) {
        int M = A.size(), N = A[0].size(), ans = INT_MIN;
        bool swapped = M > N;
        if (swapped) swap(M, N);
        for (int i = 0; i < M; ++i) { // starting row
            vector<int> prefix(N, 0);
            for (int j = i; j < M; ++j) { // ending row
                int sum = 0;
                for (int t = 0; t < N; ++t) {
                    sum += swapped ? A[t][j] : A[j][t];
                    prefix[t] += sum;
                }
                ans = max(ans, maxSumSubarray(prefix, k));
            }
        }
        return ans;
    }
};
```

## Kadane Optimization

The `maxSumSubarray` *function* takes `O(NlogN)` time. We can use **Kadane algorithm** to get the **maximum subarray sum** in `O(N)` time, and if the **maximum subarray sum** is no more than `k`, we can directly **return** it.

```cpp
// Time: O(min(M, N)^2 * max(M, N)log(max(M, N)))
// Space: O(max(M, N))
class Solution {
    int kadane(vector<int> &A) {
        int ans = INT_MIN, mx = 0;
        for (int n : A) {
            mx = max(mx + n, n);
            ans = max(ans, mx);
        }
        return ans;
    }
    int maxSumSubarray(vector<int> &A, int k) {
        int maxKadane = kadane(A);
        if (maxKadane <= k) return maxKadane;
        set<int> s{0};
        int ans = INT_MIN, sum = 0;
        for (int n : A) {
            sum += n;
            int target = sum - k;
            auto it = s.lower_bound(target);
            if (it != s.end()) ans = max(ans, sum - *it);
            s.insert(sum);
        }
        return ans;
    }
public:
    int maxSumSubmatrix(vector<vector<int>>& A, int k) {
        int M = A.size(), N = A[0].size(), ans = INT_MIN;
        bool swapped = M > N;
        if (swapped) swap(M, N);
        for (int i = 0; i < M; ++i) { // starting row
            vector<int> sum(N, 0);
            for (int j = i; j < M; ++j) { // ending row
                for (int t = 0; t < N; ++t){
					sum[t] += swapped ? A[t][j] : A[j][t];
                } 
                ans = max(ans, maxSumSubarray(sum, k));
            }
        }
        return ans;
    }
};
```
---

# [Substring With Largest Variance](https://leetcode.com/problems/substring-with-largest-variance)
#### **Difficulty:** `Hard`
#### **Tags** : #array #dp


The **variance** of a string is defined as the largest difference between the number of occurrences of **any** `2` characters present in the string. Note the two characters may or may not be the same.

Given a string `s` consisting of lowercase English letters only, return _the **largest variance** possible among all **substrings** of_ `s`.

---

## Kadane's Algorithm

A similar approach can be used to solve this problem. Although `s` may contain many different characters, we can focus on one pair of letters `(major, minor)` at a time and calculate the maximum difference between their occurrences by applying Kadane's algorithm over all substrings of `s` that contain both `major` and `minor`.

> In other words, we assign the value of `major` as 1, the value of `minor` as -1, and the value of all other letters as 0, and use the standard Kadane's algorithm to find the maximum subarray sum in the array representing `s`.

[![img](https://camo.githubusercontent.com/e5dc0c1f7407a4df7806efade24ae4e49fcd27fbe2a3e2488af181b95dded336/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f6578702e706e67)](https://camo.githubusercontent.com/e5dc0c1f7407a4df7806efade24ae4e49fcd27fbe2a3e2488af181b95dded336/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f6578702e706e67)

For instance, let's consider the pair of letters `(a, b)` as `(major, minor)` and determine their maximum variance in `s`. We update two variables `major_count` and `minor_count`, to keep track of the number of `major` and `minor` in the substring ending at the current index. Thus, `local_max` can be represented as `major_count - minor_count`. The equivalent of resetting `local_max` to 0 is setting both `major_count` and `minor_count` to 0.

[![img](https://camo.githubusercontent.com/9f8c9ebed71ff649842ceabb2e96c13e72cca0c1956f45569d05834b72112c97/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f322e706e67)](https://camo.githubusercontent.com/9f8c9ebed71ff649842ceabb2e96c13e72cca0c1956f45569d05834b72112c97/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f322e706e67)

We notice that the standard Kadane's algorithm has failed to solve the problem. This is because Kadane's algorithm allows the subarray being considered to have no element with negative value. However, in our problem, a valid substring must contain at least one `major` and one `minor`, so the maximum variance calculated by regular Kadane's algorithm does not necessarily represent a valid substring.

Therefore, we need to modify Kadane's algorithm to solve this problem.

> Update `global_max` only when `minor_count > 0`.

This ensures that we only consider valid substrings that contain at least one `minor`. As shown in the picture below, we cannot update `global_max` if `minor_count = 0`. However, after encountering at least one `minor`, we can update `global_max` as `global_max = max(global_max, local_max) = 2`.

[![img](https://camo.githubusercontent.com/f19bd94ac914310045b179e2e2a5ffb989598a3211a8c4debe5a1548deced4fa/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f332e706e67)](https://camo.githubusercontent.com/f19bd94ac914310045b179e2e2a5ffb989598a3211a8c4debe5a1548deced4fa/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f332e706e67)

> Reset `local_max` to 0 only when there is at least one `minor` in the remaining substring.

Recall that we need a step `local_max = max(local_max, 0)` in regular Kadane's algorithm, which always discards the current subarray if it has a negative sum.

In this problem, however, we cannot simply reset `local_max` to 0 whenever it becomes negative because doing so would reset both `major_count` and `minor_count` to 0. If there are no more `minor` in the remaining string, the `minor_count` will remain 0, and we will never be able to update `global_max` during the remaining traversal. To avoid this situation, we reset `local_max` to 0 only when there is at least one `minor` in the remaining `s`. To achieve this, we can use an additional variable `rest_minor` to keep track of the number of `minor` in the remaining string.

As shown below, if `local_max < 0` and there is still `minor` in the remaining string, we can reset it to 0 (i.e., reset both `minor_count` and `major_count` to 0).

[![img](https://camo.githubusercontent.com/fd7c9fea4df8880929e9282046342ece355f4326d2a6ee03f5de41fc82b8cd09/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f342e706e67)](https://camo.githubusercontent.com/fd7c9fea4df8880929e9282046342ece355f4326d2a6ee03f5de41fc82b8cd09/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f342e706e67)

However, if there is no `minor` left in the remaining string, we cannot reset `minor_count` or `major_count` to 0, as any valid string found in the following iteration must contain at least one `minor`, so we cannot discard the last `minor` by setting `minor_count` to 0.

[![img](https://camo.githubusercontent.com/de5abc62bb512075913de8a984542eca0d84c952cf8adc7e4554bd35626e0ccf/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f352e706e67)](https://camo.githubusercontent.com/de5abc62bb512075913de8a984542eca0d84c952cf8adc7e4554bd35626e0ccf/68747470733a2f2f6c656574636f64652e636f6d2f70726f626c656d732f737562737472696e672d776974682d6c6172676573742d76617269616e63652f466967757265732f323237322f352e706e67)

To sum up, we will identify every pair of different letters in the given string, treat one as a `major` letter and the other as a `minor` letter, and then apply the modified Kadane's algorithm to traverse `s`. During the traversal, we need to keep track of the maximum variance between the occurrences of `major` and `minor`, which we call `global_max`. After traversing all the substrings for each pair of `major` and `minor`, we take the maximum value of `global_max` as the final result.

  

### Algorithm

1. Initialize a counter to record the count of each distinct character in `s`. (Since we already know in advance that `s` contains only 26 different letters, we can use an array of length 26 as the counter)
    
2. For each pair of distinct letters `major` and `minor`, we apply Kadane's algorithm with modifications. All different pairs of distinct letters are considered, and **two pairs of the same letters in different orders are considered to be different**. In short, we will consider both `(a, b)` and `(b, a)`.
    
3. Set `global_max`, `major_count` and `minor_count` to 0, and let `rest_minor` be the number of character `minor` in the string.
    
4. Traverse the string `s`, and for each letter `ch`:
    
    - If `ch` is `major`, increment `major_count` by 1.
    - If `ch` is `minor`, increment `minor_count` by 1 and decrement `rest_minor` by 1.
5. Update `global_max` only when `minor_count > 0` (The first modification).
    
6. If `major_count - minor_count < 0`, reset them to 0 only when `rest_minor > 0` (The second modification).
    
7. Move on to the next pair of letters `(major, minor)` and repeat from step 3.
    
8. Return `global_max` when the iteration is complete.
    

### Complexity Analysis

Let nnn be the length of the input string `s` and kkk be the number of distinct characters in `s`.

- Time complexity: O(n⋅k2)O(n \cdot k^2)O(n⋅k2)
    
    - Kadane's algorithm requires O(n)O(n)O(n) time to traverse `s`. For each pair of alphabets `(major, minor)`, we need to traverse `s` once. In the worst-case scenario, `s` contains k=26k = 26k=26 different letters, so there are k⋅(k−1)k\cdot (k - 1)k⋅(k−1) possible pairs of letters.
- Space complexity: O(1)O(1)O(1)
    
    - In the Kadane's algorithm, we only need to update a few variables, `major_count`, `minor_count`, `rest_minor` and `global_max`, which require O(1)O(1)O(1) space.

  

```cpp
// Time: O(N * C^2) where C is the range of character set
// Space: O(1)
    int largestVariance(string s) {
        int N = s.size(), cnt[26] = {}, ans = 0;
        for (char c : s) cnt[c - 'a']++;
        auto variance = [&](char major, char minor) {
            int majorCnt = 0;
            int minorCnt = 0;
            int restMinor = cnt[minor - 'a']
            int ans = 0;
            for (char c : s) {
                majorCnt += c == major;
                if (c == minor) {
                    minorCnt++;
                    restMinor--;
                }
                if (minorCnt > 0){
	                ans = max(ans, majorCnt - minorCnt);
                } 
                if (majorCnt < minorCnt && restMinor > 0) {
                    majorCnt = 0;
                    minorCnt = 0;
                }
            }
            return ans;
        };
        for (char a = 'a'; a <= 'z'; ++a) {
            for (char b = 'a'; b <= 'z'; ++b) {
                if (a == b ||
                cnt[a - 'a'] == 0 ||
                 cnt[b - 'a'] == 0) continue;
                ans = max(ans, variance(a, b));
            }
        }
        return ans;
    }
};
```