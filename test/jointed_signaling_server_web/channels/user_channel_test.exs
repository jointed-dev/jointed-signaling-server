defmodule JointedSignalingServerWeb.UserChannelTest do
  use JointedSignalingServerWeb.ChannelCase, async: true
  alias JointedSignalingServerWeb.{UserSocket, UserChannel}

  setup do
    start_supervised(JointedSignalingServer.AvailableRoomServer)

    {:ok, _, socket} =
      UserSocket
      |> socket(%{}, %{})
      |> subscribe_and_join(UserChannel, "user")

    %{socket: socket}
  end

  #
  # Unit tests
  #

  test "join user channel" do
    {:ok, socket} = connect(UserSocket, %{}, %{})
    assert {:ok, socket} = UserChannel.join("user", "", socket)
  end

  #
  # Integration tests
  #

  test "handle_in join_or_create_room", %{socket: socket} do
    ref = push(socket, "join_or_create_room", %{})
    assert_reply ref, :ok, %{id: id}
    assert is_binary(id)
  end
end
