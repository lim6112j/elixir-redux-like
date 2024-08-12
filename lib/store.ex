defmodule Store do
	@initialize_action %{type: "@@INIT"}
	use GenServer
	def start_link(reducer, initial_state \\ nil) do
		GenServer.start_link(__MODULE__, [reducer, initial_state])
	end


	def dispatch(store, action) do
		GenServer.cast(store, {:dispatch, action})
	end
	def subscribe(store, subscriber) do
		GenServer.call(store, {:subscribe, subscriber})
	end
	def remove_subscriber(store, ref) do
		GenServer.cast(store, {:remove_subscriber, ref})
	end

	def get_state(store) do
		GenServer.call(store, {:get_state})
	end
	def get_subscribers(store) do
		GenServer.call(store, {:get_subscribers})
	end

	def init([reducer_map, nil]) when is_map(reducer_map), do: init([reducer_map, %{}])

	def init([reducer_map, initial_state]) when is_map(reducer_map) do
		store_state = CombineReducers.reduce(reducer_map, initial_state, @initialize_action)
		{:ok, %{reducer: reducer_map, store_state: store_state, subscribers: %{}} }
	end
	def init([reducer, initial_state]) do
		store_state = apply(reducer, :reduce, [initial_state, @initialize_action])
		{:ok, %{reducer: reducer, store_state: store_state, subscribers: %{}} }
	end
	def handle_call({:get_state}, _from , state) do
		{:reply, Map.get(state, :store_state), state}
	end
	def handle_call({:get_subscribers}, _from, state) do
		{:reply, Map.get(state, :subscribers), state}
	end

	def handle_call({:subscribe, subscriber}, _from, state) do
		ref = make_ref()
		{:reply, ref, put_in(state, [:subscribers, ref], subscriber)}
	end

	def handle_cast({:dispatch, action}, state) when is_map(state.reducer) do
		store_state = CombineReducers.reduce(state.reducer,state.store_state, action)
		for {_ref, sub} <- state.subscribers, do: sub.(store_state)
		{:noreply, Map.put(state, :store_state, store_state)}
	end

	def handle_cast({:dispatch, action}, state) do
		store_state = apply(state.reducer, :reduce, [state.store_state, action])
		for {_ref, sub} <- state.subscribers, do: sub.(store_state)
		{:noreply, Map.put(state, :store_state, store_state)}
	end
	def handle_cast({:remove_subscriber, ref}, state) do
		subscribers = Map.delete(state.subscribers, ref)
		{:noreply, Map.put(state, :subscribers, subscribers)}
	end


end
