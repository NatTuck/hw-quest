---
title: "cs2381 Notes: 11-24 Text Editor"
date: "2025-11-24"
---

Let's try to design a data structure for a text editor.

Seems easy. A text file is just a String.

But...

- Text files can get big.
- Pretty much all common operations will end up being O(n).
- And we'd like undo / redo without storing a copy of the whole
  file for each change.

What do we do?

Common operations:

- Insert some text.
- Delete some text.
- Replace text (delete + insert?)
- Cut / paste some text.
- Copy / paste some text.
- Line operations (insert, delete, replace, move lines)

How do we do this?

- For extra fun, characters aren't fixed width.
