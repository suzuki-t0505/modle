defmodule Modle do
  def central do
    %{vertex: vertex_value, line: line_value, triangle: triangle_value} = get_gts_data()
    vertex_value = process_data(vertex_value, [:x, :y, :z])
    line_value = process_data(line_value, [:start_point, :end_point])
    triangle_value = process_data(triangle_value, [:first, :second, :third])
    data = Poison.encode!(%{vertex: vertex_value, line: line_value, triangle: triangle_value})
    file_write(data)
  end

  defp get_gts_data() do
    [option | data] =
      File.read!("cube.gts")
      |> String.split("\n")
      |> Enum.filter(& &1 != "")

    option = String.split(option, " ") |> Enum.map(& String.to_integer(&1))
    option = [:vertex, :line, :triangle] |> Enum.zip(option) |> Enum.into(%{})

    {vertex, data} = Enum.split(data, option.vertex)
    {line, triangle} = Enum.split(data, option.line)

    %{vertex: vertex, line: line, triangle: triangle}

  end

  defp process_data(vertex_value, key) do
    data =
      Enum.map(vertex_value,
        fn value -> String.split(value, " ") |> Enum.filter(& &1 != "")
      end)

      Enum.map(data, fn value -> Enum.zip(key, value) |> Enum.into(%{}) end)
  end

  defp file_write(data) do
    path = "./json"
    File.mkdir_p(path)
    File.open!(path <> "/modle.json", [:write])
    |> IO.binwrite(data)
  end
end
