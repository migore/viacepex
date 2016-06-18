defmodule Viacepex do
  def get!(cep) do
    Viacepex.Cep.get!(cep).body
  end
end
