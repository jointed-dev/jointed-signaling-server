defmodule JointedSignalingServerWeb.RoomChannelTest do
  use JointedSignalingServerWeb.ChannelCase, async: true
  alias JointedSignalingServerWeb.RoomChannel
  alias JointedSignalingServerWeb.UserSocket

  setup do
    {:ok, _, socket} =
      UserSocket
      |> socket(%{}, %{})
      |> subscribe_and_join(RoomChannel, "room:test")

    %{socket: socket}
  end

  #
  # Unit tests
  #

  test "join room" do
    {:ok, socket} = connect(UserSocket, %{}, %{})
    assert {:ok, socket} = RoomChannel.join("room:123", %{}, socket)
  end

  test "handle_in on new_msg event", %{socket: socket} do
    assert {:noreply, socket} = RoomChannel.handle_in("new_msg", %{"body" => %{}}, socket)
  end

  #
  # Integration tests
  #

  test "new_msg broadcasts into pubsub", %{socket: socket} do
    push(socket, "new_msg", %{"body" => "test"})
    assert_broadcast "new_msg", %{body: "test"}
  end

  test "connected clients receive new_msg", %{socket: socket} do
    push(socket, "new_msg", %{"body" => "test"})
    assert_push "new_msg", %{body: "test"}
  end
end
