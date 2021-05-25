class CLI
    MAXID = 1083

    def start
        greeting
        API.get_data
        menu
    end

    def greeting
        puts "\tLoading system..."
        puts "
        ██████╗░░█████╗░██╗░░██╗███████╗██████╗░███████╗██╗░░██╗
        ██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗██╔════╝╚██╗██╔╝
        ██████╔╝██║░░██║█████═╝░█████╗░░██║░░██║█████╗░░░╚███╔╝░
        ██╔═══╝░██║░░██║██╔═██╗░██╔══╝░░██║░░██║██╔══╝░░░██╔██╗░
        ██║░░░░░╚█████╔╝██║░╚██╗███████╗██████╔╝███████╗██╔╝╚██╗
        ╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝╚═╝░░╚═╝"
        puts "\n\tWelcome to your Pokedex.\n\n"
        
    end

    def goodbye
        puts "\tGoodbye, Trainer\n\n"
    end

    def invalid
        puts "\tHmm, that doesn't seem like a valid option, try again?\n"
        menu
    end

    def user_input
        gets.strip.downcase
    end

    def menu
        puts "\n\n\t\t .·: M  E  N  U :·. \n\n"

        puts "\tType \'list\' to list Pokemon names."
        puts "\tType a Pokemon name to learn more about that Pokemon."
        puts "\tType \'exit\' to close the Pokedex."
        puts "\n\t"

        navigate_menu
    end

    def navigate_menu
        print "\tType your menu option:\t"
        selection = user_input
        puts "\n"

        case selection
        when "list"
            print "\tHow many pokemon would you like to see at a time?\n\n\t"
            num_pokemon = user_input;
            puts "\n"
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
            if i == MAXID
                puts "\t#{i}. #{pokemon.name}\n"
                puts "\t\tEND OF LIST\n\n"
                
                puts "\tType a Pokemon's name to see details about that Pokemon.\n"
                print "\tType \'menu\' to return to the main menu.\n\n\t"

                loop do
                    selection = user_input
                    
                    if selection == "menu"
                        break
                    else
                        if !pokemon_selection(selection)
                            puts "\n\tType a Pokemon's name to see details about that Pokemon.\n"
                            print "\tType \'menu\' to return to the main menu.\n\n\t"
                        end
                    end
                end
            elsif i >= i_start && i < i_max
                puts "\t#{i}. #{pokemon.name}"
            elsif i == i_max
                puts "\t#{i}. #{pokemon.name}\n"
                puts "\n\tType 'more' to list #{max} more Pokemon."
                puts "\tType a Pokemon's name to see details about that Pokemon.\n"
                print "\tType \'menu\' to return to the main menu.\n\n\t"

                loop do
                    selection = user_input
                    
                    if selection == "more"
                        i_max = i_max + max
                        puts ""
                        break
                    elsif selection == "menu"
                        break
                    else
                        if !pokemon_selection(selection)
                            puts "\n\tType 'more' to list #{max} more Pokemon."
                            puts "\tType a Pokemon's name to see details about that Pokemon.\n"
                            print "\tType \'menu\' to return to the main menu.\n\n\t"
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
            puts "\n\tHmm, #{selection} is not a valid command or Pokemon name. Try again?"
            nil
        end
    end

    def pokemon_detail(pokemon)
        puts "\n\n\t─────────────── *.·:·.-.·:·.-.·:·.*───────────────"
        puts "\tName:\t #{pokemon.name.capitalize}"
        puts "\tTypes:\t #{pokemon.types.collect {|type| type["type"]["name"]}.join(', ')}"
        puts "\tBase XP: #{pokemon.base_experience}"
        puts "\tAbilities: #{pokemon.abilities.collect {|ability| ability["ability"]["name"]}.join(', ')}"
        puts "\n\t─────────────── *.·:·.-.·:·.-.·:·.*───────────────\n\n"
        puts "\n\tType 'locations' to list locations where #{pokemon.name.capitalize} are found."
        print "\tType 'back' to return to the previous options.\n\n\t"
        pokemon_location(pokemon)
    end

    def pokemon_location(pokemon)
        selection = user_input
        if selection == 'locations'
            puts "\t==========================<<>>=========================="
            puts "\t#{pokemon.name.capitalize} can be found at these locations:\n\n"
            puts "\t#{pokemon.locations.join("\n\t").gsub("-", " ")}"
            if(pokemon.locations.length == 0)
                puts "\t\t\t No locations found!\n"
            end
            puts "\t==========================<<>>=========================="
        elsif selection == 'back'
            print "\n" #do nothing, just line break
        else
            print "\n\tTry typing 'back' to return to menu or 'locations' to see where this pokemon is found\n\n\t"
            pokemon_location(pokemon)
        end
    end
end