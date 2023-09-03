---
type: DSA
topic: basics
---

# Problem: Count Freq of Elements
## Solution: 
### 2 Loops { O(N<sup>2</sup>) , O(N) }:
```cpp
vector<int> countFreq(vector<int> arr, int n){
	vector<int> ans(n + 1);
	vector<bool> visited(n, false);

	for (int i = 0; i < n; i++){
	//skip if visited
		if(visited[i]) continue;

	//count freq
		int cnt = 1;
		for(int j = 1; j < n; j++){
			if(arr[i] == arr[j]){
				visited[j] == true;
				cnt++;
			}	
		}
		ans.push_back(cnt);
	}
	return ans;
}
```
### Map { O(N) , O(N) }:
```cpp
vector<int countFreq(vector<int> arr, int n){
	vector<int> ans(n+1)
	unordered_map<int, int> mp;

	for(int i = 0; i < n; i++){
		mp[arr[i]]++;
	}
	for(auto x : mp){
		ans[x.first] = x.second;
	}
	return ans;
}
```


# Problem: High Freq element and Low Freq element
## Solution: 
find [[#Problem Count Freq of Elements|freq of all elements]] and use max() and min() for Highest frequency element and Lowest frequency element respectively.