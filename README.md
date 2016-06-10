# Viacepex

Viacepex is a simple wrapper around [viacep](https://viacep.com.br/) API.

## Installation

The package can be installed as:

  1. Add viacepex to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:viacepex, "~> 0.0.1"}]
    end
    ```

  2. Ensure viacepex is started before your application:

	```elixir
    def application do
      [applications: [:viacepex]]
    end
    ```


## Quickstart

```elixir
iex> Viacepex.get! "01001000"
#%HTTPoison.Response{body: %Viacepex{bairro: "Sé", cep: "01001-000",
#  complemento: "lado ímpar", gia: "1004", ibge: "3550308",
#  localidade: "São Paulo", logradouro: "Praça da Sé", uf: "SP", unidade: ""},
# headers: [{"Server", "nginx/1.8.1"}, {"Date", "Fri, 10 Jun 2016 01:22:50 GMT"},
#  {"Content-Type", "application/json; charset=utf-8"},
#  {"Transfer-Encoding", "chunked"}, {"Connection", "keep-alive"},
#  {"Access-Control-Max-Age", "86400"},
#  {"Access-Control-Allow-Credentials", "true"},
#  {"Access-Control-Allow-Headers",
#   "Content-Type, X-Request-With, X-Requested-By"},
#  {"Access-Control-Allow-Origin", "*"},
#  {"Access-Control-Allow-Methods", "GET, OPTIONS"},
#  {"Expires", "Fri, 10 Jun 2016 02:22:50 GMT"},
#  {"Cache-Control", "max-age=3600"}, {"Cache-Control", "public"}],
# status_code: 200}

```