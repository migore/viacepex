defmodule Viacepex do

  @doc """
    Get the cep from Viacep API

    Typical error reasons are:

      * `:incorrect_format`  - the format is not valid, the correct format is "\d{8}"
  """
  @spec get(String.t) :: {:ok, map | nil} | {:error, list}
  def get(cep) when is_bitstring(cep) do
    case Viacepex.Cep.validate(cep) do
      :ok ->
        {:ok, Viacepex.Cep.get(cep) |> one()}
      errors ->
        errors
    end
  end

  defp one(%{"erro" => true}), do: nil
  defp one(cep), do: cep

  def get(_) do
    raise ArgumentError, message: "Only string is accepted"
  end

  @doc """
    Same as `get/1` but raises an error if cep is format is incorrect
  """
  @spec get!(String.t) :: map | no_return
  def get!(cep) do
    case get(cep) do
      {:ok, nil} ->
        raise Viacepex.NoResultsError, message: "Expected a result but got none"
      {:ok, cep} ->
        cep
      {:error, _} ->
        raise ArgumentError, message: "Incorrect format!"
    end
  end

  @doc """
    Search for state, city, street in Viacep API

    `state` must be a two letter string, a Brazil UF, or the result
    will be empty. `city` and `street_name` must be at least three characters long.
  """
  @spec search(String.t, String.t, String.t) :: {:ok, list} | {:error, list}
  def search(state, city, street_name)
      when is_bitstring(state) and is_bitstring(city) and is_bitstring(street_name) do
    validation_result = Viacepex.Cep.validate_search(state, city, street_name)
    cond do
      Enum.count(validation_result) == 0 ->
        {:ok, Viacepex.Cep.search(state, city, street_name)}
      true ->
        {:error, validation_result}
    end
  end

  def search(_, _, _) do
    raise ArgumentError, message: "All parameters must be String.t"
  end
end
