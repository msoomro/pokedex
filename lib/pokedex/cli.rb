class CLI

    def start
        greeting
        API.get_data
        menu
    end

    def greeting
        puts "
        ██████╗░░█████╗░██╗░░██╗███████╗██████╗░███████╗██╗░░██╗
        ██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗██╔════╝╚██╗██╔╝
        ██████╔╝██║░░██║█████═╝░█████╗░░██║░░██║█████╗░░░╚███╔╝░
        ██╔═══╝░██║░░██║██╔═██╗░██╔══╝░░██║░░██║██╔══╝░░░██╔██╗░
        ██║░░░░░╚█████╔╝██║░╚██╗███████╗██████╔╝███████╗██╔╝╚██╗
        ╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝╚═╝░░╚═╝"
        puts "Welcome to your Pokedex."
        puts "Loading system...\n\n\n"
    end

    def goodbye
        puts "Goodbye, Trainer"
    end

    def invalid
        puts "Hmm, that doesn't seem like a valid option, try again?"
        menu
    end

    def user_input
        gets.strip
    end

    def menu
        puts "\n\n☆  M * E * N * U  ☆\n"
        puts "What would you like to see?\n"
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
        puts "Type Pokemon name (or 'cancel' to return to menu):\t"
        selection = user_input
        pokemon = Pokemon.find_by_name(selection) unless selection == 'cancel'
        if selection == 'cancel'
            # do nothing
        elsif pokemon != nil
            pokemon.get_data
            pokemon_detail(pokemon) 
        else
            puts "\nHmm, #{selection} is not a valid Pokemon. Try again?"
            pokemon_selection
        end
    end

    def pokemon_detail(pokemon)
        puts "\n\n─────────────── *.·:·.☆*☆*☆*☆.·:·.*───────────────"
        puts "Name:\t #{pokemon.name.capitalize}"
        puts "Types:\t #{pokemon.types.collect {|type| type["type"]["name"]}.join(', ')}"
        puts "Base XP: #{pokemon.base_experience}"
        puts "Abilities: #{pokemon.abilities.collect {|ability| ability["ability"]["name"]}.join(', ')}"
        puts "\n─────────────── *.·:·.☆*☆*☆*☆.·:·.*───────────────\n\n"
        puts "\n<--| 'back'\t  <type to navigate>  \t'locations'|-->\n"
        pokemon_location(pokemon)
    end

    def pokemon_location(pokemon)
        selection = user_input
        if selection == 'locations'
            puts "==========================《》=========================="
            puts "#{pokemon.name.capitalize} can be found at these locations: "
            puts "Locations: \n\t#{pokemon.locations.join("\n\t").gsub("-", " ")}"
            puts "==========================《》=========================="
        elsif selection == 'back'
            # do nothing
        else
            puts "\nTry typing 'back' to return to menu or 'locations' to see where this pokemon is found"
            pokemon_location(pokemon)
        end
    end
end