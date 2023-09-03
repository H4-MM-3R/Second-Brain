
> [!faq] Index 
> - Quick Select
>  **Problems**
> - [[#[Kth Largest Element in an Array](https //leetcode.com/problems/kth-largest-element-in-an-array/)|Kth Largest Element in an Array]]
> - [[#[K Closest Points to Origin](https //leetcode.com/problems/k-closest-points-to-origin/)|K Closest Points to Origin]]
> - [[#[The k Strongest Values in an Array](https //leetcode.com/problems/the-k-strongest-values-in-an-array/)|The k Strongest Values in an Array]]

Quickselect is a selection algorithm to find the k-th smallest/largest element in an unordered list. It uses the `partition` method in Quick Sort.
The difference is , instead of recurring for both sides (after finding pivot). It recurs only for the part that contains the k-th smallest/largest element.

The time complexity is `O(N)` on average, and `O(N^2)` in the worst case.

## Implementation

Quick select with elements sorted in ascending order.
```cpp
// Time: O(N) on averge, O(N^2) in the worst case
// Space: O(1)
class Solution {
    int partition(vector<int> &A, int L, int R) {
        int i = L;
        int pivotIndex = L + rand() % (R - L + 1);
        int pivot = A[pivotIndex];
        swap(A[pivotIndex], A[R]);
        for (int j = L; j < R; ++j) {
            if (A[j] < pivot) swap(A[i++], A[j]);
        }
        swap(A[i], A[R]);
        return i;
    }
public:
    int findKthLargest(vector<int>& A, int k) {
        int L = 0, R = A.size() - 1;
        k = A.size() - k + 1;
        while (true) {
            int M = partition(A, L, R);
            if (M + 1 == k) return A[M];
            if (M + 1 > k) R = M - 1;
            else L = M + 1;
        }
    }
};
```

Quick select with elements sorted in descending order.

```cpp
// Time: O(N) on averge, O(N^2) in the worst case
// Space: O(1)
class Solution {
    int partition(vector<int> &A, int L, int R) {
        int i = L;
        int pivotIndex = L + rand() % (R - L + 1);
        int pivot = A[pivotIndex];
        swap(A[pivotIndex], A[R]);
        for (int j = L; j < R; ++j) {
            if (A[j] > pivot) swap(A[i++], A[j]);
        }
        swap(A[i], A[R]);
        return i;
    }
public:
    int findKthLargest(vector<int>& A, int k) {
        int L = 0, R = A.size() - 1;
        while (true) {
            int M = partition(A, L, R);
            if (M + 1 == k) return A[M];
            if (M + 1 > k) R = M - 1;
            else L = M + 1;
        }
    }
};
```

Or STL

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        nth_element(begin(A), begin(A) + k - 1, end(A), greater<int>());
        return A[k - 1];
    }
};
```


> [!example] problems 
> - 215
> - 973
> - 1471


# [Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array/)
#### Difficulty : `Medium`
#### Tags : #array #divConq #sort #heap #quickselect


Given an integer array `nums` and an integer `k`, return _the_ `kth` _largest element in the array_.

Note that it is the `kth` largest element in the sorted order, not the `kth` distinct element.

## Heap Sort

```cpp
// Time: O(N + klogN)
// Space: O(1)
class Solution {
    void siftDown(vector<int> &A, int end, int index) {
        if (index < 0 || index >= end) return;
        int child = 2 * index + 1;
        while (child < end) {
            if (child + 1 < end && A[child + 1] > A[child]){
	            ++child;
            } 
            if (A[index] > A[child]) break;
            swap(A[index], A[child]);
            index = child;
            child = 2 * index + 1;
        }
    }
    void heapify(vector<int> &A) {
        for (int i = A.size() / 2 - 1; i >= 0; --i){
	        siftDown(A, A.size(), i);
        } 
    }
public:
    int findKthLargest(vector<int>& A, int k) {
        heapify(A);
        int N = A.size();
        for (int i = 1; i < k; ++i) {
            swap(A[0], A[N - 1]);
            --N;
            siftDown(A, N, 0);
        }
        return A[0];
    }
};
```

Or use STL's `make_heap` and `pop_heap`.

```cpp
// Time: O(N + klogN)
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        make_heap(begin(A), end(A));
        while (--k) {
            pop_heap(begin(A), end(A));
            A.pop_back();
        }
        return A[0];
    }
};
```

## Min-heap

```cpp
// Time: O(NlogK)
// Space: O(K)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        priority_queue<int, vector<int>, greater<>> pq;
        for (int n : A) {
            pq.push(n);
            if (pq.size() > k) pq.pop();
        }
        return pq.top();
    }
};
```

Or

```cpp
// Time: O(k + (N - k)logk)
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        make_heap(begin(A), begin(A) + k, greater<int>());
        for (int i = k; i < A.size(); ++i) {
            if (A[i] <= A[0]) continue;
            pop_heap(begin(A), begin(A) + k, greater<int>());
            swap(A[i], A[k - 1]);
            push_heap(begin(A), begin(A) + k, greater<int>());
        }
        return A[0];
    }
};
```

## Max-heap

```cpp
// Time: O(N - k + klog(N - k))
// Space: O(N - k)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        priority_queue<int> pq;
        k = A.size() - k + 1;
        for (int n : A) {
            pq.push(n);
            if (pq.size() > k) pq.pop();
        }
        return pq.top();
    }
};
```

Or

```cpp
// Time: O((N - k) + klog(N - k))
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        int len = A.size() - k + 1;

		// maintain a max-heap in [0, N - k]
        make_heap(begin(A), begin(A) + len); 
        for (int i = len; i < A.size(); ++i) {
            if (A[i] >= A[0]) continue;
            pop_heap(begin(A), begin(A) + len);
            swap(A[i], A[len - 1]);
            push_heap(begin(A), begin(A) + len);
        }
        return A[0];
    }
};
```

Or we can combine the max-heap and min-heap depending on `k`.

```cpp
// Time: O(Nlog(min(k, N - k)))
// Space: O(min(k, N - k))
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        function<bool(int, int)> cmp = greater<int>();
        int size = k;
        if (k > A.size() / 2) {
            cmp = less<int>();
            size = A.size() - k + 1;
        }
        priority_queue<int, vector<int>, decltype(cmp)> pq(cmp);
        for (int n : A) {
            pq.push(n);
            if (pq.size() > size) pq.pop();
        }
        return pq.top();
    }
};
```

## Quick Select

Quick select with elements sorted in descending order.

```cpp
// Time: O(N) on averge, O(N^2) in the worst case
// Space: O(1)
class Solution {
    int partition(vector<int> &A, int L, int R) {
        int i = L;
        int pivotIndex = L + rand() % (R - L + 1);
        int pivot = A[pivotIndex];
        swap(A[pivotIndex], A[R]);
        for (int j = L; j < R; ++j) {
            if (A[j] > pivot) swap(A[i++], A[j]);
        }
        swap(A[i], A[R]);
        return i;
    }
public:
    int findKthLargest(vector<int>& A, int k) {
        int L = 0, R = A.size() - 1;
        while (true) {
            int M = partition(A, L, R);
            if (M + 1 == k) return A[M];
            if (M + 1 > k) R = M - 1;
            else L = M + 1;
        }
    }
};
```

Or use STL's `nth_element`.

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        nth_element(begin(A), begin(A) + k - 1, end(A), greater<>(
        ));
        return A[k - 1];
    }
};
```

