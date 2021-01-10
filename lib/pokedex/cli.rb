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
            puts "List of 10 Pokemon out of ... :"
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
        puts Pokemon.find_by_name(selection).name
    end

end