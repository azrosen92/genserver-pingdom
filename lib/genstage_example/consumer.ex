defmodule GenStageExample.Consumer do
    # alias Experimental.GenStage    
    use GenStage

    def start_link do
        GenStage.start_link(__MODULE__, :state_doesnt_matter)
    end

    def init(state) do
        {:consumer, state, subscribe_to: [GenStageExample.ProducerConsumer]}
    end

    def handle_events(events, _from, state) do
        events
        |> Enum.map(IO.puts)

        {:noreply, [], state}
    end
end