Or use `partial_sort`

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(1)
class Solution {
public:
    int findKthLargest(vector<int>& A, int k) {
        partial_sort(begin(A), begin(A) + k, end(A), greater<>());
        return A[k - 1];
    }
};
```

---
# [K Closest Points to Origin](https://leetcode.com/problems/k-closest-points-to-origin/)
#### Difficulty : `Medium`
#### Tags : #array #math #divConq #geometry #sort #heap #quickselect 

Given an array of `points` where `points[i] = [xi, yi]` represents a point on the **X-Y** plane and an integer `k`, return the `k` closest points to the origin `(0, 0)`.

The distance between two points on the **X-Y** plane is the Euclidean distance (i.e., `√(x1 - x2)2 + (y1 - y2)2`).

You may return the answer in **any order**. The answer is **guaranteed** to be **unique** (except for the order that it is in).

## Sort

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
private:
    int dist(vector<int> &p) {
        return p[0] * p[0]  + p[1] * p[1];
    }
public:
vector<vector<int>> kClosest(vector<vector<int>>& points, int K){
    sort(points.begin(), points.end(), [&](auto &a, auto &b) {
	  return dist(a) < dist(b);
  } );
 return vector<vector<int>>(points.begin(), points.begin() + K);
    }
};
```

## Heap of size `N`

