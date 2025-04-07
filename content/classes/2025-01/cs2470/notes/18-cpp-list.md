---
title: "Lecture Notes: 18 A ConsList in C++"
date: "2025-04-06"
---

## A List in C++

### list.hh

```C++
#ifndef LIST_HH
#define LIST_HH

#include <memory>
#include <string>

// not great practice, but easy for examples
using namespace std;

template <typename T>
class ListBase {
public:
    // a pure virtual function will never be called
    // and will always be dynamically dispatched
    virtual bool is_empty() = 0;
    virtual int length() = 0;
};

template <typename T>
using List = unique_ptr<ListBase<T>>;

template <typename T>
class ListEmpty : public ListBase<T> {
public:
    bool is_empty() { return false; }
    int length() { return 0; }
};

template <typename T>
class ListCell : public ListBase<T> {
public:
    const T head;
    const List<T> tail;

    ListCell(T hd, List<T> tl)
        : head(hd)
        , tail(std::move(tl))
    {
    }

    bool is_empty() { return true; }
    int length() { return 1 + tail->length(); }
};

template <typename T>
List<T>
cons(T hd, List<T> tl)
{
    return make_unique<ListCell<T>>(hd, tl);
}

List<string> cons(const char* hd, List<string> tl);

template <typename T>
List<T>
empty()
{
    return make_unique<ListEmpty<T>>();
}

#endif
```

### list.cc

```C++
#include "list.hh"

// This needs to be in the .cc file, so it doesn't
// get included twice because it's not a template.
List<string>
cons(const char* hd, List<string> tl)
{
    return make_unique<ListCell<string>>(string(hd), std::move(tl));
}
```

### main.cc

```C++
#include "list.hh"

// Good practice to include system headers last, so
// project headers can't depend on them unexpectedly.
#include <iostream>
#include <string>

int main(int argc, char* argv[])
{
    List<string> xs = cons("foo", cons("bar", cons("baz", empty<string>())));
    cout << xs->length() << endl;

    // part 2
    // List<string> ys = cons("aa", cons("bb", xs->tail));
    // cout << ys->length() << endl;
    return 0;
}
```

