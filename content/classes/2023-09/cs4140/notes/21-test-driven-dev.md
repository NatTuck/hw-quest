---
title: "cs4140 Notes: 21 Test Driven Development"
date: "2023-10-12"
---

**Test-Driven Development**

Workflow for adding code:

 - We have a story on our Kanban board, marked "in progress".
   - What needs to be done is clearly defined.
   - Acceptance criteria for manual testing is defined.
 - Create feature branch.
 - Write code and tests.
 - Make pull request.
 - Code review.
 - Deployed automatically.

Focusing in on the code writing step, we've got a process question:
Should the functional code get written first, or the tests?

The Test Driven Development philosophy says write a test first. Why?

 - The feature needs to be very clearly defined.
 - You can't add features without first figuring out how to test them.
 - This sequence incentivizes writing the simplest code that will pass
   the test.

More specifically, the sequence goes like this:

 - Write one new test.
 - Run the test suite and confirm that the new test fails.
 - Make the minimum change nessisary to pass the test.
 - Run the test suite and confirm that the new test passes and no
   other tests break.
 - Do any refactoring needed to clean up this specific functionality,
   making sure that all tests stay passing.
 
Let's see this in action:

 - Add a feature to Next app. (```npx run jest```)
 - Add a feature to Rails app. (```rake test```)

Test coverage

**Test Coverage for Rails**
 
 - https://github.com/simplecov-ruby/simplecov
 - Follow the 'getting started' instructions.
 - ```rake test```
 - ```xdg-open coverage/index.html```
 - Find code that isn't covered, write test.


**Test Coverage for Next**

 - https://istanbul.js.org/
 - in package.json: ```"cov": "jest --coverage"```
 - ```npm run cov```
 
Now let's extend coverage to everything in app.

In jest.config.mjs:

```js
const config = {
  ...
  collectCoverageFrom: [
    'app/**/*.{js,jsx}'
  ]
```

Now let's check the report:

```bash
xdg-open coverage/lcov-report/index.html
```

 - Find code that isn't covered, write test.


 
Other refs: 
 
 - https://glebbahmutov.com/blog/code-coverage-for-nextjs-app/