Keep a min-heap of all elements and pop `K` times.

Heap creation takes `O(N)`. Popping an element takes `O(logN)` which we repeat `K` times.

```cpp
// Time: O(N + KlogN)
// Space: O(N)
class Solution {
    int dist(vector<int> &p) {
        return p[0] * p[0] + p[1] * p[1];
    }
public:
    vector<vector<int>> kClosest(vector<vector<int>>& A, int K) {
      auto cmp= [&](auto &a, auto &b) {return dist(a) > dist(b);};
        priority_queue<
	        vector<int>, 
	        vector<vector<int>>,
	        decltype(cmp)
        > pq(begin(A), end(A), cmp);
        vector<vector<int>> ans;
        while (ans.size() < K) {
            ans.push_back(pq.top());
            pq.pop();
        }
        return ans;
    }
};
```

Or use `make_heap` and `pop_heap` in place.

```cpp
// Time: O(N + KlogN)
// Space: O(1)
class Solution {
    int dist(vector<int> &p) {
        return p[0] * p[0] + p[1] * p[1];
    }
public:
    vector<vector<int>> kClosest(vector<vector<int>>& A, int k) {
        make_heap(begin(A), end(A), [&](auto &a, auto &b) {
	        return dist(a) > dist(b);
        };);
        vector<vector<int>> ans;
        while (k--) {
            pop_heap(begin(A), end(A), cmp);
            ans.push_back(A.back());
            A.pop_back();
        }
        return ans;
    }
};
```

## Heap of size `K`

If the space is limited, we can keep a max-heap of size `K`.

We loop through each point:

- If the heap has less than `K` elements, push the point into heap.
- Otherwise, if the distance of the element is smaller than that of the heap top, we pop the heap top and push this point into heap.

In the end, all the elements left in the heap forms the answer.

```cpp
// Time: O(NlogK)
// Space: O(K)
class Solution {
    int dist(vector<int> &p) {
        return p[0] * p[0] + p[1] * p[1];
    }
public:
   vector<vector<int>> kClosest(vector<vector<int>>& A, int K) {
     auto cmp = [&](auto &a, auto &b) {return dist(a) < dist(b);};
        priority_queue<
	        vector<int>,
	        vector<vector<int>>,
	        decltype(cmp)
	    > pq(cmp);
        for (auto &p : A) {
            pq.push(p);
            if (pq.size() > K) pq.pop();
        }
        vector<vector<int>> ans;
        while (pq.size()) {
            ans.push_back(pq.top());
            pq.pop();
        }
        return ans;
    }
};
```

