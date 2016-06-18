defmodule Viacepex do

  def get(cep) when is_integer(cep) do
    cep
    |> Integer.to_string()
    |> get()
  end


  def get(cep) do
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
