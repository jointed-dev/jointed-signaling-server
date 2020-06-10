defmodule JointedSignalingServerWeb.UserSocketTest do
  use JointedSignalingServerWeb.ChannelCase, async: true
  alias JointedSignalingServerWeb.UserSocket

  test "connect to websocket" do
    assert {:ok, socket} = connect(UserSocket, %{}, %{})
  end

  test "nil socket ids" do
    {:ok, socket} = connect(UserSocket, %{}, %{})
    assert nil == UserSocket.id(socket)
  end
end
