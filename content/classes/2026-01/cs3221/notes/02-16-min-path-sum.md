---
title: "Notes: 02-16 Min Path Sum"
date: "2026-02-14"
---

### The Problem: Minimum Path Sum

**Problem Statement:** Given an `m x n` grid filled with non-negative numbers,
find a path from the top-left to the bottom-right that minimizes the sum of all
numbers along its path. You can only move either **down** or **right** at any
point in time.

---

#### 1. The Hook & The "Greedy" Trap (5 Minutes)

* **Draw a small 3x3 grid** on the board with specific numbers.
* **Ask the class:** "What is the cheapest path from start to finish?"
* **Demonstrate a greedy failure:** Show that if you always choose the smaller immediate neighbor (e.g., moving right to a `1` instead of down to a `5`), you might get trapped forcing a move into a `100` later.
* **Key Insight:** "We can't just look one step ahead. A locally optimal choice doesn't guarantee a globally optimal solution."

#### 2. Defining the Recurrence (10 Minutes)

* **Ask:** "If I am standing at cell `(i, j)`, where must I have come from?"
  * *Answer:* "I could only have arrived from the cell above `(i-1, j)` or the cell to the left `(i, j-1)`."
* **Derive the Formula:** To minimize the cost to reach `(i, j)`, I should take the current cell's cost and add it to the *minimum* of the two possible previous totals.
    $$dp[i][j] = grid[i][j] + \min(dp[i-1][j], dp[i][j-1])$$
* **Connect to previous lectures:** Remind them this is just like the Robber problem—making a decision based on the best previous sub-problems—but now we look up and left instead of just back.

#### 3. Visualizing the 2D Array (15 Minutes)

* Draw an empty 2D array (the DP table) next to the input grid.
* **Base Case:** Fill in `dp[0][0]` (it's just the start value).
* **The Edges:** Fill the first row and first column. Ask the class why these are special.
  * *Explanation:* "In the first row, you can *only* come from the left. In the first column, you can *only* come from above." (Cumulative sum).
* **The General Case:** Pick a cell in the middle (e.g., `dp[1][1]`).
  * Point to the value "Above" in the DP table.
  * Point to the value "Left" in the DP table.
  * Ask the class which one to pick (the smaller one), add the grid cost, and fill the cell.
* Repeat this for 2-3 cells until the pattern is obvious.

#### 4. Code Walkthrough (15 Minutes)

* Write the solution. Since the logic is simple, you can focus on the nested loop structure.

```python
def minPathSum(grid):
    rows, cols = len(grid), len(grid[0])
    
    # Create a 2D DP table with same dimensions
    dp = [[0] * cols for _ in range(rows)]
    
    dp[0][0] = grid[0][0]
    
    # Fill first column (can only come from above)
    for i in range(1, rows):
        dp[i][0] = dp[i-1][0] + grid[i][0]
        
    # Fill first row (can only come from left)
    for j in range(1, cols):
        dp[0][j] = dp[0][j-1] + grid[0][j]
        
    # Fill the rest of the grid
    for i in range(1, rows):
        for j in range(1, cols):
            # The core transition equation
            dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])
            
    return dp[rows-1][cols-1]
```

* **Complexity Analysis:**
  * Time: $O(M \times N)$ (We visit every cell once).
  * Space: $O(M \times N)$ (The 2D array).

#### 5. Wrap-Up & Optimization Teaser (5 Minutes)

* **Recap:** We turned a pathfinding problem into a table-filling problem.
* **Teaser for next time (or homework):** "Look at our code. To calculate row `i`, we only ever looked at row `i` (current) and row `i-1` (previous). Do we really need to keep the rows from `i-2`, `i-3`, etc., in memory?" (leads to $O(N)$ space optimization).
