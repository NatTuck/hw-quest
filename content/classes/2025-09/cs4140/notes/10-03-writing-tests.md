---
title: "cs4140 Notes: 10-03 Tests, Style"
date: "2025-10-01"
---

### Cranking Up Code Coverage

```bash
$ mix test --cover
```

Several different kinds of tests:

- Logic unit tests, mostly for pure code.
- Context unit tests, for simple DB actions and verifying 
  schema/changeset logic.
- Controller tests / LiveView tests, to that some specific request/
  response action by the user works as expected.
- Integration tests test sequences of actions, possibly entire
  standard workflows.

That's before we even get to:

- Testing JS code.
- Popping up a full browser to test everything "for real".

Let's pick out a couple modules and manually write some tests,
optimally of different kinds.

And then, AI tools are pretty good at writing tests, so let's use Aider here. I
think I've got my laptop set to use Cerebras for Quen3-Coder, so it should be
able to generate code fast.

If we can, let's get coverage up to 25% and then crank up the threshold
in mix.exs


### Credo - Static Analysis / Style Rules

Start at: https://github.com/rrrene/credo

- Add to mix.exs
- `mix deps.get`
- `mix credo gen.config`
- `mix credo`

Those checks are great, but the check I want is for maximum file length:

- `mix credo.gen.check lib/shard/credo/max_file_length.ex`


```elixir
# .credo.exs
          {Shard.Credo.MaxFileLength, max_lines: 400},
```

And the module:

```elixir
defmodule Shard.Credo.MaxFileLength do
  @moduledoc """
    Count lines, complain if it exceeds a value.
  """

  # you can configure the basics of your check via the `use Credo.Check` call
  use Credo.Check, base_priority: :high, category: :custom, exit_status: 0

  @default_params max_lines: 400

  @doc false
  @impl true
  def run(%SourceFile{} = source_file, params) do
    max_lines = params |> Params.get(:max_lines, __MODULE__)

    lines = SourceFile.lines(source_file)
    count = length(lines)

    if count > max_lines do
      issue =
        format_issue(
          IssueMeta.for(source_file, params),
          message: "File is too long: #{count} > max of #{max_lines}",
          trigger: source_file.filename
        )

      [issue]
    else
      []
    end
  end
end
```


### Let's get everything run in CI

```yaml
      - name: Install dependencies
        run: mix deps.get
      - name: Verify that this builds
        run: mix compile --warnings-as-errors
      - name: Check formatting
        run: mix format --check-formatted
      - name: Run tests
        run: mix test
      - name: Check coverage
        run: mix test --cover
      - name: Static Analysis
        run: mix credo
```
