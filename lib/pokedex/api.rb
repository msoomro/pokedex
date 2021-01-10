class API

    def self.get_data
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/")
        pokemon_array = JSON.parse(response)["results"]
        pokemon_array.each do |pokemon|
            Pokemon.new(pokemon)
        end
    end

end