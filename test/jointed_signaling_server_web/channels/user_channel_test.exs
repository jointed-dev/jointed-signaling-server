defmodule JointedSignalingServerWeb.UserChannelTest do
  use JointedSignalingServerWeb.ChannelCase, async: true
  alias JointedSignalingServerWeb.{UserSocket, UserChannel}

  setup do
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

  test "handle_in join_or_create_room", %{socket: socket} do
    assert {:noreply, socket} = UserChannel.handle_in("join_or_create_room", %{}, socket)
  end
end
