class CLI


    def start
        greeting
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
        puts "1. First letter of Pokemon Species name"
        puts "2. Pokemon Type"
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
            list_search_results
            menu
        when "2"
            puts "You chose option 2"
            menu
        when "exit"
            goodbye
        else
            invalid
        end
    end

    def list_search_results
        ["bulbasaur", "charmander", "squirtle"].each.with_index(1) do |pokemon, i|
            puts "#{i}. #{pokemon}"
        end
    end

    def pokemon_detail

    end

end