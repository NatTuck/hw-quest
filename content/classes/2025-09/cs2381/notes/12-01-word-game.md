---
title: "Notes: 12-01 Word Game"
date: "2025-11-29"
---

**Overhead**

- Last week of classes
- Final Exam: Monday, December 8 @ 11am-1:30pm
- The practice final from last semester is up on last semester's site.
- Our practice final should be up soon.

**Topic: Networking & Internet**

- Every computer on the internet has an IP address
- The Internet Protocol delivers packets to IP addresses
- IPv4 packets are limited to 64kB
- In practice, they are frequently limited to ~1.2kB because that's
   the limit on Ethernet
- IP packets are unreliable - they may or may not actually get to
   their destitionation
- Transmission Control Protocol builds reliable streams on top of IP packets
  - You open a connection
  - Either side can send and recieve arbitrary sized chunks of data
  - Data is delivered reliably and in order.
- How?
  - Send a packet, reply with a confirmation, resend or send the next packet
  - That's too slow
  - Window:
    - Send the next 10 packets
    - Send an array of 10 confirmations
    - Resend any missed packets, send any new packets in the shifted 10 packet window
- HTTP builds sending "files" on top of TCP
  - GET /index.html HTTP/1.0
  - 200 OK/n/n<html ...
  - GET /logo.png HTTP/1.0
  - 200 OK/n/nPNG bytes...
- Websockets tunnels streams "on top" of HTTP...

**Word Game**

<https://words.homework.quest/>

Game model.

**Sample Code**

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
            if (!isVowel(cc)) {
                points += count;
            }

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
```

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
