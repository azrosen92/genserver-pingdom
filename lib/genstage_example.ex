defmodule GenstageExample do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    IO.puts "hello world"

    # {:ok, producer} = GenStage.start_link(GenStageExample.Producer, 0)
    # {:ok, prod_con} = GenStage.start_link(GenStageExample.ProducerConsumer, :ok)
    # {:ok, consumer} = GenStage.start_link(GenStageExample.Consumer, :ok)

    # GenStage.sync_subscribe(prod_con, to: producer, max_demand: 100)
    # GenStage.sync_subscribe(consumer, to: prod_con)

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: GenstageExample.Worker.start_link(arg1, arg2, arg3)
      # worker(GenstageExample.Worker, [arg1, arg2, arg3]),
      worker(GenStageExample.Producer, [0]),
      worker(GenStageExample.ProducerConsumer, []),
      worker(GenStageExample.Consumer, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
