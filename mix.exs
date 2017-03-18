defmodule Viacepex.Mixfile do
  use Mix.Project

  def project do
    [app: :viacepex,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ] 
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:poison, "~> 3.0"},
      {:exvcr, "~> 0.8", only: :test}
    ]
  end
end
