defmodule Viacepex do
  use HTTPoison.Base
  @derive [Poison.Encoder]
  defstruct [:cep, :logradouro, :complemento, :bairro, :localidade, :uf, :unidade, :ibge, :gia]

  def process_url(cep) do
    "https://viacep.com.br/ws/#{cep}/json/"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(as: %Viacepex{})
  end
end
