---
title: "cs2010 Notes: 10-28 More Programing"
date: "2026-10-28"
---

We're going to build a spellcheck program.

We're going to do it in Perl.

```perl
#!/usr/bin/perl
use 5.30.0;

open my $wf, "<", "/usr/share/dict/words";
my %words = ();
while (<$wf>) {
  chomp;
  $words{$_} = 1;
}
close $wf;

while (<>) {
  chomp;
  s/[^\w\s]//g;
  y/[A-Z]/[a-z]/;
  my @words = split /\s+/;
  for my $word (@words) {
    say $word unless $words{$word};
  }
}
```

We're going to walk through that step by step.

If we have time, we'll rewrite it in C.
