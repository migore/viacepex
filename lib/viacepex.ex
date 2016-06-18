defmodule Viacepex do

  def get(cep) do
    case Viacepex.Cep.validate(cep) do
      :ok ->
        {:ok, Viacepex.Cep.get!(cep).body}
      errors ->
        errors
    end
  end

  def get!(cep) do
    elem(get(cep), 1)
  end
end
