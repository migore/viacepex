defmodule ViacepexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "simple cep request" do
    use_cassette "praca_da_se" do
      address = Viacepex.get!("01001000")
      assert "Praça da Sé" == address["logradouro"]
    end
  end

  test "cep has an 8 digit format" do
    result = Viacepex.get("123")
    assert {:error, [cep: :incorrect_format]} == result
  end

  test "get! raises en error" do
    assert_raise ArgumentError, "Incorrect format!", fn ->
      Viacepex.get!("123")
    end
  end

  test "get with anything but a string raises an informative error" do
    assert_raise ArgumentError, "Only string is accepted", fn ->
      Viacepex.get(123)
    end
  end

  test "get return nil when no cep was found" do
    use_cassette "empty_cep_get" do
      {:ok, result} = Viacepex.get("12312312")
      assert nil == result
    end
  end

  test "search find a list of possible addresses" do
    use_cassette "alegre_olavo" do
      {:ok, search_result = [first_item | _]} = Viacepex.search("RS", "Alegre", "Olavo")
      assert Enum.count(search_result) == 8
      assert first_item["logradouro"] == "Rua Olavo Dutra"
    end
  end

  test "search encodes city name" do
    use_cassette "porto_alegre_olavo" do
      {:ok, search_result} = Viacepex.search("RS", "Porto Alegre", "Olavo")
      assert Enum.count(search_result) == 8
    end
  end

  test "search encode street name" do
    use_cassette "alegre_assis_brasil" do
      {:ok, search_result} = Viacepex.search("RS", "Alegre", "Assis Brasil")
      assert Enum.count(search_result) == 20
    end
  end

  test "check if state has exactly 2 chars before searching" do
    search_result = Viacepex.search("R", "Alegre", "Olavo")
    assert {:error,[state: :exactly_2_characters]} == search_result
  end

  test "check if city has at least 3 chars before searching" do
    search_result = Viacepex.search("RS", "Al", "Olavo")
    assert {:error, [city: :at_least_3_characters]} == search_result
  end

  test "check if street name has at least 3 chars before searching" do
    search_result = Viacepex.search("RS", "Porto Alegre", "Ol")
    assert {:error, [street: :at_least_3_characters]} == search_result
  end

  test "search with anything but strings raises an informative error" do
    assert_raise ArgumentError, "All parameters must be String.t", fn ->
      Viacepex.search(1,2,3)
    end
  end
end

