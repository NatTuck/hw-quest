---
title: "cs2381 Notes: 17 Chess Bits"
date: "2023-10-04"
---

**ArrayList invalid slots**

Show example in scratch repo.

**Bit Packing: Chess**

ref: https://www.lennyfacecopypaste.com/text-symbols/chess.html

We want to represent a chess board in as few bytes as possible.

 - There are 64 squares on a chess board.
 - Each square can be one of:
   - Blank
   - A piece, one of: ♔ ♕ ♚ ♛ ♘ ♗ ♙ ♖ ♞ ♝ ♟ ♜
 - So that's 1 + 2*6 = 13 possible states.
 - We can represent those states using 4 bits.
 - There are 8 rows of 8 squares. Each row takes 8 * 4 = 32 bits, or 1 int.
 - So we can represent a chess board using an array of 8 ints, one for each row.

Let's write methods to encode and decode chess boards.

```java
package demo;

public class App {
    public static void main(String[] args) {
        String[] cells = {"♜♞♝♛♚♝♞♜",
                          "♟♟♟♟♟♟♟♟",
                          "        ",
                          "        ",
                          "        ",
                          "        ",
                          "♙♙♙♙♙♙♙♙",
                          "♖♘♗♕♔♗♘♖"};
        var board = new Board(cells);
        board.put(3, 3, '♞');
        System.out.println(board.toString());
    }
}

class Board {
    // White pieces at lower indexes, which is confusing on a black background.
    static final String PTAB = " ♙♖♘♗♕♔♟♜♞♝♛♚";

    int[] data;

    Board() {
        data = new int[8];
    }

    Board(String[] rows) {
        data = new int[8];
        for (int ii = 0; ii < 8; ++ii) {
            char[] cols = rows[ii].toCharArray();
            for (int jj = 0; jj < 8; ++jj) {
                put(ii, jj, cols[jj]);
            }
        }
    }

    void put(int row, int col, char piece) {
        int mask = 15; // binary 1111
        int pval = p2i(piece);
        int boff = 4 * col;
        data[row] = data[row] & ~(mask << boff);
        data[row] = data[row] | (pval << boff);
    }

    char get(int row, int col) {
        int mask = 15; // binary 1111
        int boff = 4 * col;
        int pval = mask & (data[row] >> boff);
        return i2p(pval);
    }

    @Override
    public String toString() {
        var sb = new StringBuilder();
        for (int ii = 0; ii < 8; ++ii) {
            for (int jj = 0; jj < 8; ++jj) {
                sb.append(get(ii, jj));
                sb.append(" ");
            }
            sb.append("\n");
        }
        return sb.toString();
    }

    static int p2i(char piece) {
        char[] xs = PTAB.toCharArray();
        for (int ii = 0; ii < xs.length; ++ii) {
            if (piece == xs[ii]) {
                return ii;
            }
        }
        throw new Error("No such piece '" + piece + "'");
    }

    static char i2p(int pval) {
        char[] xs = PTAB.toCharArray();
        return xs[pval];
    }
}
```

