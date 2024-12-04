defmodule ActiveMQSender do
  @moduledoc """
  A simple module to send messages to ActiveMQ using STOMP.
  """

  alias StompClient.Connection
  alias StompClient.Message

  @broker_url "stomp://localhost:61613" # Update as per your setup
  @queue_name "/queue/testQueue"         # Update queue name if necessary

  def send_message(body) do
    with {:ok, conn} <- Connection.start_link(@broker_url, "admin", "admin"), # Adjust credentials
         {:ok, _} <- Connection.connect(conn) do
      message = %Message{
        destination: @queue_name,
        body: body
      }

      case Connection.send(conn, message) do
        :ok ->
          IO.puts("Message sent successfully!")

        {:error, reason} ->
          IO.puts("Failed to send message: #{inspect(reason)}")
      end

      Connection.disconnect(conn)
    else
      {:error, reason} ->
        IO.puts("Connection error: #{inspect(reason)}")
    end
  end
end
