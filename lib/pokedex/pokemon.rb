class Pokemon

    @@all = []
    
    def initialize(attributes)
        @got_data = false
        attributes.each do |key, value| 
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        save
    end

    def set_attributes(attributes)
        attributes.each do |key, value| 
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
    end


    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.find do |pokemon|
            pokemon.name == name
        end
    end

    def get_data
        if(@got_data == false)
            set_attributes(API.get_pokemon_data(self.url))
            @got_data = true
        end
    end

end