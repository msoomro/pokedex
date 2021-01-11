class CLI

    def start
        greeting
        API.get_data
        menu
    end

    def greeting
        puts "Welcome to your Pokedex."
        puts "Loading system...\n"
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
        puts "\n\nWhat would you like to see?\n"
        puts "1. List all Pokemon"
        puts "2. Tell me about one Pokemon"
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
            puts "All Pokemon ... :"
            list_search_results(Pokemon.all)
            menu
        when "2"
            pokemon_selection
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
        puts "Which Pokemon do you want to learn about:\t"
        selection = user_input
        pokemon = Pokemon.find_by_name(selection)
        pokemon.get_data
        pokemon_detail(pokemon)
    end

    def pokemon_detail(pokemon)
        puts "Name:\t #{pokemon.name.capitalize}"
        puts "Types:\t #{pokemon.types.collect {|type| type["type"]["name"]}.join(', ')}"
        puts "Base XP: #{pokemon.base_experience}"
        puts "Abilities: #{pokemon.abilities.collect {|ability| ability["ability"]["name"]}.join(', ')}"
        puts "Locations: \n\t#{pokemon.locations.join("\n\t").gsub("-", " ")}"
    end

end