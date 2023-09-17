---
title: "cs4140 Notes: 09 Automated Testing"
date: "2023-09-17"
---

## What are tests?

Tests are extra code that doesn't run when our app executes normally, but can
be run to verify that parts of our app work as expected.

Why?

 - Test can work as specifications for small parts of our code. This
   is especially useful to check edge cases that don't come up
   frequently in normal use.
 - Tests help us avoid regressions. Once we get something working we
   don't want future changes to break it. This is especially useful
   with multiple developers on a project.
 - Tests can make up for some of the fragility of working with dynamic
   typing.
 - Tests allow for continuous deployment. We couldn't say we're always
   deploying a working app if there's no definiton of "working".

Kinds of tests:

 - Unit tests test a single piece of code: function, method, component, etc.
   - Tests of units that call other units might test bigger chunks.
 - Integration tests test the whole app through specific user-visible
   operations.
   - An integration test might test an appropriately written user story that
     describes a workflow action or action sequence.


## Unit Testing for Rails

Rails code generators can generate an initial test suite.

Let's look at what we got for the Jokes resource.

**test/models/joke_test.rb**

This is where tests go for our model objects, which wrap the jokes db
table. 

Let's add something to test.

```ruby
class Joke ...
  validates :content, length: { minimum: 5 }
```

Now let's try that:

```bash
$ rails c
irb> jj = Joke.new(content: "hi")
irb> jj.validate
irb> jj.valid?
irb> jj.errors
irb> kk = Joke.new(content: "hello")
irb> jj.validate
irb> jj.valid?
irb> jj.errors
```

Now let's make it a test:

```ruby
# joke_test.rb

  test "content length" do
    aa = Joke.new(content: "hi")
    assert !aa.valid?
    bb = Joke.new(content: "hello")
    assert bb.valid
  end
```

And run just that one test:

```bash
rails test test/models/joke_test.rb
```

Now let's run all the tests and see if we broke anything.


**test/controllers/jokes_controller_test.rb**

These are unit tests for the controller methods.

Database is seeded from seeds/jokes.yml, then an HTTP request is
simulated. There's no actual web server involved, but the model
gets called and response content get produced from the templates.


## Unit Testing for Next

Like with db access, Next doesn't give us testing by default so we
need to add it.

Unlike with DB access, the Rails team will need this or something
similar. JS code needs testing too.

ref: [Next Docs](
https://nextjs.org/docs/pages/building-your-application/optimizing/testing#setting-up-jest-with-the-rust-compiler)

Install some deps:

```bash
npm install --save-dev jest jest-environment-jsdom @testing-library/react \
    @testing-library/jest-dom
```

Add a jest.config.mjs with stock content:

```js
import nextJest from 'next/jest.js'
 
const createJestConfig = nextJest({
  // Provide the path to your Next.js app to load next.config.js and .env files in your test environment
  dir: './',
})
 
// Add any custom config to be passed to Jest
/** @type {import('jest').Config} */
const config = {
  // Add more setup options before each test is run
  // setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
 
  testEnvironment: 'jest-environment-jsdom',
}
 
// createJestConfig is exported this way to ensure that next/jest can load the Next.js config which is async
export default createJestConfig(config)
```

Add a test action for npm, in package.json:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test": "jest --watch"
  }
}
```

And add our first test. In ```__tests__/index.test.js```:

```js
import { render, screen } from '@testing-library/react';
import Home from '../app/page';
import '@testing-library/jest-dom';
 
describe('Home', () => {
  it('renders a heading', () => {
    render(<Home />)
 
    const heading = screen.getByRole('heading', {
      name: /welcome to next\.js!/i,
    })
 
    expect(heading).toBeInTheDocument()
  });
});
```

Run the tests:

```bash
npm run test
```

It fails, update the code to

```
      name: /today's joke/i,
```

That should pass on save.

So that lets us test a page - kind of like controller tests in rails.

**Next: Testing Our Model**

ref: [Unit Testing with Prisma](
https://www.prisma.io/docs/guides/testing/unit-testing)

Rails gives us model tests, fixtures, and sets us up with a test DB.

We've got some choices for testing our DB interface with Prisma.

The prisma docs recommend using a mock object for the Prisma client.
This will allow us to mostly test our code, but has the disadvantage of
not hitting a real DB. 

ref: https://github.com/prisma/prisma/discussions/2792

May be able to get tests to use a different DB.

```js
const prisma = new PrismaClient({
    datasources: {
        db: { url: process.env.NODE_ENV === 'test' ? DB_URL_TEST : DB_URL },
    },
})
```
