require_relative "./pokedex/version"

require 'bundler'
Bundler.require

require_relative "./pokedex/api.rb"
require_relative "./pokedex/cli.rb"
require_relative "./pokedex/pokemon.rb"
