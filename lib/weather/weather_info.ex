defmodule Weather.WeatherInfo do
  @weather_url Application.get_env(:weather, :weather_url)

  def fetch do
    HTTPoison.get(@weather_url)
    |> handle_response
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, :xmerl_scan.string(String.to_char_list(body))}
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    {:error, body}
  end
end
