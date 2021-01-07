class Pokemon

    @@all = [{name:"bulbasaur"}, {name:"charmander"}, {name:"squirtle"}]

    def initialize(attributes)
        self.class.attr_reader(key)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

end