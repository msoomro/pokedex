class API

    def self.get_data
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1083")
        pokemon_array = JSON.parse(response)["results"]     # each 'pokemon' in array is a has with :name and :url to json of pokemon details
        pokemon_array.each do |attributes|
            Pokemon.new(attributes)
        end
    end

    def self.get_pokemon_data(pokemon_url)
        response = RestClient.get(pokemon_url)
        attributes = JSON.parse(response)

        response2 = RestClient.get(attributes["location_area_encounters"])
        attributes2 = JSON.parse(response2)
        attributes[:locations] = attributes2.collect { |l| l["location_area"]["name"]}
        
        attributes
    end

end