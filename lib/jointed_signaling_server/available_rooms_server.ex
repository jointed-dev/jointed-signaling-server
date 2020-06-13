defmodule JointedSignalingServer.AvailableRoomServer do
  use GenServer

  def start_link([room_id]) when is_binary(room_id) do
    GenServer.start_link(__MODULE__, room_id, name: __MODULE__)
  end

  def start_link([]) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def join_or_create do
    GenServer.call(__MODULE__, :join_or_create)
  end

  @impl true
  def init(available_room) do
    {:ok, available_room}
  end

  @impl true
  def handle_call(:join_or_create, _from, nil) do
    id = UUID.uuid4()
    {:reply, id, id}
  end

  @impl true
  def handle_call(:join_or_create, _from, available_room) do
    {:reply, available_room, nil}
  end
end
