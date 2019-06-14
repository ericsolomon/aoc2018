defmodule D1P1 do
  def run do
    File.read!("input.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum()
  end
end

defmodule D1P2 do
  def run do
    input =
      File.read!("input.txt")
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer(&1))

    solve(input, [], 0)
  end

  defp solve(freq), do: freq
  defp solve(list, seen, freq), do: solve(list, list, seen, freq)
  defp solve([], list, seen, freq), do: solve(list, seen, freq)

  defp solve([head | tail], list, seen, freq) do
    new_freq = freq + head

    if new_freq in seen do
      solve(new_freq)
    else
      solve(tail, list, [new_freq | seen], new_freq)
    end
  end
end
