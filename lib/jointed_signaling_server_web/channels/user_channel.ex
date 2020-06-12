defmodule JointedSignalingServerWeb.UserChannel do
  use Phoenix.Channel

  def join("user", _message, socket) do
    {:ok, socket}
  end

  def handle_in("join_or_create_room", _params, socket) do
    # TODO: Check available rooms or create new one
    {:noreply, socket}
  end
end
