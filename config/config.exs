import Config

config :activemq_example, :activemq,
  host: "localhost",    # Your ActiveMQ server's hostname or IP
  port: 61613,          # Default STOMP port
  username: "admin",    # Your ActiveMQ username
  password: "admin",    # Your ActiveMQ password
  client_id: "elixir_client"
