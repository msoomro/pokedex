class CLI


    def start
        greeting
        API.get_data
        menu
    end

    def greeting
        puts "Welcome to your Pokedex.\n"
    end

    def goodbye
        puts "Goodbye"
    end

    def invalid
        puts "Hmm, that doesn't seem like a valid option, try again?"
        menu
    end

    def user_input
        gets.strip
    end

    def menu
        puts "\n\nHow would you like to search for a Pokemon?\n"
        puts "1. Name of Pokemon Species"
        puts "2. List all Pokemon"
        puts "or type \'exit\' to close the Pokedex."
        puts "\n"

        navigate_menu
    end

    def navigate_menu
        print "Enter the number of the menu option:\t"
        selection = user_input
        puts "\n"

        case selection
        when "1"
            puts "You chose option 1"
            pokemon_selection
            menu
        when "2"
            puts "List of 20 Pokemon out of ... :"
            list_search_results(Pokemon.all)
            menu
        when "exit"
            goodbye
        else
            invalid
        end
    end

    def list_search_results(p_array)
        p_array.each.with_index(1) do |pokemon, i|
            puts "#{i}. #{pokemon.name}"
        end
    end

    def pokemon_selection
        puts "Select a Pokemon for more detail:\t"
        selection = user_input
        pokemon = Pokemon.find_by_name(selection)
        pokemon_detail(pokemon)
    end

    def pokemon_detail(pokemon)
        puts "Name:\t #{pokemon.name.capitalize}"
        puts "Types:\t #{pokemon.types.collect {|type| type["type"]["name"]}.join(', ')}"
        puts "Base XP: #{pokemon.base_experience}"
        puts "Abilities: #{pokemon.abilities.collect {|ability| ability["ability"]["name"]}.join(', ')}"
        puts "Locations: \n\t#{pokemon.location.join("\n\t").gsub("-", " ")}"
    end
end