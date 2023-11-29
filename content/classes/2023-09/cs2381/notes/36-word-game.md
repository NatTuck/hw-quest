---
title: "Notes: 36 Word Game"
date: "2023-11-28"
---

First, let's finish up the chinese food thing:

 - Build order summary / recipt.
 - These should be alphabetical, that requires sorting,
   forcing us to O(n log n) (why?)

## Word Game

### Game Rules: Single Player

 - The puzzle consists of a set of random words (typically six words).
 - The Player can see the words, with the letters individually hidden.
 - The player starts with zero points.
 - Each turn, the player guesses a consonant (including "y") that hasn't
   previously been guessed.
 - If that letter occurs in the puzzle:
   - All instances of that letter are revealed.
   - The player gets one point for each occurance revealed.
   - Player can either:
     - Guess the words in the puzzle. If they get it exactly right,
       they win - their score is added to multi-game total.
     - Guess one additional consonant
     - Spend one point to guess a vowel and reveal all occurances
 - If at any point all the letters are revealed, the player loses.

```java

/**
 * Interact with sample word list.
 *
 * @author Nat Tuck
 */
public class Words {
    /**
     * Read sample word list.
     *
     * @return  List of words
     */
    static List<String> readWords() {
        try {
            InputStream raw = App.class
                .getResourceAsStream("/words.txt.gz");
            GZIPInputStream unz = new GZIPInputStream(raw);
            InputStreamReader rdr = new InputStreamReader(unz);
            BufferedReader buf = new BufferedReader(rdr);
            return buf.lines().toList();
        }
        catch (Exception ee) {
            throw new RuntimeException("read failed");
        }
    }

    static List<String> randomWords(int nn) {
        var words = readWords();
        var ys = new ArrayList<String>();

        while (ys.size() < nn) {
            var ww = pickRandom(words);
            if (!ys.contains(ww)) {
                ys.add(ww);
            }
        }

        return ys;
    }

    static <T> T pickRandom(List<T> xs) {
        int ii = (int)(xs.size() * Math.random());
        return xs.get(ii);
    }
}
```

```java
package demo;

import java.io.Console;

public class App {
    static Game game;
    static int turn;
    static int points;
    static Console con;

    public static void main(String[] args) {
        game = new Game();
        turn = 1;
        points = 0;
        con = System.console();

        while (!game.gameOver()) {
            con.printf("\n\n == Turn %d, Points %d ==\n", turn, points);
            con.printf("%s\n\n", game.view());

            con.printf("Guess a non-vowel.\n");
            int cc = readLetter();

            int count = game.addGuess(cc);
            con.printf("found %d letters\n", count);
            points += count;

            turn++;
        }
    }

    public static int readLetter() {
        while (true) {
            var line = con.readLine("letter? ");
            if (line.length() > 0) {
                return line.codePointAt(0);
            }
        }
    }
}


```java
package demo;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class Game {
    final List<String> words;
    Set<Integer> guesses;
    int points;

    Game() {
        words = Words.randomWords(6);
        guesses = new TreeSet<Integer>();
        points = 0;
    }

    String view() {
        var xs = words.stream().map((ww) -> wordView(ww)).toList();
        return String.join(" ", xs);
    }

    String wordView(String word) {
        var yy = new StringBuilder();
        for (var cc : word.codePoints().toArray()) {
            if (guesses.contains(cc)) {
                yy.append(Character.toString(cc));
            }
            else {
                yy.append("-");
            }
        }
        return yy.toString();
    }

    int countLetter(int cc) {
        return (int) String.join(" ", words).codePoints().filter((xx) -> xx == cc).count();
    }

    int addGuess(int cc) {
        int yy = countLetter(cc);
        guesses.add(cc);
        return yy;
    }

    int countUnknown() {
        return (int) view().codePoints().filter((cc) -> cc == '-').count();
    }

    boolean gameOver() {
        return countUnknown() == 0;
    }
}
package demo;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class Game {
    final List<String> words;
    Set<Integer> guesses;
    int points;

    Game() {
        words = Words.randomWords(6);
        guesses = new TreeSet<Integer>();
        points = 0;
    }

    String view() {
        var xs = words.stream().map((ww) -> wordView(ww)).toList();
        return String.join(" ", xs);
    }

    String wordView(String word) {
        var yy = new StringBuilder();
        for (var cc : word.codePoints().toArray()) {
            if (guesses.contains(cc)) {
                yy.append(Character.toString(cc));
            }
            else {
                yy.append("-");
            }
        }
        return yy.toString();
    }

    int countLetter(int cc) {
        return (int) String.join(" ", words).codePoints().filter((xx) -> xx == cc).count();
    }

    int addGuess(int cc) {
        int yy = countLetter(cc);
        guesses.add(cc);
        return yy;
    }

    int countUnknown() {
        return (int) view().codePoints().filter((cc) -> cc == '-').count();
    }

    boolean gameOver() {
        return countUnknown() == 0;
    }
}
```
