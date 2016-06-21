defmodule ViacepexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "simple cep request" do
    use_cassette "praca_da_se" do
      address = Viacepex.get!("01001000")
      assert "Praça da Sé" == address.logradouro
    end
  end

  test "cep has an 8 digit format" do
    result = Viacepex.get("123")
    assert {:error, [cep: :incorrect_format]} == result
  end

  test "get! raises en error" do
    assert_raise ArgumentError, "Formato incorreto!", fn ->
      Viacepex.get!("123")
    end
  end

  test "search find a list of possible addresses" do
    use_cassette "porto_alegre_olavo" do
      search_result = Viacepex.search("RS", "Alegre", "Olavo")
      assert Enum.count(search_result) == 8
    end
  end
end

