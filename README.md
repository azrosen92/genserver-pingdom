# GenstageExample

This project is a clone of Pingdom using Elixir and GenStage. The goal of this projecct is to 

1. Learn Elixir and GenStage
2. See what kind of performance gains I can get by leveraging Elixir's built-in concurrency

After building a working tool that has the base functionality of Pingdom (i.e. can read from a database
of websites, ping each one and record the status of the request), I'll be able to extrapolate a cost
per pinged website. Then I can compare that to the cost of Pingdom's plans – interesting results may ensue.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `genstage_example` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:genstage_example, "~> 0.1.0"}]
    end
    ```

  2. Ensure `genstage_example` is started before your application:

    ```elixir
    def application do
      [applications: [:genstage_example]]
    end
    ```

