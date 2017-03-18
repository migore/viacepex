# Viacepex

Viacepex is a simple wrapper around [viacep](https://viacep.com.br/) API.

## Installation

The package can be installed as:

1. Add viacepex to your list of dependencies in `mix.exs`:

```elixir
def deps do
[
 {:viacepex, github: "migore/viacepex"}
]
end
```

2. (Before elixir 1.4 only) Ensure viacepex is started before your application:

```elixir
def application do
[applications: [:viacepex]]
end
```


## Quickstart

```elixir
iex> Viacepex.get! "01001000"
#%{bairro: "Sé", cep: "01001-000", complemento: "lado ímpar", gia: "1004",
#  ibge: "3550308", localidade: "São Paulo", logradouro: "Praça da Sé",
#  uf: "SP", unidade: ""}
```
