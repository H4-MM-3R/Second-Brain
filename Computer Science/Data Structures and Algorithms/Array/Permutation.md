
> [!example] Problems 
> - [[#[Next Permutation](https //leetcode.com/problems/next-permutation/)|Next Permutation]]
> - [[#[Permutations](https //leetcode.com/problems/permutations/)|Permutations (distinct digits)]]
> - [[#[Permutations II](https //leetcode.com/problems/permutations-ii/)|Permutations (might contain duplicate)]]

---
# [Next Permutation](https://leetcode.com/problems/next-permutation/)
#### Difficulty : `Medium`
#### Tags : #array #2ptr 


The **next permutation** of an array of integers is the next lexicographically greater permutation of its integer.

Given an array of integers `nums`, _find the next permutation of_ `nums`.

The replacement must be **[in place](http://en.wikipedia.org/wiki/In-place_algorithm)** and use only constant extra memory.


## Solution

```cpp
// Time: O(N)
// Space: O(1)
class Solution {
public:
    void nextPermutation(vector<int>& A) {
        int N = A.size(), i = N - 1;
        
// find the first element of a descending subarray from the end.
        while (i - 1 >= 0 && A[i - 1] >= A[i]) --i;
        
        // reverse this descending subarray
        reverse(begin(A) + i, end(A)); 
        if (i - 1 >= 0){

	// swap A[i-1] with the first element greater than `A[i-1]`
     swap(*upper_bound(begin(A) + i, end(A), A[i - 1]), A[i - 1]);
        } 
    }
};
```

---

# [Permutations](https://leetcode.com/problems/permutations/)
#### **Difficulty** : `Medium`
#### **Tags** : #backtrack

Given a *collection* of **distinct** *integers,* return all **possible** *permutations.*

## DFS

For a particular DFS level, let `start` be the index of element we manipulate in this level.

We swap `nums[start]` with a digit whose index `>= start`.

After the swap, we DFS one step further, i.e. `dfs(nums, start + 1)`.

Once the children DFS returns, we recover the array by swapping them back.

The exit condition of DFS is when the `start` index points to the last digit, then we can push the current `nums` into answers.

The initial call is `dfs(nums, 0)`.

Note that:

1. This function doesn't care whether the `nums` is sorted.
2. The permutations generated is NOT in lexigraphical order. For example, if input is `[1,2,3]`, then output is `[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,2,1],[3,1,2]]`

```cpp
// Time: O(N!)
// Space: O(N)
class Solution {
    vector<vector<int>> ans;
    void dfs(vector<int> &nums, int start) {
        if (start == nums.size() - 1) {
            ans.push_back(nums);
            return;
        }
        for (int i = start; i < nums.size(); ++i) {
            swap(nums[i], nums[start]);
            dfs(nums, start + 1);
            swap(nums[i], nums[start]);
        }
    }
public:
    vector<vector<int>> permute(vector<int>& nums) {
        dfs(nums, 0);
        return ans;
    }
};
```

## Use NextPermutation

```cpp
// Time: O(N!)
// Space: O(1)
class Solution {
    bool nextPermutation(vector<int> &nums) {
        int i = nums.size() - 2, j = nums.size() - 1;
        while (i >= 0 && nums[i] >= nums[i + 1]) --i;
        if (i >= 0) {
            while (j > i && nums[j] <= nums[i]) --j;
            swap(nums[i], nums[j]);
        }
        reverse(nums.begin() + i + 1, nums.end());
        return i >= 0;
    }
public:
    vector<vector<int>> permute(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<vector<int>> ans { nums };
        while (nextPermutation(nums)) ans.push_back(nums);
        return ans;
    }
};
```

---

# [Permutations II](https://leetcode.com/problems/permutations-ii/)
#### Difficulty : `Medium`
#### Tags : #array #backtrack 

Given a collection of numbers, `nums`, that might contain duplicates, return _all possible unique permutations **in any order**._

## Solution 1

Similar idea as the DFS solution to [46. Permutations (Medium)](https://github.com/lzl124631x/LeetCode/blob/master/leetcode/46.%20Permutations). We pick a number after `A[i]` and swap it with `A[i]` and don't swap back. So this new `A[i]` is the number we last

But since there are duplicates, we shouldn't swap the `A[i]` with the same digit twice.

The first idea is sorting the array and only swapping numbers `A[j] != A[j-1]` with `A[i]`. But this only works when the array after `A[i]` is sorted. After some swap, this might not be true.

To resolve this issue, one brute force way is to simply keep copying the array during DFS, which adds time and space complexity.

```cpp
// Time: O(N! * N)
// Space: O(N^2)
class Solution {
private:
  vector<vector<int>> ans;
  void permute(vector<int> nums, int start) {
    if (start == nums.size() - 1) {
      ans.push_back(nums);
      return;
    }
    for (int i = start; i < nums.size(); ++i) {
      if (i != start && nums[i] == nums[start]){
	      continue;
      } 
      swap(nums[i], nums[start]);
      permute(nums, start + 1);
    }
  }
public:
 vector<vector<int>> permuteUnique(vector<int>& nums){
    sort(nums.begin(), nums.end());
    permute(nums, 0);
    return ans;
  }
};
```

## Solution 2

Assume `nums` is sorted.

Consider [the DFS solution to 46. Permutations](https://github.com/lzl124631x/LeetCode/blob/master/leetcode/46.%20Permutations). In each DFS level, assume the numbers starting from index `start` are sorted, then if `nums[i]` is the same as the number in front of itself, when `nums[i]` should be skipped because we've used the same number before.

For example, `start = 0, nums = [1,1,2], i = 1`, since `nums[i] = 1 = nums[i - 1]`, it means that we already did DFS using `nums[i - 1]` so we shouldn't try to put `nums[i]` at `nums[start]`.

If `nums[i]` is the first digit in the sequence of the same digit, we move it to `nums[start]` and DFS one step further.

And after that, we move it back from `nums[start]` to `nums[i]`.

We can not just swap `nums[i]` and `nums[start]` because it will break the assumption that the numbers starting from index `start` are sorted. For example, `start = 0, nums = [1, 1, 2, 2, 3, 3], i = 4`, if we do swap we get `[3, 1, 2, 2, 1, 3]` which breaks the sorted assumption.

So we have to move the numbers one by one.

```cpp
// Time: O(N! * N)
// Space: O(N)
class Solution {
    vector<vector<int>> ans;
    void move(vector<int> &nums, int from, int to) {
        int tmp = nums[from], d = from > to ? -1 : 1;
        for (int i = from; i != to; i += d){
	        nums[i] = nums[i + d];
        } 
        nums[to] = tmp;
    }
    void permute(vector<int> &nums, int start) {
        if (start == nums.size()) {
            ans.push_back(nums);
            return;
        }
        int prev = nums[start];
        for (int i = start; i < nums.size(); ++i) {
            if (i != start && nums[i] == prev) {
	            continue;
            }
            move(nums, i, start);
            permute(nums, start + 1);
            move(nums, start, i);
            prev = nums[i];
        }
    }
public:
 vector<vector<int>> permuteUnique(vector<int>& nums){
        sort(nums.begin(), nums.end());
        permute(nums, 0);
        return ans;
    }
};
```

## Solution 3

Similar to Solution 2, based on [the DFS solution to 46. Permutations](https://github.com/lzl124631x/LeetCode/blob/master/leetcode/46.%20Permutations).

But when we check whether the `nums[i]` is used before, we simply use a set to store the visited digits!

The logic of this code is way simpler. It's just that the set takes extra space.

```cpp
// Time: O(N!)
// Space: O(N^2)
class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& A){
        vector<vector<int>> ans;
        int N = A.size();
        sort(begin(A), end(A));
        function<void(int)> permute = [&](int i) {
            if (i == N) {
                ans.push_back(A);
                return;
            }
            bool seen[21] = {};
            for (int j = i; j < N; ++j) {
                if (seen[A[j] + 10]) continue;
                seen[A[j] + 10] = true;
                swap(A[i], A[j]);
                dfs(i + 1);
                swap(A[i], A[j]);
            }
        };
        dfs(0);
        return ans;
    }
};
```

## Solution 4

Based on [the solution to 31. Next Permutation](https://github.com/lzl124631x/LeetCode/blob/master/leetcode/31.%20Next%20Permutation).

```cpp
// Time: O(N!)
// Space: O(1)
class Solution {
private:
  bool nextPermutation(vector<int> &nums) {
    int i = nums.size() - 2, j = nums.size() - 1;
    while (i >= 0 && nums[i] >= nums[i + 1]) --i;
    if (i >= 0) {
        while (j > i && nums[j] <= nums[i]) --j;
        swap(nums[i], nums[j]);
    }
    reverse(nums.begin() + i + 1, nums.end());
    return i != -1;
  }
public:
 vector<vector<int>> permuteUnique(vector<int>& nums){
    sort(nums.begin(), nums.end());
    vector<vector<int>> ans { nums };
    while (nextPermutation(nums)) ans.push_back(nums);
    return ans;
  }
};
```

## Solution 5

See explanations in [https://youtu.be/nYFd7VHKyWQ](https://youtu.be/nYFd7VHKyWQ)

```cpp
// Time: O(N!)
// Space: O(N)
class Solution {
    vector<int> cnt;
    vector<int> digit;
    vector<vector<int>> ans;
    void dfs(vector<int> &nums, int start) {
        if (start == nums.size()) {
            ans.push_back(nums);
            return;
        }
        for (int i = 0; i < cnt.size(); ++i) {
            if (!cnt[i]) continue;
            cnt[i]--;
            nums[start] = digit[i];
            dfs(nums, start + 1);
            cnt[i]++;
        }
    }
public:
 vector<vector<int>> permuteUnique(vector<int>& nums){
        map<int, int> m;
        for (int n : nums) m[n]++;
        for (auto p : m) {
            digit.push_back(p.first);
            cnt.push_back(p.second);
        }
        dfs(nums, 0);
        return ans;
    }
};
```

