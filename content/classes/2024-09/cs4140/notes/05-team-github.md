---
title: "cs4140 Notes: 04 Github and Taiga.io"
date: "2024-09-05"
---

## Github Workflow

Github intro:

 - Create a user account for github.com
 - Github stores git repositories at github.com/{user}/{repo}

Github workflow, (to make a change in someone else's repo):

(demo with https://github.com/fogcloud/workflow-demo )

 - Personal fork to your github account
 - Clone to local workstation
 - Feature branch
 - Make the change
 - (run any tests locally)
 - Commit, push to your fork on Github
 - Use github UI to make pull request to the main repo.
 - A team member other than the one who created the pull
   request should review and merge it.


# Attendance

## Today's Meeting has an in-class exercise

 - Everyone should create a github account
 - One team member should create a new repository on their Github account.
 - That member should add the other members as contributors.
 - That member should commit the follwing file as www/index.html:
   
```
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Team Page: [Team Name]</title>
    </head>
    <body>
        <h1>Team Page: [Team Name]</h1>
        <p><strong>Members:</strong></p>
        <ul>
            <li>Member 1</li>
            <li>Member 2</li>
            <li>Member 3</li>
            <li>Member 4</li>
        </ul>
    </body>
</html>
```

Once that is committed, each team member should:

 - Create a personal fork (unless they own the repo).
 - Clone the repository locally.
 - Create a feature branch ({name}-add-name).
 - Edit the HTML file to add their name to the member list, removing
   one of the fake items from the list.
 - Commit their change to their local repository.
 - Push the change to their fork on Github.
 - Make a pull request.

Then each team member should review and merge someone else's pull
request.
        
