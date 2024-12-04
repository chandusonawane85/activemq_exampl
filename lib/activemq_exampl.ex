defmodule QueueForwarder do
  use GenServer

  @source_queue "/queue/source"
  @target_queue "/queue/target"

  @stomp_config [
    host: "localhost",    # Replace with your ActiveMQ host
    port: 61613,          # Default STOMP port
    login: "admin",       # Replace with ActiveMQ username
    passcode: "admin"     # Replace with ActiveMQ password
  ]

  # Start the GenServer
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, conn} = :stomp.connect(@stomp_config)
    :ok = :stomp.subscribe(conn, @source_queue, ack: "client")

    {:ok, %{conn: conn}}
  end

  @impl true
  def handle_info({:stomp_message, message}, state) do
    IO.puts("Received message: #{message.body}")

    # Forward the message to the target queue
    :stomp.send(state.conn, @target_queue, message.body)

    # Acknowledge the message if necessary
    :stomp.ack(state.conn, message)

    {:noreply, state}
  end

  @impl true
  def terminate(_reason, %{conn: conn}) do
    :stomp.disconnect(conn)
    :ok
  end
end

# Start the application
defmodule ForwarderApp do
  def start do
    QueueForwarder.start_link([])
  end
end

ForwarderApp.start()
