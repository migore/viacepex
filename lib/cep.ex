defmodule Viacepex.Cep do
  use HTTPoison.Base
  defstruct [:cep, :logradouro, :complemento, :bairro, :localidade, :uf, :unidade, :ibge, :gia]

  def process_url(cep) do
    "https://viacep.com.br/ws/#{cep}/json/"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(keys: :atoms!)
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
    |> Poison.decode!(keys: :atoms!)
  end

  def validate_search(state, city, street_name) do
    Keyword.new
    |> validate_city(city)
  end

  def validate_city(list, city) do
    city_length = String.length(city)
    cond do
      city_length < 3 ->
        Keyword.put(list, :city, :at_least_3_characters)
      true ->
        list
    end
  end
end
