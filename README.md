# ExMon

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_mon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mon, "~> 0.1.0"}
  ]
end
```

## Gaming
```
player = ExMon.create_player "Roberto", :soco, :chute, :cura
ExMon.start_game player
ExMon.make_move :soco
ExMon.Game.info
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_mon](https://hexdocs.pm/ex_mon).
