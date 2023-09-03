# PreOrder
- 114
- 589
# [Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal)

#### Difficulty : `Easy`
#### Tags : #stack #tree #dfs #bintree 

Given the `root` of a binary tree, return _the preorder traversal of its nodes' values_.


> [!faq] Follow up
> Recursive solution is trivial, could you do it iteratively?

## Recursive

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
    vector<int> ans;
    void dfs(TreeNode *root) {
        if (!root) return;
        ans.push_back(root->val);
        dfs(root->left);
        dfs(root->right);
    }
public:
    vector<int> preorderTraversal(TreeNode* root) {
        dfs(root);
        return ans;
    }
};
```

## Iterative

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
public:
    vector<int> preorderTraversal(TreeNode* root) {
        if (!root) return {};
        vector<int> ans;
        stack<TreeNode*> s{{root}};
        while (s.size()) {
            root = s.top();
            s.pop();
            ans.push_back(root->val);
            if (root->right) s.push(root->right);
            if (root->left) s.push(root->left);
        }
        return ans;
    }
};
```

## Iterative (better refracted)

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
public:
    vector<int> preorderTraversal(TreeNode* root) {
        vector<int> ans;
        stack<TreeNode*> s;
        while (root || s.size()) {
            if (!root) {
                root = s.top();
                s.pop();
            }
            ans.push_back(root->val);
            if (root->right) s.push(root->right);
            root = root->left;
        }
        return ans;
    }
};
```

---

# [N-ary Tree Preorder Traversal](https://leetcode.com/problems/n-ary-tree-preorder-traversal)

#### Difficulty : `Easy`
#### Tags : #stack #tree #dfs

Given the `root` of an n-ary tree, return _the preorder traversal of its nodes' values_.

Nary-Tree input serialization is represented in their level order traversal. Each group of children is separated by the null value (See examples)

> [!faq] Follow up
> Recursive solution is trivial, could you do it iteratively?


## Recursive

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
public:
    vector<int> preorder(Node* root) {
        vector<int> ans;
        function<void(Node*)> dfs = [&](Node *root) {
            if (!root) return;
            ans.push_back(root->val);
            for (auto n : root->children) dfs(n);
        };
        dfs(root);
        return ans;
    }
};
```

## Iterative

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> preorder(Node* root) {
        if (!root) return {};
        vector<int> ans;
        stack<Node*> s{{root}};
        while (s.size()) {
            root = s.top();
            s.pop();
            ans.push_back(root->val);
            for (int i = root->children.size() - 1;i >= 0; --i){
	             s.push(root->children[i]);
            }
        }
        return ans;
    }
};
```

---

## InOrder
# [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal)

#### Difficulty : `Easy`
#### Tags : #stack #tree #dfs #bintree 

Given the `root` of a binary tree, return _the inorder traversal of its nodes' values_.


> [!faq] Follow up
> Recursive solution is trivial, could you do it iteratively?

## Recursive

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
private:
    vector<int> ans;
    void dfs(TreeNode* root) {
        if (!root) return;
        dfs(root->left);
        ans.push_back(root->val);
        dfs(root->right);
    }
public:
    vector<int> inorderTraversal(TreeNode* root) {
        dfs(root);
        return ans;
    }
};
```

## Iterative

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> ans;
        stack<TreeNode*> s;
        while (root || s.size()) {
            while (root) {
                s.push(root);
                root = root->left;
            }
            root = s.top();
            s.pop();
            ans.push_back(root->val);
            root = root->right;
        }
        return ans;
    }
};
```
---

## PostOrder
- 145
- 590

# [Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/)
#### Difficulty : `Easy`
#### Tags : #stack #tree #dfs #bintree 

Given the `root` of a binary tree, return _the postorder traversal of its nodes' values_.


> [!faq] Follow up
> Recursive solution is trivial, could you do it iteratively?

## Recursive

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
private:
    vector<int> ans;
    void dfs(TreeNode* root) {
        if (!root) return;
        dfs(root->left);
        dfs(root->right);
        ans.push_back(root->val);
    }
public:
    vector<int> postorderTraversal(TreeNode* root) {
        dfs(root);
        return ans;
    }
};
```

