defmodule Viacepex do

  def get(cep) do
    cep = "#{cep}"
    case Viacepex.Cep.validate(cep) do
      :ok ->
        {:ok, Viacepex.Cep.get!(cep).body}
      errors ->
        errors
    end
  end

  def get!(cep) do
    cep
    |> get()
    |> elem(1)
  end
end
