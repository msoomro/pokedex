class API

    def self.get_data
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1083")
        pokemon_array = JSON.parse(response)["results"]     # each 'pokemon' in array is a has with :name and :url to json of pokemon details
        pokemon_array.each do |pokemon|
            #response2 = RestClient.get(pokemon["url"])
            #attributes = JSON.parse(response2)              # extracting pokemon details
            attributes = {}
            #response3 = RestClient.get(attributes["location_area_encounters"])
            #attributes2 = JSON.parse(response3)             # extracting just the location data
            
            attributes[:name] = pokemon["name"]
            #attributes[:location] = attributes2.collect {|l| l["location_area"]["name"]}
            Pokemon.new(attributes)
        end
    end

end