defmodule BlackspiderWeb.ExchangeInfoController do
    use BlackspiderWeb, :controller
  
    def index(conn, _params) do

      url = "https://api.binance.com/api/v3/exchangeInfo"

      # IO.inspect HTTPoison.get(url)

      case HTTPoison.get(url) do
        {:ok, %{status_code: 200, body: body}} ->

          exchange_data = Poison.decode!(body)

          conn
          |> json(%{
            status: "success",
            data: Poison.decode!(body) |> Map.get("symbols") |> __MODULE__.arbMapper
          })

        {:ok, %{status_code: 404}} ->
          
          conn
          |> json(%{
            status: "not found",
            message: "Resource Not Found 404."
          })

        {:error, %{reason: reason}} ->
         
          conn
          |> json(%{
            status: "error",
            message: reason
          })

      end

    end

    def arbMapper(symbols) do
      
      for first_pair <- symbols, second_pair <- symbols, third_pair <- symbols, do: %{"first_pair": first_pair["symbol"], "second_pair": second_pair["symbol"], "third_pair": third_pair["symbol"]}

    end

  end
  