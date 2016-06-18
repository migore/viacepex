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
end
