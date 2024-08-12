# ReduxLike

**TODO: Add description**
https://medium.com/flatiron-labs/something-useless-redux-implemented-in-elixir-208ddb47f5db

## commands history

iex -S mix

{:ok, store} = Store.start_link(CountReducer)

ref = Store.subscribe(store, fn (state) -> IO.puts "I got called #{state}" end)

Store.dispatch(store,%{type: "INCREMENT"})

Store.remove_subscriber(store, ref)

Store.dispatch(store,%{type: "INCREMENT"})

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `redux_like` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:redux_like, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/redux_like>.
