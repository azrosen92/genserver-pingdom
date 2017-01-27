defmodule GenStageExample.ProducerConsumer do
    # alias Experimental.GenStage
    use GenStage

    def start_link do
        GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
    end

    def init(state) do
        {:producer_consumer, state, subscribe_to: [GenStageExample.Producer]}
    end

    def handle_events(urls, _from, state) do
        IO.puts "ProducerConsumer#handle_events"
        IO.puts state

        response_texts =
        urls
        |> Enum.map(fn(url) ->
            trimmed_url = String.trim(url, "\n")

            get_response = trimmed_url
            |> HTTPotion.get
            |> HTTPotion.Response.success?

            "#{trimmed_url} -> #{get_response}"
        end)

        {:noreply, response_texts, state}
    end
end