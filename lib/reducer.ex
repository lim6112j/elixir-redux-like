defmodule Reducer do
	@callback reduce(any,%{type: any}) :: any
end
defmodule CountReducer do
	@behaviour Reducer
	def reduce(nil, action), do: reduce(0, action)
	def reduce(state, action), do: do_reduce(state, action)
	defp do_reduce(state, %{type: "INCREMENT"}), do: state + 1
	defp do_reduce(state, _), do: state
end
defmodule SquareReducer do
	@behaviour Reducer
	def reduce(nil, action), do: reduce(2, action)
	def reduce(state, action), do: do_reduce(state, action)
	defp do_reduce(state, action) do
		case action do
			%{type: "INCREMENT"} ->
				state * 1
			%{type: "DECREMENT"} ->
				state - 1
			_ -> state
		end
	end
end
