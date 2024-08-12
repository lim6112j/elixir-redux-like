defmodule Reducer do
	@callback reduce(any,%{type: any}) :: any
end
defmodule CountReducer do
	@behaviour Reducer
	def reduce(nil, action), do: reduce(0, action)
	def reduce(state, action), do: do_reduce(state, action)
	defp do_reduce(state, action) do
		case action do
			%{type: "@@INIT"} ->
				state = 10
				state
			%{type: "INCREMENT"} ->
				state + 1
			_ -> state
		end

	end


end
defmodule SquareReducer do
	@behaviour Reducer
	def reduce(nil, action), do: reduce(2, action)
	def reduce(state, action), do: do_reduce(state, action)
	defp do_reduce(state, action) do
		case action do
			%{type: "@@INIT"} ->
				state = 100
				state
			%{type: "INCREMENT"} ->
				state * 1
			%{type: "DECREMENT"} ->
				state - 1
			_ -> state
		end
	end
end
