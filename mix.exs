defmodule Viacepex.Mixfile do
  use Mix.Project

  def project do
    [app: :viacepex,
     version: "0.0.2",
     elixir: "~> 1.2",
     description: "A library to access ViaCEP api",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps(),
     preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ],
     source_url: "https://github.com/migore/viacepex"
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

  defp package do
    [maintainers: ["Ygor Bruxel"],
     licenses: ["MIT"],
     links: %{"Github" => "https://github.com/migore/viacepex"}]
  end
end
