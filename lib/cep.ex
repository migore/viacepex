defmodule Viacepex.Cep do

  def get(cep) do
    HTTPoison.get!("https://viacep.com.br/ws/#{cep}/json/").body
    |> Poison.decode!
  end

  def validate(cep) do
    case Regex.match?(~r/^\d{8}$/, cep) do
      true ->
        :ok
      false ->
        {:error, [cep: :incorrect_format]}
    end
  end

  def search(state, city, street_name) do
    city = URI.encode(city)
    street_name = URI.encode(street_name)
    HTTPoison.get!("https://viacep.com.br/ws/#{state}/#{city}/#{street_name}/json/").body
    |> Poison.decode!
  end

  def validate_search(state, city, street_name) do
    Keyword.new
    |> validate_state(state)
    |> validate_city(city)
    |> validate_street(street_name)
  end

  defp validate_state(list, state) do
    state_length = String.length(state)
    cond do
      state_length != 2 ->
        Keyword.put(list, :state, :exactly_2_characters)
      true ->
        list
    end
  end

  defp validate_city(list, city) do
    city_length = String.length(city)
    cond do
      city_length < 3 ->
        Keyword.put(list, :city, :at_least_3_characters)
      true ->
        list
    end
  end

  defp validate_street(list, street_name) do
    street_length = String.length(street_name)
    cond do
      street_length < 3 ->
        Keyword.put(list, :street, :at_least_3_characters)
      true ->
        list
    end
  end
end
