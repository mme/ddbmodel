defmodule ExDynamoDbModel.Mixfile do
  use Mix.Project

  def project do
    [ app: :ex_dynamo_db_model,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ { :uuid,              github: "avtobiff/erlang-uuid"      },
      { :meck,              github: "eproxus/meck"              },
      { :jsx,               github: "talentdeficit/jsx"         },
      { :erlcloud,          github: "gleber/erlcloud"           }]
  end
end
