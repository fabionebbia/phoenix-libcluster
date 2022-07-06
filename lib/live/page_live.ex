defmodule DiscoveryWeb.PageLive do
  use DiscoveryWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      node()
      |> Atom.to_string()
      |> DiscoveryWeb.Endpoint.subscribe()
    end

    {:ok, assign(socket,
      node: node(),
      nodes: Node.list(),
      messages: []
    )}
  end

  @impl true
  def handle_event("send", %{"message" => text, "recipient" => topic}, socket) do
    # recipient = String.to_atom(recipient) # unsafe
    message = %{sender: node(), text: text}
    DiscoveryWeb.Endpoint.broadcast(topic, "new_message", message)
    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "new_message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

end
