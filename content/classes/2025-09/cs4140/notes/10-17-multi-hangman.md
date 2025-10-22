---
title: "cs4140 Notes: 10-17 Multi Hangman"
date: "2025-10-15"
---


## First, Manual Testing and New Assignment

- Any more progress?

## Hangman, pt3

Last time we started moving our Hangman game to have server-side logic.

We:

- Added a channel.
- Added a game module with a %Game{} struct.
- Had the channel instantiate the game on connect.

More work to do:

- Finish hooking up the React and Elixir logic.
- Add a landing screen where we can punch in a game name.
  - Discuss using a form vs. just React here.
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
