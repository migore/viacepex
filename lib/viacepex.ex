defmodule Viacepex do

  @doc """
    Get the cep from Viacep API

    Typical error reasons are:

      * `:incorrect_format`  - the format is not valid, the correct format is "\d{8}"
  """
  @spec get(String.t) :: {:ok, map} | {:error, atom}
  def get(cep) when is_bitstring(cep) do
    cep = "#{cep}"
    case Viacepex.Cep.validate(cep) do
      :ok ->
        {:ok, Viacepex.Cep.get!(cep).body}
      errors ->
        errors
    end
  end

  @doc """
    Same as `get/1` but raises an error if cep is format is incorrect
  """
  @spec get!(String.t) :: map | no_return
  def get!(cep) do
    case get(cep) do
      {:ok, cep} ->
        cep
      {:error, error} ->
        raise ArgumentError, message: "Formato incorreto!"
    end
  end
end
