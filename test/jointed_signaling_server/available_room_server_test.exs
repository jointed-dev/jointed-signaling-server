defmodule JointedSignalingServer.AvailableRoomServerTest do
  use ExUnit.Case

  #
  # Unit tests
  #

  describe "start_link" do
    test "start_link with room_id" do
      id = UUID.uuid4()
      assert {:ok, server_pid} = JointedSignalingServer.AvailableRoomServer.start_link([id])
    end

    test "start_link with invalid room_id" do
      assert_raise(FunctionClauseError, fn ->
        JointedSignalingServer.AvailableRoomServer.start_link(123)
      end)
    end

    test "start_link with empty list" do
      assert {:ok, server_pid} = JointedSignalingServer.AvailableRoomServer.start_link([])
    end
  end

  test "join_or_create" do
    {:ok, _} = JointedSignalingServer.AvailableRoomServer.start_link([])
    assert is_binary(JointedSignalingServer.AvailableRoomServer.join_or_create())
  end

  test "init" do
    assert {:ok, 123} = JointedSignalingServer.AvailableRoomServer.init(123)
  end

  describe "handle_call" do
    test "handle_call join_or_create with nil state" do
      assert {:reply, id1, id2} =
               JointedSignalingServer.AvailableRoomServer.handle_call(
                 :join_or_create,
                 "test",
                 nil
               )

      assert is_binary(id1) and is_binary(id2)
      assert id1 == id2
    end

    test "handle_call join_or_create" do
      assert {:reply, 123, nil} =
               JointedSignalingServer.AvailableRoomServer.handle_call(
                 :join_or_create,
                 "test",
                 123
               )
    end
  end

  #
  # Integration tests
  #

  test "join_or_create with available_room" do
    start_supervised({JointedSignalingServer.AvailableRoomServer, ["123"]})

    assert JointedSignalingServer.AvailableRoomServer.join_or_create() == "123"
  end
end
