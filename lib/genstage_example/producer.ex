defmodule GenStageExample.Producer do
    # alias Experimental.GenStage
    use GenStage

    def start_link(initial \\ 0) do
        IO.puts "Start producing"
        GenStage.start_link(__MODULE__, initial, name: __MODULE__)
    end

    def init(counter), do: {:producer, counter}

    def handle_demand(demand, state) do
        IO.puts "Handling producer demand: #{demand}"

        get_urls
        |> case do
            {:ok, urls_stream} ->
                {:noreply, urls_stream |> Enum.to_list, (state + demand)}
            {:error, reason} ->
                IO.puts ":error case"
                IO.puts reason # this should probably return an empty stream or something like that.
                {:noreplay, reason, (state + demand)}
        end
    end

    defp get_urls do
        maybe_file_device = File.open! "websites.txt"

        maybe_file_device
        |> IO.stream(:line)
        |> Enum.to_list
        |> Enum.each(fn(n) ->
            IO.puts n
        end)

        IO.puts "Getting URLS"

        {:ok, IO.stream(maybe_file_device, :line)}

        # case maybe_file_device do
        #     {:ok, file_device} ->
        #         IO.puts "ok, got file"
        #         {:ok, IO.stream(file_device, :line)}
        #     {:error, reason} ->
        #         IO.puts "ABORT ABORT!"
        #         {:error, reason}
        # end
    end
end