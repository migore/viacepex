defmodule Viacepex do

  def get(cep) when is_bitstring(cep) do
    cep = "#{cep}"
    case Viacepex.Cep.validate(cep) do
      :ok ->
        {:ok, Viacepex.Cep.get!(cep).body}
      errors ->
        errors
    end
  end

  def get!(cep) do
    case get(cep) do
      {:ok, cep} ->
        cep
      {:error, error} ->
        raise ArgumentError, message: "Incorrect format!"
    end
  end
end
