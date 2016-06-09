defmodule ViacepexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "simple cep request" do
    use_cassette "praca_da_se" do
      body = Viacepex.get!("01001000").body
      assert "Praça da Sé" == body.logradouro
    end
  end
end
