---
type: DSA
topic: sorting
---

## Algorithm:

- First Select the *range* of **Unsorted Array** by a loop that indicates start index of range ( **i** ) 
  So, the loop will run with varying range from 0 to n - 1
- Now, in Each iteration we select **minimum element** from the current *range* using a *inner loop*.
- After that we swap **minimum element** with **i** ( *start elemet of the range* ).


## Code:
```cpp
void selection_sort(vector<int> arr, int n){
	for(int i = 0; i < n - 1; i++){
		int min_idx = i;
		for(int j = i + 1; j < n; j++){
			if(arr[j] < arr[min_idx]){
				min_idx = j;
			}
		}
		int temp = arr[min_idx];
		arr[min_idx] = arr[i];
		arr[i] = temp;
	}
}
```


> [!NOTE]  Complexity:
> - Time: **O(N<sup>2</sup>)**
> - Space: **O(1)**



