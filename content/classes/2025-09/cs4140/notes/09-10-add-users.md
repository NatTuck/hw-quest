---
title: "cs4140 Notes: 09-10 Add Users, Design "
date: "2025-09-06"
---

## Add Users

Our game probably wants users - there's a "Log in as character" option, but that
looks similar - and Phoenix provides a quick way to do that. So let me go
through the whole sequence to set that up.


(story)

```
As a user
I want to be able register and log in
So I can do stuff specific to my user account

Acceptance: Users can register and log in.
```


(shard - add-users branch)

Run ```mix phx.gen.auth``` to show help.

Build users. 

 - Check migration; add is_admin field.
 - Add feature to set first user to admin.

## Testing

Let's look at the tests:

- For page_controller.
  - Change the text of the start page.
  - Fix test.
- Walk through the registration tests for users.
  - Add tests to confirm that first user becomes an admin.
- Show Layouts.app function, remove phoenix icon.


## Continuous Integration

- Click Actions on Github
- Hit the Elxir tests button.
- This will break enough to finish the lecture period.





