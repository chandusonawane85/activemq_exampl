defmodule ActivemqExampl.MixProject do
  use Mix.Project

  def project do
    [
      app: :activemq_exampl,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:stomp_ex, "~> 0.3.0"}
    ]
  end
end
