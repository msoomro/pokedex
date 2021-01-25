class CLI

    def start
        greeting
        API.get_data
        menu
    end

    def greeting
        puts "Loading system..."
        puts "
        ██████╗░░█████╗░██╗░░██╗███████╗██████╗░███████╗██╗░░██╗
        ██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗██╔════╝╚██╗██╔╝
        ██████╔╝██║░░██║█████═╝░█████╗░░██║░░██║█████╗░░░╚███╔╝░
        ██╔═══╝░██║░░██║██╔═██╗░██╔══╝░░██║░░██║██╔══╝░░░██╔██╗░
        ██║░░░░░╚█████╔╝██║░╚██╗███████╗██████╔╝███████╗██╔╝╚██╗
        ╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝╚═╝░░╚═╝"
        puts "\nWelcome to your Pokedex.\n\n"
        
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
        puts "\n\n\t☆  M  E  N  U  ☆\n\n"
        #puts "What would you like to see?\n"
        puts "Type \'list\' to list all Pokemon."
        puts "Type a Pokemon name to learn more about that Pokemon."
        puts "Type \'exit\' to close the Pokedex."
        puts "\n"

        navigate_menu
    end

    def navigate_menu
        print "Type your menu option:\t"
        selection = user_input
        puts "\n"

        case selection
        when "list"
            puts "How many pokemon would you like to see at a time?"
            num_pokemon = user_input;
            list_pokemon(1,num_pokemon.to_i)
            menu
        when "exit"
            goodbye
        else
            pokemon_selection(selection)
            menu
        end
    end

    def list_pokemon(i_start, max)
        i_max = max
        Pokemon.all.each.with_index(1) do |pokemon, i|
            if i >= i_start && i < i_max
                puts "#{i}. #{pokemon.name}"
            elsif i == i_max
                puts "#{i}. #{pokemon.name}\n"
                puts "\n<--|'menu'\t <type to navigate>\t'next'|-->\n"

                loop do
                    selection = user_input
                    
                    if selection == 'menu'
                        break
                    elsif selection == 'next'
                        i_max = i_max + max
                        break
                    else
                        puts "Type 'next' or 'menu'"
                    end
                end
            end
        end
    end

    def pokemon_selection(selection)
        pokemon = Pokemon.find_by_name(selection)
        if pokemon != nil
            pokemon.get_data
            pokemon_detail(pokemon) 
        else
            puts "\nHmm, #{selection} is not a valid Pokemon. Try again?"
            menu
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