## Iterative

```cpp
// Time: O(N)
// Space: O(H)
class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> ans;
        stack<TreeNode*> s;
        TreeNode *prev = nullptr;
        while (root || s.size()) {
            while (root) {
                s.push(root);
                root = root->left;
            }
            root = s.top();

// if root->right is nonexistent or visited, visit root
            if (!root->right || root->right == prev) { 
                ans.push_back(root->val);
                s.pop();
                prev = root;
                root = nullptr;

// otherwise, visit right subtree
            } else root = root->right; 
        }
        return ans;
    }
};
```

---
# [N-ary Tree Postorder Traversal](https://leetcode.com/problems/n-ary-tree-postorder-traversal)
#### Difficulty : `Easy`
#### Tags : #stack #tree #dfs

Given the `root` of an n-ary tree, return _the postorder traversal of its nodes' values_.

Nary-Tree input serialization is represented in their level order traversal. Each group of children is separated by the null value (See examples)


> [!faq] Follow up
> Recursive solution is trivial, could you do it iteratively?

## Recursive

```cpp
// Time: O(N)
// Space: O(logN)
class Solution {
public:
    vector<int> postorder(Node* root) {
        vector<int> ans;
        function<void(Node*)> dfs = [&](Node *root) {
            if (!root) return;
            for (auto n : root->children) dfs(n);
            ans.push_back(root->val);
        };
        dfs(root);
        return ans;
    }
};
```

## Iterative

Preorder traverse the mirrored tree and reverse the result!

```cpp
// Time: O(N)
// Space: O(logN)
class Solution {
public:
    vector<int> postorder(Node* root) {
        if (!root) return {};
        vector<int> ans;
        stack<Node*> s{{root}};
        while (s.size()) {
            root = s.top();
            s.pop();
            ans.push_back(root->val);
            for (auto n : root->children) s.push(n);
        }
        reverse(begin(ans), end(ans));
        return ans;
    }
};
```

## Iterative (Better)

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<int> postorder(Node* root) {
        if (!root) return {};
        vector<int> ans;
        stack<pair<Node*, int>> s{{{root, 0}}};
        while (s.size()) {
            auto [n, i] = s.top();
            s.pop();
            if (i == n->children.size()) ans.push_back(n->val);
            else {
                s.emplace(n, i + 1);
                s.emplace(n->children[i], 0);
            }
        }
        return ans;
    }
};
```

---

## Level Order 

- 102
- 103
- 107
- 2541

# [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)

#### Difficulty : `Medium`
#### Tags : #tree #bfs #bintree 

Given the `root` of a binary tree, return _the level order traversal of its nodes' values_. (i.e., from left to right, level by level).

## Solution

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<vector<int>> levelOrder(TreeNode* root) {
        if (!root) return {};
        vector<vector<int>> ans;
        queue<TreeNode*> q{{root}};
        while (q.size()) {
            ans.emplace_back();
            for (int cnt = q.size(); cnt--; ) {
                auto n = q.front();
                q.pop();
                ans.back().push_back(n->val);
                if (n->left) q.push(n->left);
                if (n->right) q.push(n->right);
            }
        }
        return ans;
    }
};
```

---

# [Binary Tree Zigzag Level Order Traversal](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/)

#### Difficulty : `Medium`
#### Tags : #stack #tree #bfs 

Given a binary tree, return the _zigzag level order_ traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

## Solution 1

```cpp
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
        if (!root) return {};
        queue<TreeNode*> q;
        q.push(root);
        bool l2r = true;
        vector<vector<int>> ans;
        while (q.size()) {
            int cnt = q.size();
            vector<int> lv;
            while (cnt--) {
                root = q.front();
                q.pop();
                lv.push_back(root->val);
                if (root->left) q.push(root->left);
                if (root->right) q.push(root->right);
            }
            if (!l2r) reverse(begin(lv), end(lv));
            ans.push_back(lv);
            l2r = !l2r;
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
    vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
        if (!root) return {};
        vector<vector<int>> ans;
        deque<TreeNode*> q;
        q.push_front(root);
        bool l2r = true;
        while (q.size()) {
            int cnt = q.size();
            ans.emplace_back();
            while (cnt--) {
                if (l2r) {
                    root = q.front();
                    q.pop_front();
                } else {
                    root = q.back();
                    q.pop_back();
                }
                ans.back().push_back(root->val);
                if (l2r) {
                    if (root->left) q.push_back(root->left);
                    if (root->right) q.push_back(root->right);
                } else {
                    if (root->right) q.push_front(root->right);
                    if (root->left) q.push_front(root->left);
                }
            }
            l2r = !l2r;
        }
        return ans;
    }
};
```
---

