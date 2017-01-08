defmodule Weather.CLI do
  import Weather.TableFormatter, only: [print_table_for_columns: 2]

  def main do
    fetch_weather_information
    |> decode_response
    |> parse_xml
    |> print_table_for_columns(["location", "weather", "temperature"])
  end

  def fetch_weather_information do
    Weather.WeatherInfo.fetch
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    %{reason: reason} = error
    IO.puts "Error fetching from weather info: #{reason}"
    System.halt(2)
  end

  def parse_xml(body) do
    Weather.XmlParser.parse_xml(body)
  end
end
