class CLI
    MAXID = 1083

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
        gets.strip.downcase
    end

    def menu
        puts "\n\n\t☆  M  E  N  U  ☆\n\n"

        puts "Type \'list\' to list Pokemon names."
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
            #binding.pry
            if i == MAXID
                puts "#{i}. #{pokemon.name}\n"
                puts "\tEND OF LIST\n\n"
                
                puts "Type a Pokemon's name to see details about that Pokemon.\n"
                puts "Type \'menu\' to return to the main menu.\n\n"

                loop do
                    selection = user_input
                    
                    if selection == "menu"
                        break
                    else
                        if !pokemon_selection(selection)
                            puts "Type a Pokemon's name to see details about that Pokemon.\n"
                            puts "Type \'menu\' to return to the main menu.\n\n"
                        end
                    end
                end
            elsif i >= i_start && i < i_max
                puts "#{i}. #{pokemon.name}"
            elsif i == i_max
                puts "#{i}. #{pokemon.name}\n"
                puts "\nType 'more' to list #{max} more Pokemon."
                puts "Type a Pokemon's name to see details about that Pokemon.\n"
                puts "Type \'menu\' to return to the main menu.\n\n"

                loop do
                    selection = user_input
                    
                    if selection == "more"
                        i_max = i_max + max
                        break
                    elsif selection == "menu"
                        break
                    else
                        if !pokemon_selection(selection)
                            puts "\nType 'more' to list #{max} more Pokemon."
                            puts "Type a Pokemon's name to see details about that Pokemon.\n"
                            puts "Type \'menu\' to return to the main menu.\n\n"
                        end
                    end
                end
            else
                break
            end
        end
    end

    def pokemon_selection(selection)
        pokemon = Pokemon.find_by_name(selection)
        if pokemon != nil
            pokemon.get_data
            pokemon_detail(pokemon) 
        else
            puts "\nHmm, #{selection} is not a valid command or Pokemon name. Try again?"
            nil
        end
    end

    def pokemon_detail(pokemon)
        puts "\n\n─────────────── *.·:·.☆*☆*☆*☆.·:·.*───────────────"
        puts "Name:\t #{pokemon.name.capitalize}"
        puts "Types:\t #{pokemon.types.collect {|type| type["type"]["name"]}.join(', ')}"
        puts "Base XP: #{pokemon.base_experience}"
        puts "Abilities: #{pokemon.abilities.collect {|ability| ability["ability"]["name"]}.join(', ')}"
        puts "\n─────────────── *.·:·.☆*☆*☆*☆.·:·.*───────────────\n\n"
        puts "\nType 'locations' to list locations where #{pokemon.name.capitalize} are found."
        puts "Type 'back' to return to listing Pokemon.\n\n"
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