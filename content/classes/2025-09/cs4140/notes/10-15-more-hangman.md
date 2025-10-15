---
title: "cs4140 Notes: 10-13 Hangman"
date: "2025-10-13"
---


## First, Manual Testing and New Assignment

- What do we have working?
- What do we need next?

## Hangman, pt2

Last time we built a basic Hangman game:

- React component.
- useState with two fields.
- We can render from those two fields by first calculating derived
  values and then outputting a DOM tree.
- Events modify the two fields and trigger a re-render.

Problems:

- Only one game at a time.
- Player can cheat.
- Game is single player.
- Only one game at a time.
- No high scores.

Solutions:

- Add a landing screen where we can punch in a game name.
  - Discuss using a form vs. just React here.
- Add a channel.
- Add a GenServer for multiplayer.
  - Talk about Agent vs. GenServer vs. DB
- Add a Supervisor
- Add a DB for high scores.

Supervisor example:

```elixir
defmodule Inkfish.Itty.Sup do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Inkfish.Itty.DynSup},
      {Registry, keys: :unique, name: Inkfish.Itty.Reg}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

```

Launching under DynamicSupervisor and calling via registry:

```elixir
  ...
  use GenServer
  ...
  def start_link(state0) do
    IO.puts(" =[Itty]= Start server with UUID #{state0.uuid}")
    GenServer.start_link(__MODULE__, state0, name: reg(state0.uuid))
  end

  def reg(uuid) do
    {:via, Registry, {Inkfish.Itty.Reg, uuid}}
  end

  def start(%Task{} = task) do
    state0 = Map.delete(task, :__struct__)

    spec = %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [state0]},
      restart: :temporary
    }

    DynamicSupervisor.start_child(Inkfish.Itty.DynSup, spec)
  end

  def peek(uuid) do
    if !Enum.empty?(Registry.lookup(Inkfish.Itty.Reg, uuid)) do
      GenServer.call(reg(uuid), :peek)
    else
      {:error, :itty_not_found}
    end
  end
```

Now we can hit the DB for high scores if we still have time.