## Quick Select

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(1)
class Solution {
    int dist(vector<int> &p) {
        return p[0] * p[0] + p[1] * p[1];
    }
    int quickSelect(vector<vector<int>> &A, int L, int R) {
        int i = L;
        int j = L;
        int pivotIndex = L + rand() % (R - L + 1);
        int pivot = dist(A[pivotIndex]);
        swap(A[pivotIndex], A[R]);
        for (; i < R; ++i) {
            if (dist(A[i]) < pivot) swap(A[i], A[j++]);
        }
        swap(A[j], A[R]);
        return j;
    }
public:
    vector<vector<int>> kClosest(vector<vector<int>>& A, int K) {
        int L = 0, R = A.size() - 1;
        while (L < R) {
            int M = quickSelect(A, L, R);
            if (M + 1 == K) break;
            if (M + 1 > K) R = M - 1;
            else L = M + 1;
        }
        return vector<vector<int>>(begin(A), begin(A) + K);
    }
```
---

# [1471. The k Strongest Values in an Array (Medium)](https://leetcode.com/problems/the-k-strongest-values-in-an-array/)
#### Difficulty : `Medium`
#### Tags : #array #2ptr #sort 
Given an array of integers `arr` and an integer `k`.

A value `arr[i]` is said to be stronger than a value `arr[j]` if `|arr[i] - m| > |arr[j] - m|` where `m` is the **median** of the array.  
If `|arr[i] - m| == |arr[j] - m|`, then `arr[i]` is said to be stronger than `arr[j]` if `arr[i] > arr[j]`.

Return _a list of the strongest `k`_ values in the array. return the answer **in any arbitrary order**.

- For `arr = [6, -3, 7, 2, 11]`, `n = 5` and the median is obtained by sorting the array `arr = [-3, 2, 6, 7, 11]` and the median is `arr[m]` where `m = ((5 - 1) / 2) = 2`. The median is `6`.
- For `arr = [-7, 22, 17, 3]`, `n = 4` and the median is obtained by sorting the array `arr = [-7, 3, 17, 22]` and the median is `arr[m]` where `m = ((4 - 1) / 2) = 1`. The median is `3`.

## Sort

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    vector<int> getStrongest(vector<int>& A, int k) {
        sort(A.begin(), A.end());
        int m = A[(A.size() - 1) / 2];
        sort(A.begin(), A.end(), [&](int &a, int &b) {
            return abs(a - m) == abs(b - m) ?
             a > b : (abs(a - m) > abs(b - m));
        });
        return vector<int> (A.begin(), A.begin() + k);
    }
};
```

## Two pointers

```cpp
// Time: O(NlogN)
// Space: O(1)
class Solution {
public:
    vector<int> getStrongest(vector<int>& A, int k) {
        sort(A.begin(), A.end());
        int m = A[(A.size() - 1) / 2], i = 0, j = A.size() - 1;
        vector<int> ans;
        while (ans.size() < k) {
            if (A[j] - m >= m - A[i]) ans.push_back(A[j--]);
            else ans.push_back(A[i++]);
        }
        return ans;
    }
};
```

## Quick Select

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(1)
class Solution {
public:
    vector<int> getStrongest(vector<int>& A, int k) {
        nth_element(
	         A.begin(),
	         A.begin() + (A.size() - 1) / 2,
	         A.end()
	    );
        int m = A[(A.size() - 1) / 2];
        partial_sort(
	        A.begin(),
	        A.begin() + k,
	        A.end(),
	        [&](int a, int b) {
	            return abs(a - m) == abs(b - m) ?
		            a > b : abs(a - m) > abs(b - m);
	        });
        return vector<int>(begin(A), begin(A) + k);
    }
};
```

Or

```cpp
// Time: O(N) on average, O(N^2) in the worst case
// Space: O(2)
class Solution {
public:
    vector<int> getStrongest(vector<int>& A, int k) {
        nth_element(
	        begin(A),
	        begin(A) + (A.size() - 1) / 2,
	        end(A)
	    );
        int m = A[(A.size() - 1) / 2];
        nth_element(
	        begin(A),
	        begin(A) + k - 1,
	        end(A),
	        [&](int a, int b) { 
	            return abs(a - m) == abs(b - m) ?
		             a > b : abs(a - m) > abs(b - m);
	        });
        return vector<int>(begin(A), begin(A) + k);
    }
};
```

## Heap

- `nth_element` is quick select taking `O(N)`.
- `priority_queue` initialized with array is `make_heap` (aka heapify), which is `O(N)`.
- Pulling from priority queue is `O(logN)` and we do it `k` times.

```cpp
// Time: O(N + KlogN)
// Space: O(1)
class Solution {
public:
    vector<int> getStrongest(vector<int>& A, int k) {
        nth_element(
	        A.begin(),
			A.begin() + (A.size() - 1) / 2,
	        A.end()
        );
        int m = A[(A.size() - 1) / 2];
        auto cmp = [&](int a, int b) {
            return abs(a - m) == abs(b - m) ?
	             a < b : abs(a - m) < abs(b - m); 
        };
        priority_queue<
	        int,
	        vector<int>,
	        decltype(cmp)
        > q(begin(A), end(A), cmp);
        vector<int> ans;
        while (ans.size() < k) {
            ans.push_back(q.top());
            q.pop();
        }
        return ans;
    }
}
```