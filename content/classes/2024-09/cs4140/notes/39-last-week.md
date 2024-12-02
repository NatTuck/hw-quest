---
title: "Notes: 39 Last Week"
date: "2024-12-01"
---

## Where are we?

 - Last week of classes
 - Final presentations next week
 - Block is Friday, Dec 13 8:00 - 10:30 AM, this room.
 - We don't need 2.5 hours, so we'll use 9:00 - 10:30 am; be on time at 9.
 
Presentation requirements:

 - Team presenations
   - Should answer some provided questions for the whole team.
 - Each member will present ansers to a couple of individual questions
   as part of the presentation.
 - Two separate grades: Team and personal, each covers both the presentation
   itself and an evaluation of the project being presented.

Next lecture:

 - Semester review.


## Project statuses?

 - What's still missing?
 - Can you get it done for Friday to leave time to debug, polish, and
   work on the presentation?
 - Is the team stuck on any technical issue? Is there something I can try
   to help with.


## Today: Distributed Elixir

```
# server.ex
defmodule Server do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: :server)
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call(:hi, from, state) do
    IO.inspect({:hi, from})
    {:reply, :ok, state}
  end
end

```


Two separate terminal windows:

 - ```iex --sname node1```
 - ```iex --sname node2```

On node1

 - Node.connect(:"node2@icewing")

On node2

 - c("./server.ex")
 - Server.start_link()
 - GenServer.call(:server, :hi)
 - Node.self()
 
On node1
 
 - GenServer.call({:server, :"node2@host", :hi)


