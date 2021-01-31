defmodule Blackspider.Binance do
    use WebSockex
    alias Blackspider.Binance.TradeEvents

   _stream_endpoint = "wss://stream.binance.com:9443/ws/"
  
    def start_link(symbol, state) do
      WebSockex.start_link("wss://stream.binance.com:9443/ws/#{symbol}@trade", __MODULE__, state)
    end
  
    def handle_frame({type, msg}, state) do

        case Jason.decode(msg) do
            {:ok, event} -> handle_cast(event, state)
            {:error, _} -> throw("Error processing the message: #{msg}")
        end

        {:ok, state}

    end
  
    def handle_cast(%{"e" => "trade"} = event, state) do
      
        
        trade_event = %TradeEvents{
            :event_type => event["e"],
            :event_time => event["E"],
            :symbol => event["s"],
            :trade_id => event["t"],
            :price => event["p"],
            :quantity => event["q"],
            :buyer_order_id => event["b"],
            :seller_order_id => event["a"],
            :trade_time => event["T"],
            :buyer_the_market_maker => event["m"],
            :ignore => event["M"]
        }

        IO.inspect(trade_event, label: "Trade Event Received: ")

    end

  end