# [Binary Tree Level Order Traversal II](https://leetcode.com/problems/binary-tree-level-order-traversal-ii/)

Given the `root` of a binary tree, return _the bottom-up level order traversal of its nodes' values_. (i.e., from left to right, level by level from leaf to root).

**Example 1:**

[![](https://camo.githubusercontent.com/ee4f0927a2f4ebd224c97f332710a1d1e4f26184a6cc71ceca0320051e22c6b2/68747470733a2f2f6173736574732e6c656574636f64652e636f6d2f75706c6f6164732f323032312f30322f31392f74726565312e6a7067)](https://camo.githubusercontent.com/ee4f0927a2f4ebd224c97f332710a1d1e4f26184a6cc71ceca0320051e22c6b2/68747470733a2f2f6173736574732e6c656574636f64652e636f6d2f75706c6f6164732f323032312f30322f31392f74726565312e6a7067)

**Input:** root = [3,9,20,null,null,15,7]
**Output:** [[15,7],[9,20],[3]]

**Example 2:**

**Input:** root = [1]
**Output:** [[1]]

**Example 3:**

**Input:** root = []
**Output:** []

**Constraints:**

- The number of nodes in the tree is in the range `[0, 2000]`.
- `-1000 <= Node.val <= 1000`

**Companies**:  
[Amazon](https://leetcode.com/company/amazon), [Apple](https://leetcode.com/company/apple)

**Related Topics**:  
[Tree](https://leetcode.com/tag/tree/), [Breadth-First Search](https://leetcode.com/tag/breadth-first-search/), [Binary Tree](https://leetcode.com/tag/binary-tree/)

**Similar Questions**:

- [Binary Tree Level Order Traversal (Medium)](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Average of Levels in Binary Tree (Easy)](https://leetcode.com/problems/average-of-levels-in-binary-tree/)

## [](https://github.com/lzl124631x/LeetCode/tree/master/leetcode/107.%20Binary%20Tree%20Level%20Order%20Traversal%20II#solution-1-bfs)Solution 1. BFS

```c
// OJ: https://leetcode.com/problems/binary-tree-level-order-traversal-ii/
// Author: github.com/lzl124631x
// Time: O(N)
// Space: O(N)
class Solution {
public:
    vector<vector<int>> levelOrderBottom(TreeNode* root) {
        if (!root) return {};
        vector<vector<int>> ans;
        queue<TreeNode*> q;
        q.push(root);
        while (q.size()) {
            int cnt = q.size();
            ans.emplace_back();
            while (cnt--) {
                root = q.front();
                q.pop();
                ans.back().push_back(root->val);
                if (root->left) q.push(root->left);
                if (root->right) q.push(root->right);
            }
        }
        reverse(begin(ans), end(ans));
        return ans;
    }
};
```

## [](https://github.com/lzl124631x/LeetCode/tree/master/leetcode/107.%20Binary%20Tree%20Level%20Order%20Traversal%20II#solution-2-dfs)Solution 2. DFS

```c
// OJ: https://leetcode.com/problems/binary-tree-level-order-traversal-ii/
// Author: github.com/lzl124631x
// Time: O(N)
// Space: O(H)
class Solution {
    vector<vector<int>> ans;
    void dfs(TreeNode *root, int lv) {
        if (!root) return;
        if (lv >= ans.size()) ans.emplace_back();
        ans[lv].push_back(root->val);
        dfs(root->left, lv + 1);
        dfs(root->right, lv + 1);
    }
public:
    vector<vector<int>> levelOrderBottom(TreeNode* root) {
        dfs(root, 0);
        reverse(begin(ans), end(ans));
        return ans;
    }
};
```