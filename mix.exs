defmodule Jesse.Mixfile do
  use Mix.Project

  @version "2.0.2"

  def project do
    [
      app: :jesse,
      version: @version,
      language: :erlang,
      deps: deps(Mix.env()),
      description: "jesse (JSon Schema Erlang) is an implementation of a JSON Schema validator for Erlang.",
      package: package(),
      source_url: "https://github.com/aruki-delivery/jesse",
      start_permanent: Mix.env() == :prod,
      deps: deps(Mix.env()),
    ]
  end

  def application do
    [
      extra_applications: [
        :eex,
        :logger,
        :flex_logger,
        :kernel,
        :stdlib,
        :rfc3339,
        :json,
      ],
      mod: []
    ]
  end

  defp deps(_) do
    [
      {:json, "~> 1.2"},
      {:egithub, github: "aruki-delivery/erlang-github", tag: "2.0.1", override: true, only: :test},
      {:rfc3339, "~> 0.9.0"},
      {:flex_logger, "~> 0.2.1"},
      {:elvis_shell, "~> 0.4.1", hex: :elvis, only: [:test]},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:ex_unit_notifier, "~> 0.1", only: :test},
    ]
  end

  def package do
    [
      maintainers: ["aruki-delivery", "cblage"],
      licenses: ["Copyright"],
      links: %{"GitHub" => "https://github.com/aruki-delivery/jesse" }
    ]
  end
end