class API

    def self.get_data
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/")
        pokemon_array = JSON.parse(response)["results"]     # each 'pokemon' in array is a has with :name and :url to json of pokemon details
        pokemon_array.each do |pokemon|
            response2 = RestClient.get(pokemon["url"])
            attributes = JSON.parse(response2)              # extracting actual pokemon details
            
            response3 = RestClient.get(attributes["location_area_encounters"])
            attributes2 = JSON.parse(response3)
            
            attributes[:name] = pokemon["name"]
            attributes[:location] = attributes2.collect {|l| l["location_area"]["name"]}
            Pokemon.new(attributes)
        end
    end

end