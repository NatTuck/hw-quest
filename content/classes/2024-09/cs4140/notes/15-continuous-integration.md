---
title: "cs4140 Notes: 15 Continous Integration"
date: "2024-09-24"
---

Wrap up from last time:

 - Finished tests
 - Used ```register_and_log_in_user``` from ConnCase
 - Let's do the acceptance testing step and see if we're done.

## Continuous Integration

We want to automatically run our tests whenever we commit.

Let's try to figure this out:

 - Actions tab
 - Add the Elixir workflow
 - Check elixir version with ```elixir --version``` and make runner match.
 - Mention the choice of ubuntu-latest vs ubuntu-24.04
 - Save
 - Run should start pretty quick.
   - Not running in like 10 minutes is probably a bug; e.g. I got wrong runner OS version.
 - Fix any bugs

This week: Get continous integration set up for your primary app repo.



